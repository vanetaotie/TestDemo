//
//  FloatWindowViewController.m
//  TestDemo
//
//  Created by vane on 15/2/27.
//  Copyright (c) 2015年 vane.greenisland. All rights reserved.
//

#import "FloatWindowViewController.h"
#import "PopView.h"

@implementation FloatWindowViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor yellowColor]];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 60, 40)];
    [btn setBackgroundColor:[UIColor whiteColor]];
    [btn setTitle:@"弹窗" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(popViewTest:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)popViewTest:(UIButton *)btn
{
    PopView *pView = [[PopView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:pView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
