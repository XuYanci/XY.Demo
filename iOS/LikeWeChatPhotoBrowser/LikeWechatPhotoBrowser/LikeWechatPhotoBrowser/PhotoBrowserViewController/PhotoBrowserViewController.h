//
//  PhotoBrowserViewController.h
//  LikeWechatPhotoBrowser
//
//  Created by Yanci on 16/11/25.
//  Copyright © 2016年 Yanci. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoBrowserViewController : UIViewController {
    @private
    NSString *_originImageUrl;
    UIImage *_thumbnail;
    CGRect _fromRect;
}

/*!
    初始化图片浏览器 
    @param originImageUrl   原图url
    @param thumbnail        缩略图
    @param rect             原来位置
    @return                 浏览器实例句柄
 */
- (id)initWithParams:(NSString *)originImageUrl
           thumbnail:(UIImage *)thumbnail
            fromRect:(CGRect) rect;


@end
