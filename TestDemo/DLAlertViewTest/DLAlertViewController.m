//
//  DLAlertViewController.m
//  TestDemo
//
//  Created by zhongk on 5/18/15.
//  Copyright (c) 2015 vane.greenisland. All rights reserved.
//

#import "DLAlertViewController.h"
#import "DLAlertView.h"

@implementation DLAlertViewController

- (void)viewDidLoad
{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(120, 100, 80, 50)];
    [button1 setBackgroundColor:[UIColor blueColor]];
    [button1 setTitle:@"文本" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(btnClick1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(120, 200, 80, 50)];
    [button2 setBackgroundColor:[UIColor blueColor]];
    [button2 setTitle:@"图片" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(btnClick2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    UIButton *button3 = [[UIButton alloc] initWithFrame:CGRectMake(120, 300, 80, 50)];
    [button3 setBackgroundColor:[UIColor blueColor]];
    [button3 setTitle:@"视频" forState:UIControlStateNormal];
    [button3 addTarget:self action:@selector(btnClick3) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
    
    UIButton *button4 = [[UIButton alloc] initWithFrame:CGRectMake(120, 400, 80, 50)];
    [button4 setBackgroundColor:[UIColor blueColor]];
    [button4 setTitle:@"链接" forState:UIControlStateNormal];
    [button4 addTarget:self action:@selector(btnClick4) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button4];
}

- (void)btnClick1
{
    DLAlertView *alert = [[DLAlertView alloc] initWithBlock:^(BOOL isConfirm, DLAlertView *view){
        
        if (isConfirm) {
            NSLog(@"confirm");
        } else {
            NSLog(@"cancel");
        }
        
    }andType:kDLAlertViewTypeText title:nil image:nil content:@"2.2GHz 四核 Intel "];
    [alert show];
}

- (void)btnClick2
{
    UIImage *image = [UIImage imageNamed:@"Screen_Shot"];
    DLAlertView *alert = [[DLAlertView alloc] initWithBlock:^(BOOL isConfirm, DLAlertView *view){
        
        if (isConfirm) {
            NSLog(@"confirm");
        } else {
            NSLog(@"cancel");
        }
        
    }andType:kDLAlertViewTypeImage title:nil image:image content:nil];
    [alert show];
}

- (void)btnClick3
{
    UIImage *image = [UIImage imageNamed:@"page"];
    DLAlertView *alert = [[DLAlertView alloc] initWithBlock:^(BOOL isConfirm, DLAlertView *view){
        
        if (isConfirm) {
            NSLog(@"confirm");
        } else {
            NSLog(@"cancel");
        }
        
    }andType:kDLAlertViewTypeVideo title:nil image:image content:nil];
    [alert show];
}

- (void)btnClick4
{
    UIImage *image = [UIImage imageNamed:@"Screen_Shot"];
    DLAlertView *alert = [[DLAlertView alloc] initWithBlock:^(BOOL isConfirm, DLAlertView *view){
        
        if (isConfirm) {
            NSLog(@"confirm");
        } else {
            NSLog(@"cancel");
        }
        
    }andType:kDLAlertViewTypeLink title:@"如何正确选择手机如何正确选择手机如何正确选择手机如何正确选择手机如何正确选择手机" image:image content:@"2.2GHz 四核 Intel如何正确选择手机如何正确选择手机如何正确选择手机如何正确选择手机如何正确选择手机如何正确选择手机如何正确选择手机"];
    [alert show];
}

- (void)dealloc
{
    NSLog(@"dealloc");
}

@end
