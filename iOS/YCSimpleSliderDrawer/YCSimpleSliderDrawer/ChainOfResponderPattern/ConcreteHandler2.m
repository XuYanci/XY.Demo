//
//  ConcreteHandler2.m
//  YCSimpleSliderDrawer
//
//  Created by Yanci on 16/12/7.
//  Copyright © 2016年 Yanci. All rights reserved.
//

#import "ConcreteHandler2.h"

@implementation ConcreteHandler2


- (void)HandleRequest {
    if ([self getSuccessor]) {
        [[self getSuccessor] HandleRequest];
    }
    else {
        NSLog(@"IM 2 没有后继了,我自己处理");
    }
}


@end
