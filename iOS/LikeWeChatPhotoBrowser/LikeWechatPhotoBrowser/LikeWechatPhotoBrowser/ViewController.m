//
//  ViewController.m
//  LikeWechatPhotoBrowser
//
//  Created by Yanci on 16/11/25.
//  Copyright © 2016年 Yanci. All rights reserved.
//

#import "ViewController.h"
#import "PhotoBrowserViewController.h"

#define IMG_ORIGIN__PATH        @"http://cdn.duitang.com/uploads/item/201603/30/20160330104446_CsnF8.thumb.700_0.jpeg"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /*! Add Gesture to the bubble image view */
    UITapGestureRecognizer *gr = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                         action:@selector(tapInBubbleImageView)];
    _bubbleImageView.userInteractionEnabled = YES;
    [_bubbleImageView addGestureRecognizer:gr];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    /*! 实现气泡效果 */
    UIImage *contentBackImage = nil;
    CAShapeLayer *_shapeLayer = [[CAShapeLayer alloc]init];
    [_bubbleImageView.layer addSublayer:_shapeLayer];
    
    contentBackImage = [UIImage imageNamed:@"chat_qpy"];
    _shapeLayer.contents = (id)contentBackImage.CGImage;
    _shapeLayer.contentsScale = [UIScreen mainScreen].scale;
    
    _shapeLayer.contentsCenter = CGRectMake(0.1, 0.6, 0.1, 0.1);
    _shapeLayer.frame = _bubbleImageView.bounds;
    _bubbleImageView.layer.mask = _shapeLayer;
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - user events
- (void)tapInBubbleImageView {
    
    /*! 获取相对坐标 */
    CGRect rect = [_bubbleImageView convertRect:_bubbleImageView.bounds toView:self.view];
    PhotoBrowserViewController *vc = [[PhotoBrowserViewController alloc]initWithParams:IMG_ORIGIN__PATH thumbnail:_bubbleImageView.image fromRect:rect];
    [self presentViewController:vc animated:NO completion:nil];
}


@end
