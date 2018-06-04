//
//  ViewController.m
//  TDWOrientationDemo
//
//  Created by Yanci on 2018/5/10.
//  Copyright © 2018年 tdw. All rights reserved.
//

#import "ViewController.h"
#import "ViewController1.h"
@interface ViewController ()

@end

@implementation ViewController
- (IBAction)addAutoTender:(id)sender  {
    ViewController1 *vc1 =  [[ViewController1 alloc]init];
    [self.navigationController pushViewController:vc1 animated:true];
 
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 30)];
    [btn setTitle:@"aaaa" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(addAutoTender:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
