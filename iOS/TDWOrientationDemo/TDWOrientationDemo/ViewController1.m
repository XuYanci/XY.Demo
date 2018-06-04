//
//  ViewController1.m
//  TDWOrientationDemo
//
//  Created by Yanci on 2018/5/10.
//  Copyright © 2018年 tdw. All rights reserved.
//

#import "ViewController1.h"
#import "ViewController2.h"
#import "TDWNavigationViewController.h"
@interface ViewController1 ()

@end

@implementation ViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
      self.view.backgroundColor = [UIColor blueColor];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 30)];
    [btn setTitle:@"aaaa" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(addAutoTender:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addAutoTender:(id)sender  {
    ViewController2 *vc = [[ViewController2 alloc]init];
    vc.view.backgroundColor = [UIColor blueColor];
    [self presentViewController: [[UINavigationController alloc]initWithRootViewController:vc] animated:true completion:nil];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait ;
}



-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait ;
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
