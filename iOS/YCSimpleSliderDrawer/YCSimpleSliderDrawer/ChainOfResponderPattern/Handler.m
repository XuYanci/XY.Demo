//
//  Handler.m
//  YCSimpleSliderDrawer
//
//  Created by Yanci on 16/12/7.
//  Copyright © 2016年 Yanci. All rights reserved.
//

#import "Handler.h"

@implementation Handler

- (void)setSuccessor:(Handler *)succ {
    _succ = succ;
}

- (Handler *)getSuccessor {
    return _succ;
}

- (void)HandleRequest {}
@end
