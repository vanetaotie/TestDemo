//
//  GAndATestViewController.m
//  TestDemo
//
//  Created by zhongk on 6/2/15.
//  Copyright (c) 2015 vane.greenisland. All rights reserved.
//

#import "GAndATestViewController.h"
#import "GraphicsTestView.h"
#import "AnimationTestView.h"

@interface GAndATestViewController ()

@property (nonatomic, strong) UIView *topView;
@property (strong, nonatomic) UIPageViewController *pageController;
@property (strong, nonatomic) UIViewController *vc1;
@property (strong, nonatomic) UIViewController *vc2;

@end

@implementation GAndATestViewController

- (void)viewDidLoad
{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self.view addSubview:self.topView];
    
    [self addChildViewController:self.pageController];
    [self.view addSubview:self.pageController.view];
    self.vc1 = [[UIViewController alloc] init];
    self.vc1.view.backgroundColor = UIColor.brownColor;
    self.vc2 = [[UIViewController alloc] init];
    self.vc2.view.backgroundColor = UIColor.cyanColor;
    NSArray *array = @[self.vc1, self.vc2];
    [self.pageController setViewControllers:@[[array objectAtIndex:1]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    UIButton *tempbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    tempbtn.frame = CGRectMake(100, 80, 100, 30);
    [tempbtn setTitle:@"向上移动" forState:UIControlStateNormal];
    [tempbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [tempbtn addTarget:self action:@selector(moveView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tempbtn];
    
    UIButton *tempbtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    tempbtn2.frame = CGRectMake(self.view.bounds.size.width - 200, 80, 100, 30);
    [tempbtn2 setTitle:@"向下移动" forState:UIControlStateNormal];
    [tempbtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [tempbtn2 addTarget:self action:@selector(moveView2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tempbtn2];
}

- (void)moveView {
    UIView *scrollv = nil;
    for (UIView *v in self.pageController.view.subviews) {
        v.backgroundColor = [UIColor blackColor];
        scrollv = v;
    }
    
    [UIView animateWithDuration:2 animations:^{
        self.topView.frame = CGRectMake(0, 100, self.view.bounds.size.width, 100);
        self.pageController.view.frame = CGRectMake(0, CGRectGetMaxY(self.topView.frame), self.view.bounds.size.width, self.view.bounds.size.height - CGRectGetMaxY(self.topView.frame)-50);
        scrollv.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - CGRectGetMaxY(self.topView.frame)-50);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)moveView2 {
    UIView *scrollv = nil;
    for (UIView *v in self.pageController.view.subviews) {
        v.backgroundColor = [UIColor blackColor];
        scrollv = v;
    }
    
    [UIView animateWithDuration:2 animations:^{
        self.topView.frame = CGRectMake(0, 250, self.view.bounds.size.width, 100);
        self.pageController.view.frame = CGRectMake(0, CGRectGetMaxY(self.topView.frame), self.view.bounds.size.width, self.view.bounds.size.height - CGRectGetMaxY(self.topView.frame)-50);
        scrollv.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - CGRectGetMaxY(self.topView.frame)-50);
    } completion:^(BOOL finished) {
        
    }];
}

- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 250, self.view.bounds.size.width, 100)];
        _topView.backgroundColor = [UIColor greenColor];
    }
    return _topView;
}

- (UIPageViewController *)pageController
{
    if (!_pageController) {
        _pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        _pageController.view.frame = CGRectMake(0, CGRectGetMaxY(self.topView.frame), self.view.bounds.size.width, self.view.bounds.size.height - CGRectGetMaxY(self.topView.frame)-50);
        _pageController.view.backgroundColor = UIColor.yellowColor;
    }
    return _pageController;
}

@end
