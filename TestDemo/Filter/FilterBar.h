//
//  FilterBar.h
//  TestDemo
//
//  Created by vane on 2020/3/27.
//  Copyright © 2020 vane.greenisland. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FilterModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FilterBar : UIView

@property (nonatomic, copy) void(^selectFilterCompletion)(NSArray *filterCondition);

- (instancetype)initWithFrame:(CGRect)frame filterArray:(NSArray *)filterArray;

- (void)closeAllBar;

@end

@interface FilterBarCell : UICollectionViewCell

- (void)setCellData:(FilterItemModel *)model indexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
