//
//  SpecialScrollVC.m
//  TestDemo
//
//  Created by vane on 2019/6/14.
//  Copyright © 2019 vane.greenisland. All rights reserved.
//

#import "SpecialScrollVC.h"
#import "MJRefresh.h"

@interface SpecialScrollVC () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollview;
@property (nonatomic, strong) UIScrollView *topScrollview;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UICollectionView *collectionview;

@end

@implementation SpecialScrollVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.scrollview];
    [self.scrollview addSubview:self.topScrollview];
    [self.scrollview addSubview:self.pageControl];
    [self.scrollview addSubview:self.collectionview];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.scrollview.mj_header beginRefreshing];
}

- (void)headerRefresh {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.scrollview.mj_header endRefreshing];
    });
}

- (void)footerRefresh{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.scrollview.mj_footer endRefreshing];
    });
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([scrollView isEqual:self.topScrollview]) {
        CGFloat offsetX = scrollView.contentOffset.x;
        CGFloat offsetY = scrollView.contentOffset.y;
        NSLog(@"offsetX:%f  offsetY:%f", offsetX, offsetY);
        
        if (offsetX < 0 || offsetX > self.view.frame.size.width) {
            return;
        }
        
        //topScrollview向右位移self.view.frame.size.width,collectionview向下位移200
        CGFloat realoffsetY = offsetX/self.view.frame.size.width*200;
        self.pageControl.mj_y = realoffsetY + 200;
        self.collectionview.mj_y = realoffsetY + 220;
        self.scrollview.contentSize = CGSizeMake(self.view.frame.size.width, realoffsetY + self.view.frame.size.height * 2);
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if ([scrollView isEqual:self.topScrollview]) {
        int currentPage = scrollView.contentOffset.x/self.view.frame.size.width;
        self.pageControl.currentPage = currentPage;
    }
}

- (UIScrollView *)scrollview
{
    if (!_scrollview) {
        _scrollview = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _scrollview.backgroundColor = UIColor.yellowColor;
        _scrollview.exclusiveTouch = YES;
        _scrollview.scrollEnabled = YES;
        _scrollview.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height * 2);
        _scrollview.delegate = self;
        
        _scrollview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
        _scrollview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    }
    return _scrollview;
}

- (UIScrollView *)topScrollview
{
    if (!_topScrollview) {
        _topScrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 400)];
        _topScrollview.backgroundColor = UIColor.redColor;
        _topScrollview.exclusiveTouch = YES;
        _topScrollview.scrollEnabled = YES;
        _topScrollview.contentSize = CGSizeMake(self.view.frame.size.width * 2, 400);
        _topScrollview.delegate = self;
        _topScrollview.showsHorizontalScrollIndicator =NO;
        _topScrollview.pagingEnabled = YES;
        
        UIView *aview = [[UIView alloc] initWithFrame:CGRectMake(20, 20, self.view.frame.size.width-40, 160)];
        aview.backgroundColor = UIColor.blueColor;
        [_topScrollview addSubview:aview];
        
        UIView *bview = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width + 20, 20, self.view.frame.size.width-40, 360)];
        bview.backgroundColor = UIColor.cyanColor;
        [_topScrollview addSubview:bview];
    }
    return _topScrollview;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, 20)];
        _pageControl.backgroundColor = UIColor.whiteColor;
        _pageControl.currentPageIndicatorTintColor = UIColor.blackColor;
        _pageControl.pageIndicatorTintColor = UIColor.grayColor;
        _pageControl.numberOfPages = 2;
    }
    return _pageControl;
}

- (UICollectionView *)collectionview {
    if (!_collectionview) {
        _collectionview = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 220, self.view.frame.size.width, self.view.frame.size.height * 2-220) collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
        _collectionview.backgroundColor = UIColor.greenColor;
        
        WS(weakSelf);
        _collectionview.mj_footer = [MJRefreshFooter footerWithRefreshingBlock:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf.collectionview.mj_footer endRefreshing];
            });
        }];
    }
    return _collectionview;
}

@end
