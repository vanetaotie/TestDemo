//
//  UIKitTestViewController.m
//  TestDemo
//
//  Created by vane on 2019/11/1.
//  Copyright © 2019 vane.greenisland. All rights reserved.
//

#import "UIKitTestViewController.h"
#import "PopView.h"
#import "ZYTextInputView.h"
#import "UIImage+GIF.h"

@interface UIKitTestViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) ZYTextInputView *input;

@end

@implementation UIKitTestViewController
{
    CGFloat mainOffSet;
    UILabel *leftSign;
    UILabel *rightSign;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor greenColor]];
    
    //手势测试
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 60, 40)];
    [btn setBackgroundColor:[UIColor whiteColor]];
    [btn setTitle:@"弹窗" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(popViewTest:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    //ScrollTextView
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    CGFloat height = 45;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 200, CGRectGetWidth(self.view.bounds)-20, height)];
    scrollView.delegate = self;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.bounces = NO;
    [self.view addSubview:scrollView];
    
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    contentLabel.font = [UIFont systemFontOfSize:14.0];
    
    NSString *textString = @"国家电网/江苏省电网公司/江苏省电力信息技术有限公司/开发部/综合组";
    contentLabel.text = textString;
    CGSize size = [textString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0]}];
    
    contentLabel.frame = CGRectMake(0, 0, size.width, height);
    scrollView.contentSize = CGSizeMake(size.width, height);
    if (size.width > scrollView.frame.size.width) {
        mainOffSet = size.width-CGRectGetWidth(scrollView.frame);
        [scrollView setContentOffset:CGPointMake(mainOffSet, 0)];
        //sign
        leftSign = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(scrollView.frame), CGRectGetMinY(scrollView.frame), 15, height)];
        leftSign.text = @"...";
        leftSign.backgroundColor = [UIColor whiteColor];
        leftSign.hidden = NO;
        [self.view addSubview:leftSign];
        
        rightSign = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(scrollView.frame)-15, CGRectGetMinY(scrollView.frame), 15, height)];
        rightSign.text = @"...";
        rightSign.backgroundColor = [UIColor whiteColor];
        rightSign.hidden = YES;
        [self.view addSubview:rightSign];
    }
    
    [scrollView addSubview:contentLabel];
    
    //底部输入框
    self.input = [[ZYTextInputView alloc] init];
    self.input.contentBlock = ^(NSString * _Nonnull text) {
        NSLog(@"发送%@", text);
    };
    [self.view addSubview:self.input];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeTextView)];
    [self.view addGestureRecognizer:tap];
    
    self.input.placeholder = @"回复TUKI:";
    
    //动图测试
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(300, 100, 80, 60)];
    NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"TestFiles/test_gif.gif"];
    NSData *imageData = [NSData dataWithContentsOfFile:path];
    UIImage *image = [UIImage sd_animatedGIFWithData:imageData];
    imageView.image = image;
    [self.view addSubview:imageView];
}

- (void)popViewTest:(UIButton *)btn
{
    PopView *pView = [[PopView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:pView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offSet = scrollView.contentOffset.x;
    NSLog(@"offSet:%f",offSet);
    if (offSet >= mainOffSet) {
        NSLog(@"已经滑到最右边");
        leftSign.hidden = NO;
        rightSign.hidden = YES;
        return;
    } else if (offSet == 0) {
        NSLog(@"已经滑到最左边");
        leftSign.hidden = YES;
        rightSign.hidden = NO;
        return;
    }
    leftSign.hidden = NO;
    rightSign.hidden = NO;
}

- (void)closeTextView {
    [self.input hideTextInputView];
}

@end
