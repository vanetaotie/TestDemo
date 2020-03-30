//
//  BaseFilter.m
//  TestDemo
//
//  Created by vane on 2020/3/27.
//  Copyright © 2020 vane.greenisland. All rights reserved.
//

#import "BaseFilter.h"
#import "SingleFilterView.h"

@interface BaseFilter ()

@property (nonatomic, strong) NSMutableDictionary *currentCondition;

@property (nonatomic, strong) FilterItemModel *filterItemModel;
@property (nonatomic, strong) UIView *filterBackgroundView;
@property (nonatomic, strong) SingleFilterView *singleFilterView;
@property (nonatomic, strong) UIView *maskView;

@property (nonatomic, assign) CGFloat startY;
@property (nonatomic, copy) void(^closeComplete)(NSMutableDictionary *filters);

@end

@implementation BaseFilter

- (instancetype)init {
    
    if (self = [super init]) {
        [self initView];
    }
    return self;
}

- (instancetype)initWithItemModel:(FilterItemModel *)filterItemModel {
    if (self = [super init]) {
        self.filterItemModel = filterItemModel;
        [self initView];
    }
    return self;
}

- (void)initView {
    UIView *kWindow = [UIApplication sharedApplication].keyWindow;
    
    [kWindow addSubview:self.filterBackgroundView];
    [self.filterBackgroundView addSubview:self.maskView];
    
    switch (self.filterItemModel.filterType) {
       case BaseFilterTypeSingle: {
           [self.filterBackgroundView addSubview:self.singleFilterView];
       }
           break;
       case BaseFilterTypeThreeLevel: {
           
       }
           break;
       default:
           break;
    }
    
    self.filterBackgroundView.hidden = YES;
}

- (void)popFilterViewWithStartY:(CGFloat)startY closeComplete:(void (^)(NSMutableDictionary *filters))closeComplete {
    if (!self) {
        return;
    }
    
    if (self.filterItemModel.isOpen) {
        [self closeFilterView];
        return;
    }
    
    self.filterItemModel.isOpen = YES;
    
    self.closeComplete = closeComplete;
    self.startY = startY;
    self.filterBackgroundView.hidden = NO;
    self.filterBackgroundView.frame = CGRectMake(0, self.startY, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-self.startY);
    
    switch (self.filterItemModel.filterType) {
       case BaseFilterTypeSingle: {
           [self setSingleFilterFrame];
       }
           break;
       case BaseFilterTypeThreeLevel: {
           
       }
           break;
       default:
           break;
    }
}

- (void)setSingleFilterFrame {
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    CGFloat singleFilterHeight = 0;
    if (self.filterItemModel.supportMutiSelect) {
        singleFilterHeight = kSingleFilterCellHeight*self.filterItemModel.contentArray.count + kSingleFilterBtnHeight;
    } else {
        singleFilterHeight = kSingleFilterCellHeight*self.filterItemModel.contentArray.count;
    }
    
    self.singleFilterView.frame = CGRectMake(0, 0, screenWidth, singleFilterHeight);
    self.maskView.frame = CGRectMake(0, singleFilterHeight-10, screenWidth, CGRectGetHeight(self.filterBackgroundView.frame)-singleFilterHeight+10);
    
    [self.singleFilterView reloadData];
}

/* 关闭筛选视图 */
- (void)closeFilterView {
    self.filterItemModel.isOpen = NO;
    self.filterBackgroundView.hidden = YES;
}

- (void)closeFilterViewCompletion {
    self.filterItemModel.isOpen = NO;
    self.filterBackgroundView.hidden = YES;
    
    if (self.closeComplete) {
        self.closeComplete(self.currentCondition);
    }
}

- (void)removeAllFilterView {
    [self.filterBackgroundView removeFromSuperview];
}

#pragma mark - Getter

- (UIView *)filterBackgroundView {
    if (!_filterBackgroundView) {
        _filterBackgroundView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _filterBackgroundView.backgroundColor = [UIColor clearColor];
    }
    return _filterBackgroundView;
}

- (SingleFilterView *)singleFilterView {
    if (!_singleFilterView) {
        _singleFilterView = [[SingleFilterView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100)];
        _singleFilterView.filterItemModel = self.filterItemModel;
        
        WS(weakSelf);
        _singleFilterView.confirmBlock = ^(NSArray * _Nonnull selectedArray) {
            if (selectedArray) {
                [weakSelf.currentCondition setObject:selectedArray forKey:weakSelf.filterItemModel.filterId];
            }
            [weakSelf closeFilterViewCompletion];
        };
        _singleFilterView.cancelBlock = ^{
            [weakSelf closeFilterView];
        };
    }
    return _singleFilterView;
}

- (UIView *)maskView {
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:CGRectZero];
        _maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeFilterView)];
        [_maskView addGestureRecognizer:tap];
    }
    return _maskView;
}

- (NSMutableDictionary *)currentCondition {
    if (!_currentCondition) {
        _currentCondition = [[NSMutableDictionary alloc] init];
    }
    return _currentCondition;
}

@end
