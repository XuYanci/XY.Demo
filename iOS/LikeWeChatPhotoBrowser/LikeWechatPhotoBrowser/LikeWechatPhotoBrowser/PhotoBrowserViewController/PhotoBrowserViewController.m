//
//  PhotoBrowserViewController.m
//  LikeWechatPhotoBrowser
//
//  Created by Yanci on 16/11/25.
//  Copyright © 2016年 Yanci. All rights reserved.
//

#import "PhotoBrowserViewController.h"

@interface PhotoBrowserViewController () {
    
}


@property (nonatomic,strong)UIImageView *screenCaptureView;
@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong)UIImageView *imageView;
@property (nonatomic,strong)UIActivityIndicatorView *indicatorView;

/*! 单击手势 */
@property (nonatomic,strong)UITapGestureRecognizer *tapGestureRecognizer;
/*! 双击手势 */
@property (nonatomic,strong)UITapGestureRecognizer *doubleTapGestureRecognizer;
/*! 长按手势 */
@property (nonatomic,strong)UILongPressGestureRecognizer *longpressGestureRecognizer;
@end

@implementation PhotoBrowserViewController


#pragma mark - life cycle
- (id)initWithParams:(NSString *)originImageUrl
           thumbnail:(UIImage *)thumbnail
            fromRect:(CGRect) rect {
    if (self = [super init]) {
        _originImageUrl = originImageUrl;
        _thumbnail = thumbnail;
        _fromRect = rect;
        
        [self configUI];
        [self configEnv];
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self showWithAnimations];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark - delegate 


#pragma mark - datasource


#pragma mark - user events
- (void)tapInPhotoBrowser:(id)sender {
    NSLog(@"%s",__func__);
    [self dismissWithAnimations];
}

- (void)doubleTapInPhotoBrowser:(id)sender {
    NSLog(@"%s",__func__);
}

- (void)longPressInPhotoBrowser:(id)sender {
    NSLog(@"%s",__func__);
}

#pragma mark - funcs

- (void)configEnv {
    _tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapInPhotoBrowser:)];
    _tapGestureRecognizer.numberOfTapsRequired = 1;
    [self.scrollView addGestureRecognizer:_tapGestureRecognizer];
    
    _doubleTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleTapInPhotoBrowser:)];
    _doubleTapGestureRecognizer.numberOfTapsRequired = 2;
    [_tapGestureRecognizer requireGestureRecognizerToFail:_doubleTapGestureRecognizer];
    [self.scrollView addGestureRecognizer:_doubleTapGestureRecognizer];
    
    _longpressGestureRecognizer = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressInPhotoBrowser:)];
    [self.scrollView addGestureRecognizer:_longpressGestureRecognizer];
}

- (void)configUI  {
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.screenCaptureView];
    
    [self.scrollView addSubview:self.imageView];
    self.imageView.frame = self.scrollView.bounds;
    
    
    /*!
        Here we capture before image when enter photo browser as our background image,
        user think in the same view
     */
    self.screenCaptureView.image = [self captureFullScreenWhenEnterPhotoBrowser];
}

- (void)relayoutFrameOfSubViews{}

- (void)zoomIn      {}
- (void)zoomOut     {}
- (void)swipeOut    {}


/*! 显示效果*/
- (void)showWithAnimations {
    
    /*!TODO: Caculate final rect */
    CGRect finalRect = CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height / 2.0);
    
    self.imageView.frame = _fromRect;
    self.imageView.image = _thumbnail;
    
    [UIView animateWithDuration:1.0 animations:^{
        self.imageView.frame = finalRect;
        self.screenCaptureView.alpha = 0.0;
    } completion:^(BOOL finished) {
        
    }];
}

/*! 隐藏效果 */
- (void)dismissWithAnimations {
    
    [UIView animateWithDuration:1.0 animations:^{
        self.imageView.frame = _fromRect;
        self.screenCaptureView.alpha = 1.0;
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}

#pragma mark - getter and setter 

/*!
 截屏进入图片浏览器之前的屏幕
 */
- (UIImage *)captureFullScreenWhenEnterPhotoBrowser {
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, self.view.opaque, 0.0);
    [[UIApplication sharedApplication].keyWindow drawViewHierarchyInRect:self.view.bounds afterScreenUpdates:NO];
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;

}

- (UIScrollView*)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    }
    return _scrollView;
}

- (UIImageView *)screenCaptureView {
    if (!_screenCaptureView) {
        _screenCaptureView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    }
    return _screenCaptureView;
}


- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
    }
    return _imageView;
}


- (UIActivityIndicatorView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc]init];
    }
    return _indicatorView;
}

@end
