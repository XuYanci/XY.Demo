//
//  iAPProductsViewController.m
//  XYInAppPurchase
//
//  Created by Yanci on 17/3/3.
//  Copyright © 2017年 Yanci. All rights reserved.
//

#import "iAPProductsViewController.h"
#import "iAPHelper.h"

@interface iAPProductsViewController () <UITableViewDelegate,UITableViewDataSource,iAPHelperDelegate>
@property (nonatomic,strong) NSArray <SKProduct *>*products;
@property (nonatomic,strong) UITableView *tableView;

@end

@implementation iAPProductsViewController

- (id)initWithProducts:(NSArray <SKProduct*>*)products {
    if (self = [super init]) {
        _products = products;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.tableView];
    self.title = @"可购买产品列表";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"恢复购买"
                                                                             style:UIBarButtonItemStylePlain target:self
                                                                            action:@selector(restore)];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - data source 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.products.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* const identifier = @"CellIdentifier";

    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    SKProduct *product = [self.products objectAtIndex:indexPath.row];
    cell.textLabel.text = product.localizedTitle;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ Coins",product.price.stringValue];
    
    return cell;
}



#pragma mark - iAPHelperDelegate

- (void)showTransactionAsInProgress:(SKPaymentTransaction *)transaction deferred:(BOOL)deffered {
    NSLog(@"%s",__func__);
}

- (void)failedTransaction:(SKPaymentTransaction *)transaction {
      NSLog(@"%s",__func__);
    [[SKPaymentQueue defaultQueue]finishTransaction:transaction];
}

- (void)completeTransaction:(SKPaymentTransaction *)transaction {
      NSLog(@"%s",__func__);
    NSURL *receiptURL = [[NSBundle mainBundle] appStoreReceiptURL];
    NSData *receiptData = [NSData dataWithContentsOfURL:receiptURL];
    [[iAPHelper shareInstance]asyncSendReceiptDataToServer:@"xuyanci" receiptData:receiptData product:transaction.payment.productIdentifier callback:^(NSData *data, NSError *error) {
        [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    }];
}

- (void)restoreTransaction:(SKPaymentTransaction *)transaction {
      NSLog(@"%s",__func__);
}

- (void)iAPHelper:(id)sender progressBuyProduct:(SKPaymentTransaction *)transaction {
    switch (transaction.transactionState) {
            // Call the appropriate custom method for the transaction state.
        case SKPaymentTransactionStatePurchasing:
            [self showTransactionAsInProgress:transaction deferred:NO];
            break;
        case SKPaymentTransactionStateDeferred:
            [self showTransactionAsInProgress:transaction deferred:YES];
            break;
        case SKPaymentTransactionStateFailed:
            [self failedTransaction:transaction];

            break;
        case SKPaymentTransactionStatePurchased:
            [self completeTransaction:transaction];
            break;
        case SKPaymentTransactionStateRestored:
            [self restoreTransaction:transaction];
            break;
        default:
            // For debugging
            NSLog(@"Unexpected transaction state %@", @(transaction.transactionState));
            break;
    }
}

#pragma mark - delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SKProduct *product = [self.products objectAtIndex:indexPath.row];
    [[iAPHelper shareInstance]setDelegate:self];
    [[iAPHelper shareInstance]asyncBuyProduct:product];
}

#pragma mark - funcs 
- (void)restore {
    //[[SKPaymentQueue defaultQueue] restoreCompletedTransactionsWithApplicationUsername:@"xuyanci"];
    [[SKPaymentQueue defaultQueue]restoreCompletedTransactions];
}

#pragma mark - getter and setter 
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}


@end
