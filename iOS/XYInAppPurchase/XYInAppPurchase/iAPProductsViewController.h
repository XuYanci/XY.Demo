//
//  iAPProductsViewController.h
//  XYInAppPurchase
//
//  Created by Yanci on 17/3/3.
//  Copyright © 2017年 Yanci. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>
@interface iAPProductsViewController : UIViewController
- (id)initWithProducts:(NSArray <SKProduct*>*)products;
@end
