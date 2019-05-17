//
//  PageTabViewController.m
//  TestDemo
//
//  Created by vane on 2019/5/7.
//  Copyright © 2019 vane.greenisland. All rights reserved.
//

#import "PageTabViewController.h"

/** DefaultPageNumber*/
static const NSInteger DefaultPageNumber = 1;
/** DefaultHeaderTabViewHeight*/
static const CGFloat DefaultHeaderTabViewHeight = 45;

@interface PageTabViewController () <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (nonatomic, assign) NSInteger currentPageIndex;

@property (nonatomic, strong) UIScrollView *headerTabView;
@property (nonatomic, strong) NSMutableArray<UIButton*> *buttonArray;

@property (nonatomic, strong) NSMutableArray *subVCArray;
@property (nonatomic, strong) UIPageViewController *pageController;

@end

@implementation PageTabViewController

- (instancetype)initWithFirstIndex:(NSInteger)firstIndex {
    self = [super init];
    if (self) {
        self.currentPageIndex = firstIndex;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initUI];
}

- (void)initUI {
    [self.view addSubview:self.headerTabView];
    [self setupHeaderItem:[self pagesCount]];
    [self changePageWithButton:self.buttonArray[self.currentPageIndex]];
    
    for (int i = 0; i < [self pagesCount]; i++) {
        if ([self.delegate respondsToSelector:@selector(pageViewController:subViewControllerAtIndex:)]) {
            [self.subVCArray addObject:[self.delegate pageViewController:self subViewControllerAtIndex:i]];
        } else {
            [self.subVCArray addObject:[[UIViewController alloc] init]];
        }
    }
    [self.pageController setViewControllers:@[[self.subVCArray objectAtIndex:self.currentPageIndex]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    [self addChildViewController:self.pageController];
    [self.view addSubview:self.pageController.view];
}

- (void)setPageIndex:(NSInteger)pageIndex {
    if (pageIndex < self.buttonArray.count) {
        [self buttonClick:self.buttonArray[pageIndex]];
    }
}

#pragma mark - Config

- (NSInteger)pagesCount {
    if ([self.delegate respondsToSelector:@selector(numbersOfPagesInPageViewController:)]) {
        return [self.delegate numbersOfPagesInPageViewController:self];
    } else {
        return DefaultPageNumber;
    }
}

- (CGFloat)headerHeight {
    if ([self.delegate respondsToSelector:@selector(heightOfHeaderTabView:)]) {
        return [self.delegate heightOfHeaderTabView:self];
    } else {
        return DefaultHeaderTabViewHeight;
    }
}

- (UIFont *)headerTitleFont {
    if (self.titleFont) {
        return self.titleFont;
    }
    return [UIFont systemFontOfSize:12];
}

- (UIFont *)headerTitleFontSelected {
    if (self.selectTitleFont) {
        return self.selectTitleFont;
    }
    return [UIFont systemFontOfSize:15];
}

- (UIColor *)headerTitleColor {
    if (self.titleColor) {
        return self.titleColor;
    }
    return [UIColor blackColor];
}

- (UIColor *)headerTitleColorSelected {
    if (self.selectTitleColor) {
        return self.selectTitleColor;
    }
    return [UIColor orangeColor];
}

#pragma mark - PrivateMethod

- (void)setupHeaderItem:(NSInteger)itemNumber {
    CGFloat w1 = self.view.bounds.size.width / itemNumber;
    for (int i = 0; i < itemNumber; i++) {
        NSString *textString = @"";
        if ([self.delegate respondsToSelector:@selector(pageViewController:itemTextAtIndex:)]) {
            textString = [self.delegate pageViewController:self itemTextAtIndex:i];
        }
        CGFloat w2 = [textString boundingRectWithSize:CGSizeMake(MAXFLOAT, [self headerTitleFont].lineHeight) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[self headerTitleFont]} context:nil].size.width+10;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(CGRectGetMaxX(self.buttonArray.lastObject.frame), 0, MAX(w1, w2), [self headerHeight]);
        [button setTitle:textString forState:UIControlStateNormal];
        [button.titleLabel setFont:[self headerTitleFont]];
        [button setTitleColor:[self headerTitleColor] forState:UIControlStateNormal];
        [button setTitleColor:[self headerTitleColorSelected] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.headerTabView addSubview:button];
        [self.headerTabView setContentSize:CGSizeMake(CGRectGetMaxX(button.frame), 0)];
        [self.buttonArray addObject:button];
    }
}

- (void)buttonClick:(UIButton *)button {
    [self changePageWithButton:button];
    
    NSInteger index = [self.buttonArray indexOfObject:button];
    
    __weak __typeof(self)weakSelf = self;
    [self.pageController setViewControllers:@[[self.subVCArray objectAtIndex:index]] direction:(index > self.currentPageIndex?UIPageViewControllerNavigationDirectionForward:UIPageViewControllerNavigationDirectionReverse) animated:YES completion:^(BOOL finished) {
        weakSelf.currentPageIndex = index;
    }];
}

- (void)changePageWithButton:(UIButton *)button {
    if (!button) {
        return;
    }
    
    for (UIButton *btn in self.buttonArray) {
        if (btn.isSelected == YES) {
            btn.selected = NO;
            [btn.titleLabel setFont:[self headerTitleFont]];
        }
    }
    
    button.selected = YES;
    [button.titleLabel setFont:[self headerTitleFontSelected]];
    
    CGFloat minX = 0;
    CGFloat maxX = self.headerTabView.contentSize.width - self.view.bounds.size.width;
    CGFloat x = MIN(MAX(CGRectGetMidX(button.frame)-self.view.bounds.size.width/2, minX), maxX);
    [self.headerTabView setContentOffset:CGPointMake(x, 0) animated:YES];
}

#pragma mark - UIPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger index = [self indexForViewController:viewController];
    if (index == 0) {
        index = [self pagesCount] - 1;
    } else {
        index--;
    }
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSUInteger index = [self indexForViewController:viewController];
    index++;
    if (index == [self pagesCount]) {
        index = 0;
    }
    return [self viewControllerAtIndex:index];
}

#pragma mark - UIPageViewControllerDelegate

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    if (completed) {
        self.currentPageIndex = [self.subVCArray indexOfObject:[pageViewController.viewControllers lastObject]];
        if (self.currentPageIndex < self.buttonArray.count) {
            [self changePageWithButton:self.buttonArray[self.currentPageIndex]];
        }
    }
}

- (NSUInteger)indexForViewController:(UIViewController *)viewController{
    return [self.subVCArray indexOfObject:viewController];
}

- (UIViewController *)viewControllerAtIndex:(NSUInteger)index{
    if (index > [self.subVCArray count]) {
        return nil;
    }
    UIViewController *vc = [self.subVCArray objectAtIndex:index];
    return vc;
}

#pragma mark - Getter

- (UIScrollView *)headerTabView {
    if (!_headerTabView) {
        _headerTabView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, [self headerHeight])];
        _headerTabView.backgroundColor = [UIColor whiteColor];
        _headerTabView.showsHorizontalScrollIndicator = NO;
    }
    return _headerTabView;
}

- (NSMutableArray<UIButton *> *)buttonArray {
    if (!_buttonArray) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}

- (NSMutableArray *)subVCArray {
    if (!_subVCArray) {
        _subVCArray = [NSMutableArray array];
    }
    return _subVCArray;
}

- (UIPageViewController *)pageController
{
    if (!_pageController) {
        _pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        _pageController.view.frame = CGRectMake(0, [self headerHeight], self.view.bounds.size.width, self.view.bounds.size.height - [self headerHeight]);
        _pageController.dataSource = self;
        _pageController.delegate = self;
    }
    return _pageController;
}

@end
