//
//  LimitInputViewController.m
//  TestDemo
//
//  Created by zhongk on 7/28/15.
//  Copyright (c) 2015 vane.greenisland. All rights reserved.
//

#import "LimitInputViewController.h"
#import "LimitTextInput.h"

@interface LimitInputViewController () <UITextFieldDelegate, UITextViewDelegate>

@end

@implementation LimitInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    UITextField *_textField = [[UITextField alloc] initWithFrame:CGRectMake(50, 100, 220, 30)];
    [_textField setPlaceholder:@"请输入..."];
    [_textField setBorderStyle:UITextBorderStyleRoundedRect];
    [_textField setFont:[UIFont systemFontOfSize:15]];
    [_textField setDelegate:self];
    [self.view addSubview:_textField];
    LimitTextInput *limitTextInput = [[LimitTextInput alloc] initWithFrame:CGRectMake(20, 20, 20, 20) withLimitCount:20];
    [limitTextInput setTextInput:_textField];
    
    
    UITextView *_textView = [[UITextView alloc] initWithFrame:CGRectMake(50, 200, 220, 80)];
    [_textView setBackgroundColor:[UIColor grayColor]];
    [_textView setFont:[UIFont systemFontOfSize:15]];
    [_textView setDelegate:self];
    [self.view addSubview:_textView];
    LimitTextInput *limitTextInput2 = [[LimitTextInput alloc] initWithFrame:CGRectMake(20, 20, 20, 20) withLimitCount:40];
    [limitTextInput2 setTextInput:_textView];
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

@end
