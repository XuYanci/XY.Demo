//
//  YCCustomUIGestureRecognizer.m
//  YCSimpleSliderDrawer
//
//  Created by Yanci on 16/11/30.
//  Copyright © 2016年 Yanci. All rights reserved.
//

#import "YCCustomUIGestureRecognizer.h"
#import <UIKit/UIGestureRecognizerSubclass.h>

@interface YCCustomUIGestureRecognizer()
@property (nonatomic,assign)BOOL strokeUp;
@property (nonatomic,assign)CGPoint midPoint;
@end

@implementation YCCustomUIGestureRecognizer

- (void)reset {
    [super reset];
    self.midPoint = CGPointZero;
    self.strokeUp = NO;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    if ([touches count]!=1) {
        self.state = UIGestureRecognizerStateFailed;
        return;
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    if (self.state == UIGestureRecognizerStateFailed) {
        return;
    }
    CGPoint nowPoint = [touches.anyObject locationInView:self.view];
    CGPoint prePoint = [touches.anyObject previousLocationInView:self.view];
    
    if (!self.strokeUp) {
        if (nowPoint.x >= prePoint.x && nowPoint.y >= prePoint.y) {
            self.midPoint = nowPoint;
        }
        else if(nowPoint.x >= prePoint.x && nowPoint.y <= prePoint.y) {
            self.strokeUp = YES;
        }
        else {
            self.state = UIGestureRecognizerStateFailed;
        }
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    if (self.state == UIGestureRecognizerStatePossible && self.strokeUp)  {
        self.state = UIGestureRecognizerStateRecognized;
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
    self.midPoint = CGPointZero;
    self.strokeUp = NO;
    self.state = UIGestureRecognizerStateFailed;
}

@end
