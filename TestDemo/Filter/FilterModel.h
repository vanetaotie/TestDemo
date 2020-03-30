//
//  FilterModel.h
//  TestDemo
//
//  Created by vane on 2020/3/27.
//  Copyright © 2020 vane.greenisland. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define kFilterBarTextColor [UIColor colorWithRed:102.0/255 green:102.0/255 blue:102.0/255 alpha:1]
#define kFilterTextColor [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1]
#define kFilterSelectTextColor [UIColor colorWithRed:86.0/255 green:119.0/255 blue:251.0/255 alpha:1]

typedef NS_ENUM(NSUInteger, BaseFilterType) {
    BaseFilterTypeSingle = 1,
    BaseFilterTypeThreeLevel = 3,
};

@interface FilterModel : NSObject

- (instancetype)initWithArray:(NSArray *)array;

@property (nonatomic, strong) NSMutableArray *filterItemArray;

@end

@interface FilterItemModel : NSObject

- (instancetype)initWithDic:(NSDictionary *)dic;

@property (nonatomic, copy) NSString *filterName;
@property (nonatomic, copy) NSString *filterId;
@property (nonatomic, assign) BaseFilterType filterType;
@property (nonatomic, strong) NSMutableArray *contentArray;
@property (nonatomic, assign) BOOL supportMutiSelect;
@property (nonatomic, assign) BOOL isOpen;
@property (nonatomic, assign) BOOL isSelected;

@end

@interface FliterContentModel : NSObject

- (instancetype)initWithDic:(NSDictionary *)dic;

@property (nonatomic, copy) NSString *contentTitle;
@property (nonatomic, copy) NSString *contentSortId;
@property (nonatomic, assign) BOOL isSelected;

@end

NS_ASSUME_NONNULL_END
