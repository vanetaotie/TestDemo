//
//  ZYPasswordViewController.m
//  TestDemo
//
//  Created by vane on 2019/10/9.
//  Copyright © 2019 vane.greenisland. All rights reserved.
//

#import "ZYPasswordViewController.h"
#import "ZYPasswordView.h"

@interface ZYPasswordViewController ()

@property (nonatomic, strong) ZYPasswordView *pasView;

@end

@implementation ZYPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.pasView = [[ZYPasswordView alloc] initWithFrame:CGRectMake(16, 100, self.view.frame.size.width - 32, 45)];
    [self.view addSubview:self.pasView];
}

@end
