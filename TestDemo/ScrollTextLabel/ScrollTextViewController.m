//
//  ScrollTextViewController.m
//  TestDemo
//
//  Created by zhongk on 10/28/15.
//  Copyright © 2015 vane.greenisland. All rights reserved.
//

#import "ScrollTextViewController.h"

@interface ScrollTextViewController ()

@end

@implementation ScrollTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    CGFloat height = 45;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 200, CGRectGetWidth(self.view.bounds)-20, height)];
    scrollView.backgroundColor = [UIColor yellowColor];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.bounces = NO;
    [self.view addSubview:scrollView];
    
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    contentLabel.backgroundColor = [UIColor redColor];
    contentLabel.textColor = [UIColor blackColor];
    contentLabel.font = [UIFont systemFontOfSize:14.0];
    
    //set
    NSString *textString = @"国家电网/江苏省电网公司/江苏省电力信息技术有限公司/开发部/综合组";
    contentLabel.text = textString;
    CGSize size = [textString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0]}];
//    if (size.width <= scrollView.frame.size.width) {
        contentLabel.frame = CGRectMake(0, 0, size.width, height);
//    } else {
//        contentLabel.frame = CGRectMake(CGRectGetWidth(scrollView.frame)-size.width, 0, size.width, height);
//    }
    scrollView.contentSize = CGSizeMake(size.width, height);
    [scrollView addSubview:contentLabel];
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
