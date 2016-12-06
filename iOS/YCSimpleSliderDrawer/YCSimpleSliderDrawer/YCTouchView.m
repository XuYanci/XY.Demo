//
//  YCTouchView.m
//  YCSimpleSliderDrawer
//
//  Created by Yanci on 16/12/6.
//  Copyright © 2016年 Yanci. All rights reserved.
//

#import "YCTouchView.h"

@implementation YCTouchView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    NSLog(@"%@ , %s ",self.identifier,__func__);
    return [super hitTest:point withEvent:event];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    NSLog(@"%@ , %s ",self.identifier,__func__);
    BOOL result = [super pointInside:point withEvent:event];
    if (result) {
        NSLog(@"YES , I AM THE POINT");
    }
    else {
        NSLog(@"NO , I AM THE POINT");
    }
    return result;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%@ , %s",self.identifier, __func__);
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%@ , %s",self.identifier, __func__);
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%@ , %s",self.identifier, __func__);
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%@ , %s",self.identifier, __func__);
}


@end
