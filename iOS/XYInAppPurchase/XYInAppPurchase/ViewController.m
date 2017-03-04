//
//  ViewController.m
//  XYInAppPurchase
//
//  Created by Yanci on 17/3/3.
//  Copyright © 2017年 Yanci. All rights reserved.
//

#import "ViewController.h"
#import "iAPHelper.h"
#import "iAPProductsViewController.h"

@interface ViewController () <iAPHelperDelegate>
@property (nonatomic,strong)iAPHelper *helper;
@property (nonatomic,strong)NSArray <SKProduct *>*products;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"InAppPurchase Demo";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)validateProductIdentifiers:(id)sender {
    _helper = [[iAPHelper alloc]init];
    _helper.delegate = self;
    [_helper asyncGetProductList];
}

- (void)displayStoreUI {
    iAPProductsViewController *productsViewController = [[iAPProductsViewController alloc] initWithProducts:self.products];
    [self.navigationController pushViewController:productsViewController animated:YES];
}

#pragma mark - iAPHelperDelegate
- (void)iAPHelper:(id)sender didFinishGetProducts:(SKProductsResponse *)response {
    self.products = response.products;
    [self displayStoreUI];
}

- (void)iAPHelper:(id)sender progressBuyProduct:(SKPaymentTransaction *)transaction {

}


@end
