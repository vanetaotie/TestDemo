//
//  BaseFilter.h
//  TestDemo
//
//  Created by vane on 2020/3/27.
//  Copyright © 2020 vane.greenisland. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FilterModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseFilter : NSObject

- (instancetype)initWithItemModel:(FilterItemModel *)filterItemModel;

- (void)popFilterViewWithStartY:(CGFloat)startY closeComplete:(void (^)(NSMutableDictionary *filters))closeComplete;

- (void)removeAllFilterView;

- (void)closeFilterView;

@end

NS_ASSUME_NONNULL_END
