//
//  iAPHelper.h
//  XYInAppPurchase
//
//  Created by Yanci on 17/3/3.
//  Copyright © 2017年 Yanci. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
#import <CommonCrypto/CommonCrypto.h>

typedef void(^SendReceiptDataToServerCallback)(NSData *data,NSError *error);

@protocol iAPHelperDelegate <NSObject>
- (void)iAPHelper:(id)sender didFinishGetProducts:(SKProductsResponse *)response;
- (void)iAPHelper:(id)sender progressBuyProduct:(SKPaymentTransaction *)transaction;
@end

@interface iAPHelper : NSObject
@property (nonatomic,weak) id<iAPHelperDelegate>delegate;

+ (id)shareInstance;

/*! 异步获取产品列表 */
- (void)asyncGetProductList;

/*! 异步购买产品 */
- (void)asyncBuyProduct:(SKProduct *)product;

/*! 发送发票给服务器 
    @param username 用户名
    @param receiptData 发票数据
    @param product 产品
 */
- (void)asyncSendReceiptDataToServer:(NSString *)username
                         receiptData:(NSData *)receiptData
                             product:(NSString *)product
                            callback:(SendReceiptDataToServerCallback)callback;
/*!
 *  应用账号名称加密 
 *  @param userAccountName (用户ID)
 *  @return 用户名称加密串
 */
- (NSString *)hashedValueForAccountName:(NSString*)userAccountName;

@end
