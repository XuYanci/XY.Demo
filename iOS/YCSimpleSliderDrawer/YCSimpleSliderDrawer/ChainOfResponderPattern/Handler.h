//
//  Handler.h
//  YCSimpleSliderDrawer
//
//  Created by Yanci on 16/12/7.
//  Copyright © 2016年 Yanci. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Handler : NSObject {
    @private
    Handler *_succ;
}
- (void)HandleRequest;
- (void)setSuccessor:(Handler *)succ;
- (Handler *)getSuccessor;
@end
