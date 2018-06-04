//
//  TDWNavigationViewController.m
//  TDWOrientationDemo
//
//  Created by Yanci on 2018/5/10.
//  Copyright © 2018年 tdw. All rights reserved.
//

#import "TDWNavigationViewController.h"
#import "ViewController1.h"
@interface TDWNavigationViewController ()

@end

@implementation TDWNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 6.0后
- (BOOL)shouldAutorotate
{
    if ([self.viewControllers.lastObject isKindOfClass:[ViewController1 class]]) {
        BOOL rorate = [self.viewControllers.lastObject shouldAutorotate];
        return rorate;
    }
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    if ([self.viewControllers.lastObject isKindOfClass:[ViewController1 class]]) {
        return [self.viewControllers.lastObject supportedInterfaceOrientations];
    }
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    if ([self.viewControllers.lastObject isKindOfClass:[ViewController1 class]]) {
        return [self.viewControllers.lastObject preferredInterfaceOrientationForPresentation];
    }
    return UIInterfaceOrientationPortrait;
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
