//
//  PageTabViewController.h
//  TestDemo
//
//  Created by vane on 2019/5/7.
//  Copyright © 2019 vane.greenisland. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class PageTabViewController;

@protocol PageTabViewControllerDelegate <NSObject>

- (NSInteger)numbersOfPagesInPageViewController:(PageTabViewController *)pageViewController;

- (NSString *)pageViewController:(PageTabViewController *)pageViewController itemTextAtIndex:(NSInteger)index;

- (UIViewController *)pageViewController:(PageTabViewController *)pageViewController subViewControllerAtIndex:(NSInteger)index;

@optional

- (CGFloat)heightOfHeaderTabView:(PageTabViewController *)pageViewController;

@end

@interface PageTabViewController : UIViewController

@property (nonatomic, weak) id<PageTabViewControllerDelegate> delegate;

@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, strong) UIFont *selectTitleFont;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIColor *selectTitleColor;

- (instancetype)initWithFirstIndex:(NSInteger)firstIndex;
- (void)setPageIndex:(NSInteger)pageIndex;

@end

NS_ASSUME_NONNULL_END
