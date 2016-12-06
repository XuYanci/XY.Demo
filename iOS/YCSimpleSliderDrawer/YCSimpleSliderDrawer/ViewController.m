//
//  ViewController.m
//  YCSimpleSliderDrawer
//
//  Created by Yanci on 16/11/30.
//  Copyright © 2016年 Yanci. All rights reserved.
//

#import "ViewController.h"
#import "YCTouchView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
   

    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    /*! Simulate hittest */
    self.touchViewA.identifier = @"A";
    self.touchViewB.identifier = @"B";
    self.touchViewC.identifier = @"C";
    self.touchViewD.identifier = @"D";
    self.touchViewE.identifier = @"E";

    UIView *hittestView = [self Hit_Testing_Think: [UIApplication sharedApplication].keyWindow];
    if ([hittestView isKindOfClass:[YCTouchView class]]) {
        NSLog(@"%@",((YCTouchView *)hittestView).identifier);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - funcs

- (UIView *)Hit_Testing_Think:(UIView *)view {
    if ([view isKindOfClass:[YCTouchView class]]) {
        NSLog(@"%@",((YCTouchView *)view).identifier);
    }
    for (UIView *subView in view.subviews) {
        NSLog(@"Recurse search SubView %@",[(YCTouchView *)subView identifier]);
    
        if ([self pointInSide:subView]) {
            return [self Hit_Testing_Think:subView];
        }
    }
    return view;
}

- (BOOL)pointInSide:(UIView *)view {
    /*! This Like HitTest Condition, But check if point in view */
    if (view.subviews.count > 0) {
        return true;
    }
    return false;
}

@end
