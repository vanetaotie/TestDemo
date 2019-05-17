//
//  PageViewDemoVC.m
//  TestDemo
//
//  Created by vane on 2019/5/5.
//  Copyright © 2019 vane.greenisland. All rights reserved.
//

#import "PageViewDemoVC.h"
#import "PageTabViewController.h"
#import "SubPageViewVC.h"

#import "DYLeftSlipManager.h"
#import "LeftTableViewController.h"

@interface PageViewDemoVC () <PageTabViewControllerDelegate>

@property (nonatomic, strong) PageTabViewController *pageTabVC;

@end

@implementation PageViewDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addChildViewController:self.pageTabVC];
    [self.view addSubview:self.pageTabVC.view];
    
    self.pageTabVC.view.frame = CGRectMake(0, 150, self.view.bounds.size.width, 500);
    
    UIButton *tempbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    tempbtn.frame = CGRectMake(self.view.bounds.size.width/2-50, 80, 100, 30);
    [tempbtn setTitle:@"切换7" forState:UIControlStateNormal];
    [tempbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [tempbtn addTarget:self action:@selector(switchPage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tempbtn];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"点击" style:UIBarButtonItemStylePlain target:self action:@selector(clickTest)];
    [self navigationItem].rightBarButtonItem = rightItem;
    
    [[DYLeftSlipManager sharedManager] setLeftViewController:[LeftTableViewController new] coverViewController:self];
}

- (void)clickTest {
    // 代码唤出左滑视图
    [[DYLeftSlipManager sharedManager] showLeftView];
}

- (void)switchPage {
    [self.pageTabVC setPageIndex:6];
}

#pragma mark - PageTabViewControllerDelegate

- (NSInteger)numbersOfPagesInPageViewController:(PageTabViewController *)pageViewController {
    return 30;
}

- (UIViewController *)pageViewController:(PageTabViewController *)pageViewController subViewControllerAtIndex:(NSInteger)index {
    SubPageViewVC *subVC = [[SubPageViewVC alloc] initWithPageNumber:(index + 1)];
    
    return subVC;
}

- (NSString *)pageViewController:(PageTabViewController *)pageViewController itemTextAtIndex:(NSInteger)index {
    return [NSString stringWithFormat:@"第%ld页", (index + 1)];
}

#pragma mark - Getter

- (PageTabViewController *)pageTabVC {
    if (!_pageTabVC) {
        _pageTabVC = [[PageTabViewController alloc] init];
        _pageTabVC.selectTitleColor = [UIColor redColor];
        _pageTabVC.delegate = self;
    }
    return _pageTabVC;
}

@end
