//
//  ConcreteHandler1.m
//  YCSimpleSliderDrawer
//
//  Created by Yanci on 16/12/7.
//  Copyright © 2016年 Yanci. All rights reserved.
//

#import "ConcreteHandler1.h"

@implementation ConcreteHandler1

- (void)HandleRequest {
    if ([self getSuccessor]) {
        [[self getSuccessor] HandleRequest];
    }
    else {
        NSLog(@"IM 1 没有后继了,我自己处理");
    }
}

@end
