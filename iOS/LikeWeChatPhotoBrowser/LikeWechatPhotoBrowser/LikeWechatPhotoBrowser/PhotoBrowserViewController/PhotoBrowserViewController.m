//
//  PhotoBrowserViewController.m
//  LikeWechatPhotoBrowser
//
//  Created by Yanci on 16/11/25.
//  Copyright © 2016年 Yanci. All rights reserved.
//

#import "PhotoBrowserViewController.h"

@interface PhotoBrowserViewController ()<UIScrollViewDelegate>
{
    BOOL _isImageDownload;
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


#pragma mark - UIScrolViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _imageView;
}


-(void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width) ? (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5f : 0.f;
    
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height) ? (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5f : 0.f;
    
    self.imageView.center = CGPointMake(scrollView.contentSize.width * 0.5f + offsetX, scrollView.contentSize.height * 0.5f + offsetY);
}

#pragma mark -
- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (!error) {
        NSLog(@"成功保存到相册");
    }
}

#pragma mark - datasource


#pragma mark - user events
- (void)tapInPhotoBrowser:(id)sender {
    NSLog(@"%s",__func__);
    [self dismissWithAnimations];
}

- (void)doubleTapInPhotoBrowser:(id)sender {
    NSLog(@"%s",__func__);
    [self zoomInOut:sender];
}

- (void)longPressInPhotoBrowser:(UILongPressGestureRecognizer *)sender {
    NSLog(@"%s",__func__);
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        if (_isImageDownload) {
            UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
        }
        else {
            NSLog(@"图片未下载完成..");
        }
    }
    else {}
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
    [self.scrollView addSubview:self.indicatorView];
    self.scrollView.delegate = self;
    
    self.imageView.frame = self.scrollView.bounds;
    self.indicatorView.center = self.scrollView.center;
    
    /*!
        Here we capture before image when enter photo browser as our background image,
        user think in the same view
     */
    self.screenCaptureView.image = [self captureFullScreenWhenEnterPhotoBrowser];
}

- (void)relayoutFrameOfSubViews{
  

}

- (void)zoomInOut:(UITapGestureRecognizer *)tapGesture      {
    CGPoint tapPoint = [tapGesture locationInView:self.scrollView];
    if (self.scrollView.zoomScale > 1.f)
    {
        [self.scrollView setZoomScale:1.f animated:YES];
    }
    else
    {
        [self zoomScrollView:self.scrollView toPoint:tapPoint withScale:2.f animated:YES];
    }
}

- (void)swipeOut    {

}


- (void)zoomScrollView:(UIScrollView*)view toPoint:(CGPoint)zoomPoint withScale: (CGFloat)scale animated: (BOOL)animated
{
    //Normalize current content size back to content scale of 1.0f
    CGSize contentSize = CGSizeZero;
    
    contentSize.width = (view.contentSize.width / view.zoomScale);
    contentSize.height = (view.contentSize.height / view.zoomScale);
    
    //translate the zoom point to relative to the content rect
    //jimneylee add compare contentsize with bounds's size
    if (view.contentSize.width < view.bounds.size.width)
    {
        zoomPoint.x = (zoomPoint.x / view.bounds.size.width) * contentSize.width;
    }
    else
    {
        zoomPoint.x = (zoomPoint.x / view.contentSize.width) * contentSize.width;
    }
    if (view.contentSize.height < view.bounds.size.height)
    {
        zoomPoint.y = (zoomPoint.y / view.bounds.size.height) * contentSize.height;
    }
    else
    {
        zoomPoint.y = (zoomPoint.y / view.contentSize.height) * contentSize.height;
    }
    
    //derive the size of the region to zoom to
    CGSize zoomSize = CGSizeZero;
    zoomSize.width = view.bounds.size.width / scale;
    zoomSize.height = view.bounds.size.height / scale;
    
    //offset the zoom rect so the actual zoom point is in the middle of the rectangle
    CGRect zoomRect = CGRectZero;
    zoomRect.origin.x = zoomPoint.x - zoomSize.width / 2.0f;
    zoomRect.origin.y = zoomPoint.y - zoomSize.height / 2.0f;
    zoomRect.size.width = zoomSize.width;
    zoomRect.size.height = zoomSize.height;
    
    //apply the resize
    [view zoomToRect: zoomRect animated: animated];
}

/*! 计算放大后的frame */
- (CGRect)calculateScaledFinalFrame
{
    CGSize thumbSize = _thumbnail.size;
    CGFloat finalHeight = self.view.frame.size.width * (thumbSize.height / thumbSize.width);
    CGFloat top = 0.f;
    if (finalHeight < self.view.frame.size.height)
    {
        top = (self.view.frame.size.height - finalHeight) / 2.f;
    }
    return CGRectMake(0.f, top, self.view.frame.size.width, finalHeight);
}

/*! 显示效果*/
- (void)showWithAnimations {

    CGRect finalRect = [self calculateScaledFinalFrame];
    
    self.imageView.frame = _fromRect;
    self.imageView.image = _thumbnail;
    
    [UIView animateWithDuration:1.0 animations:^{
        self.imageView.frame = finalRect;
        self.screenCaptureView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self.indicatorView startAnimating];
        _isImageDownload = false;
        
        /*! Async download image and display*/
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:_originImageUrl]];
            if (imageData) {
                UIImage *image = [UIImage imageWithData:imageData];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.indicatorView stopAnimating];
                    self.imageView.image = image;
                    _isImageDownload = true;
                });
            }
            else {
                [self.indicatorView stopAnimating];
            }
        });
    }];
}

/*! 隐藏效果 */
- (void)dismissWithAnimations {
    CGRect newFromRect = _fromRect;
    /*! 这里需要考虑到scrollView的ContentOffset */
    newFromRect.origin = CGPointMake(_fromRect.origin.x + self.scrollView.contentOffset.x,
                                     _fromRect.origin.y + self.scrollView.contentOffset.y);
    [UIView animateWithDuration:1.0 animations:^{
        self.imageView.frame = newFromRect;
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
        _scrollView.zoomScale = 1.0;
        _scrollView.minimumZoomScale = 1.0;
        _scrollView.maximumZoomScale = 2.0f;
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
        _indicatorView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    }
    return _indicatorView;
}

@end
