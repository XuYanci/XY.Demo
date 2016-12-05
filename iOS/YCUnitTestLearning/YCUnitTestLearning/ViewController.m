//
//  ViewController.m
//  YCUnitTestLearning
//
//  Created by Yanci on 16/12/1.
//  Copyright © 2016年 Yanci. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    [self.aBtn addTarget:self action:@selector(a:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.bBtn addTarget:self action:@selector(b:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.cBtn addTarget:self action:@selector(c:) forControlEvents:UIControlEventTouchUpInside];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)a:(id)sender {
    NSLog(@"a");
}


- (void)b:(id)sender {
     NSLog(@"b");
}


- (void)c:(id)sender {
     NSLog(@"c");
}

@end


