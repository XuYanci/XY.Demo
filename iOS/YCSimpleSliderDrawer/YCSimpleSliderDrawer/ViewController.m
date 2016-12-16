//
//  ViewController.m
//  YCSimpleSliderDrawer
//
//  Created by Yanci on 16/11/30.
//  Copyright © 2016年 Yanci. All rights reserved.
//

#import "ViewController.h"
#import "YCTouchView.h"
#import "Handler.h"
#import "ConcreteHandler1.h"
#import "ConcreteHandler2.h"

//#define TEST_RESPONDER_PATTERN
#define TEST_HITTEST_SIMULATE

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
#ifdef TEST_HITTEST_SIMULATE
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
#endif
 
#ifdef TEST_RESPONDER_PATTERN
    Handler *h1 = [[ConcreteHandler1 alloc]init];
    Handler *h2 = [[ConcreteHandler2 alloc]init];
    
    [h1 setSuccessor:h2];
    [h1 HandleRequest];
#endif
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
