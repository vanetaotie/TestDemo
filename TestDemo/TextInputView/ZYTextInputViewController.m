//
//  ZYTextInputViewController.m
//  TestDemo
//
//  Created by vane on 2019/2/18.
//  Copyright © 2019 vane.greenisland. All rights reserved.
//

#import "ZYTextInputViewController.h"
#import "ZYTextInputView.h"

@interface ZYTextInputViewController ()

@property (nonatomic, strong) ZYTextInputView *input;

@end

@implementation ZYTextInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.input = [[ZYTextInputView alloc] init];
    self.input.contentBlock = ^(NSString * _Nonnull text) {
        NSLog(@"发送%@", text);
    };
    [self.view addSubview:self.input];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeTextView)];
    [self.view addGestureRecognizer:tap];
    
    self.input.placeholder = @"回复TUKI:";
}

- (void)closeTextView {
    [self.input hideTextInputView];
}

@end
