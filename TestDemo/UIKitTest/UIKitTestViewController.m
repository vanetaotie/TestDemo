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
#import "NSString+OpenAndClose.h"

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
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
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

//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeTextView)];
//    [self.view addGestureRecognizer:tap];

    self.input.placeholder = @"回复TUKI:";

    //动图测试
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(300, 100, 80, 60)];
    NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"TestFiles/test_gif.gif"];
    NSData *imageData = [NSData dataWithContentsOfFile:path];
    UIImage *image = [UIImage sd_animatedGIFWithData:imageData];
    imageView.image = image;
    [self.view addSubview:imageView];
    
    //折叠文本
    UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 300, 200, 0)];
    lbl.font = [UIFont systemFontOfSize:16];
    lbl.textColor = [UIColor blackColor];
    lbl.backgroundColor = [UIColor redColor];
    lbl.numberOfLines = 0;
    [self.view addSubview:lbl];
    
    //关闭
    lbl.attributedText = [@"测试测试测试测试测试测试测试测试测\n试测test试测试测试测试测试测试测试test测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测test试测试" getAttributeStrWithLblWidth:200 font:[UIFont systemFontOfSize:16] lineSpacing:5 paragraphSpacing:10 lineBreakMode:NSLineBreakByWordWrapping closeLineNum:3 openState:NO];
    //展开
//    lbl.attributedText = [@"测试测试测试测试测试测试测试测试测\n试测test试测试测试测试测试测试测试test测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测test试测试" getAttributeStrWithLblWidth:200 font:[UIFont systemFontOfSize:16] lineSpacing:5 paragraphSpacing:10 lineBreakMode:NSLineBreakByWordWrapping closeLineNum:3 openState:YES];
    
    //调整frame
    [lbl sizeToFit];
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(100, 400, 100, 100)];
    view1.backgroundColor = UIColor.brownColor;
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(view1Touch)];
    [view1 addGestureRecognizer:tap1];
//    [self.view addSubview:view1];
    
    AdjustPointButton *button1 = [[AdjustPointButton alloc] initWithFrame:CGRectMake(100, 400, 100, 100)];
    [button1 setBackgroundColor:UIColor.brownColor];
    [button1 addTarget:self action:@selector(view1Touch) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    AdjustPointView *view2 = [[AdjustPointView alloc] initWithFrame:CGRectMake(50, 50, 100, 100)];
    view2.backgroundColor = UIColor.greenColor;
//    view2.userInteractionEnabled = NO;
    [button1 addSubview:view2];
}

- (void)view1Touch {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"touch" message:@"touch" delegate:self cancelButtonTitle:@"yes" otherButtonTitles:nil, nil];
    [alert show];
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

@implementation AdjustPointButton


@end

@implementation AdjustPointView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *view = [super hitTest:point withEvent:event];
    if (view == self) {
        return nil;
    }
    return view;
}

@end
