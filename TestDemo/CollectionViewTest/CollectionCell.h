//
//  CollectionCell.h
//  CollectionViewManager
//
//  Created by vane on 14-6-25.
//  Copyright (c) 2014年 vane.greenisland. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CollectionCell;
@protocol CollectionCellDelegate <NSObject>

- (void)longPress:(CollectionCell *)cell;
- (void)deleteApp:(CollectionCell *)cell;

@end

@interface CollectionCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *appImageView;
@property (nonatomic, strong) UILabel *appTitleLabel;
@property (nonatomic, strong) UIButton *deleteAppButton;
@property (nonatomic, assign) BOOL canDelete;

//@property (nonatomic, assign) BOOL isDeleteButtonVisible;//设置删除按钮的可见性
//@property (nonatomic, retain) NSDictionary *cellData;//设置cell数据，根据实际传值格式更改

@property (nonatomic, weak) id <CollectionCellDelegate> delegate;

//- (void)setIndexPathID:(NSUInteger)index;//根据cell设置删除按钮index

- (void)setCellData:(NSDictionary *)cellData withMode:(BOOL)isEditing;

@end
