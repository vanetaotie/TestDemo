//
//  ScrollTextViewController.m
//  TestDemo
//
//  Created by zhongk on 10/28/15.
//  Copyright © 2015 vane.greenisland. All rights reserved.
//

#import "ScrollTextViewController.h"

@interface ScrollTextViewController () <UIScrollViewDelegate>

@end

@implementation ScrollTextViewController
{
    CGFloat mainOffSet;
    UILabel *leftSign;
    UILabel *rightSign;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    CGFloat height = 45;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 200, CGRectGetWidth(self.view.bounds)-20, height)];
    scrollView.delegate = self;
//    scrollView.backgroundColor = [UIColor yellowColor];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.bounces = NO;
    [self.view addSubview:scrollView];
    
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
//    contentLabel.backgroundColor = [UIColor redColor];
    contentLabel.font = [UIFont systemFontOfSize:14.0];
    
    //set
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
