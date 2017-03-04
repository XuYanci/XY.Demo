//
//  iAPHelper.m
//  XYInAppPurchase
//
//  Created by Yanci on 17/3/3.
//  Copyright © 2017年 Yanci. All rights reserved.
//

#import "iAPHelper.h"

static iAPHelper *_instance;

@interface iAPHelper () <SKProductsRequestDelegate,SKPaymentTransactionObserver>
@property (nonatomic,strong) SKProductsRequest *request;
- (NSArray *)getProductIdentifiers; /*! 获取产品标识列表 */
- (void)validateProductIdentifiers:(NSArray *)productIdentifiers; /*! 验证产品标识 */
@end

@implementation iAPHelper

/**
 * 单例
 */
+ (id)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[iAPHelper alloc]init];
    });
    return _instance;
}

/**
 * 异步获取产品列表
 */
- (void)asyncGetProductList {
    [self validateProductIdentifiers:[self getProductIdentifiers]];
}

/**
 * 异步购买产品
 */
- (void)asyncBuyProduct:(SKProduct *)product {
    SKMutablePayment *payment = [SKMutablePayment paymentWithProduct:product];
    payment.quantity = 1;
    payment.applicationUsername = @"xuyanci";
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}

- (void)asyncSendReceiptDataToServer:(NSString *)username
                         receiptData:(NSData *)receiptData
                             product:(NSString *)product
                            callback:(SendReceiptDataToServerCallback)callback{
    NSString *_username = username;
    NSData *_receiptData  = receiptData;
    NSString *_product = product;
    
    ///////////////////////// STEP ONE ///////////////////////////
    /* 
     Post receipt to server
     Here ignore ...
     
     server receive username , receiptdata , product 
     do some record or other process
     */

    ///////////////////////// STEP TWO ///////////////////////////
    /* 
      Simulate when server get the post request
     */
    NSData *receipt = _receiptData; // Sent to the server by the device
    
    // Create the JSON object that describes the request
    NSError *error;
    NSDictionary *requestContents = @{
                                      @"receipt-data": [receipt base64EncodedStringWithOptions:0]
                                      };
    NSData *requestData = [NSJSONSerialization dataWithJSONObject:requestContents
                                                          options:0
                                                            error:&error];
    
    if (!requestData) { /* ... Handle error ... */ }
    
    // Create a POST request with the receipt data.
    NSURL *storeURL = [NSURL URLWithString:@"https://sandbox.itunes.apple.com/verifyReceipt"];
    NSMutableURLRequest *storeRequest = [NSMutableURLRequest requestWithURL:storeURL];
    [storeRequest setHTTPMethod:@"POST"];
    [storeRequest setHTTPBody:requestData];
    
    // Make a connection to the iTunes Store on a background queue.
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:storeRequest queue:queue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               if (connectionError) {
                                   /* ... Handle error ... */
                                   if (callback) {
                                       callback(data,error);
                                   }
                                   
                               } else {
                                   NSError *error;
                                   NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                                   if (!jsonResponse) { /* ... Handle error ...*/
                                       if (callback) {
                                           callback(data,error);
                                       }
                                   }
                                   /* ... Send a response back to the device ... */
                                   if (callback) {
                                       callback(data,error);
                                   }
                               }
                           }];
}

#pragma mark - SKProductsRequestDelegate
- (void)productsRequest:(SKProductsRequest *)request
     didReceiveResponse:(SKProductsResponse *)response {
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(iAPHelper:didFinishGetProducts:)]) {
        [self.delegate iAPHelper:self didFinishGetProducts:response];
    }
}


#pragma mark - SKPaymentTransactionObserver
- (void)paymentQueue:(SKPaymentQueue *)queue
 updatedTransactions:(NSArray *)transactions
{
    for (SKPaymentTransaction *transaction in transactions) {

        if (self.delegate!=nil && [self.delegate respondsToSelector:@selector(iAPHelper:progressBuyProduct:)]) {
            [self.delegate iAPHelper:self progressBuyProduct:transaction];
        }
    }
}

- (void)paymentQueue:(SKPaymentQueue *)queue removedTransactions:(NSArray<SKPaymentTransaction *> *)transactions {
    
}

- (void)paymentQueue:(SKPaymentQueue *)queue restoreCompletedTransactionsFailedWithError:(NSError *)error {
    
}

- (void)paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue {
    
}

- (void)paymentQueue:(SKPaymentQueue *)queue updatedDownloads:(NSArray<SKDownload *> *)downloads {
    
}

#pragma mark - private funcs
/**
 * 获取产品标识
 */
- (NSArray *)getProductIdentifiers {
    NSURL *url = [[NSBundle mainBundle]URLForResource:@"product_ids" withExtension:@"plist"];
    NSArray *productIdentifiers = [NSArray arrayWithContentsOfURL:url];
    return productIdentifiers;
}

/**
 * 验证产品标识
 */
- (void)validateProductIdentifiers:(NSArray *)productIdentifiers {
    SKProductsRequest *productsRequest = [[SKProductsRequest alloc]
                                          initWithProductIdentifiers:[NSSet setWithArray:productIdentifiers]];
    // Keep a strong reference to the request.
    self.request = productsRequest;
    productsRequest.delegate = self;
    [productsRequest start];
}

/**
 * 用户名称加密
 */
- (NSString *)hashedValueForAccountName:(NSString*)userAccountName
{
    const int HASH_SIZE = 32;
    unsigned char hashedChars[HASH_SIZE];
    const char *accountName = [userAccountName UTF8String];
    size_t accountNameLen = strlen(accountName);
    
    // Confirm that the length of the user name is small enough
    // to be recast when calling the hash function.
    if (accountNameLen > UINT32_MAX) {
        NSLog(@"Account name too long to hash: %@", userAccountName);
        return nil;
    }
    CC_SHA256(accountName, (CC_LONG)accountNameLen, hashedChars);
    
    // Convert the array of bytes into a string showing its hex representation.
    NSMutableString *userAccountHash = [[NSMutableString alloc] init];
    for (int i = 0; i < HASH_SIZE; i++) {
        // Add a dash every four bytes, for readability.
        if (i != 0 && i%4 == 0) {
            [userAccountHash appendString:@"-"];
        }
        [userAccountHash appendFormat:@"%02x", hashedChars[i]];
    }    
    return userAccountHash;
}

@end
