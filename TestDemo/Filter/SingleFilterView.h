//
//  SingleFilterView.h
//  TestDemo
//
//  Created by vane on 2020/3/28.
//  Copyright © 2020 vane.greenisland. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FilterModel.h"

NS_ASSUME_NONNULL_BEGIN

#define kSingleFilterCellHeight 45
#define kSingleFilterBtnHeight 45

@interface SingleFilterView : UIView

@property (nonatomic, strong) FilterItemModel *filterItemModel;
@property (nonatomic, copy) void(^confirmBlock)(NSArray *selectedArray);
@property (nonatomic, copy) void(^cancelBlock)();

- (void)reloadData;

@end

@interface SingleFilterCell : UITableViewCell

- (void)setCellData:(FliterContentModel *)model;

@end

NS_ASSUME_NONNULL_END
