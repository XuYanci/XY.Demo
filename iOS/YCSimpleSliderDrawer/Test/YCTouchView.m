//
//  YCTouchView.m
//  YCSimpleSliderDrawer
//
//  Created by Yanci on 16/12/6.
//  Copyright © 2016年 Yanci. All rights reserved.
//

#import "YCTouchView.h"

#define DETECT_DOUBLE_GESTURE
//#define TRACK_SWIPE_GESTURE



@implementation YCTouchView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib {
    [super awakeFromNib];
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapInView)];
    tapGR.delegate = self;
    [self addGestureRecognizer:tapGR];
}

- (void)tapInView {
    NSLog(@"%@ , %s",self.identifier,__func__);
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
   // NSLog(@"%@ , %s ",self.identifier,__func__);
    return [super hitTest:point withEvent:event];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
   // NSLog(@"%@ , %s ",self.identifier,__func__);
    BOOL result = [super pointInside:point withEvent:event];
    if (result) {
      //  NSLog(@"YES , I AM THE POINT");
    }
    else {
     //   NSLog(@"NO , I AM THE POINT");
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
    
#ifdef DETECT_DOUBLE_GESTURE
    for (UITouch *aTouch in touches) {
        if (aTouch.tapCount >= 2) {
            // The view responds to the tap
            [self respondToDoubleTapGesture:aTouch];
        }
    }
#endif
    
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%@ , %s",self.identifier, __func__);
}


#pragma mark - 
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return NO;
}
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
//    NSLog(@"%@ , %s",self.identifier, __func__);
//    
//    return YES;
//}
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer NS_AVAILABLE_IOS(7_0) {}
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer NS_AVAILABLE_IOS(7_0) {}
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
//    return YES;
//}
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceivePress:(UIPress *)press {}

#pragma mark - funcs 
- (void)respondToDoubleTapGesture:(UITouch *)touch {
    NSLog(@"%@,%s",self.identifier,__func__);
}
@end
