//
//  FlowViewLayout.h
//  TestDemo
//
//  Created by vane on 2019/1/29.
//  Copyright © 2019 vane.greenisland. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FlowViewLayout;

@protocol FlowViewLayoutDelegate <NSObject>

- (CGFloat)flowViewLayout:(FlowViewLayout *)flowLayout heightForItemAtIndexPath:(NSIndexPath *)indexPath;

@optional

//列数 默认2
- (NSInteger)columnCountInFlowViewLayout:(FlowViewLayout *)flowLayout;

//列间距 默认10
- (CGFloat)columnMarginInFlowViewLayout:(FlowViewLayout *)flowLayout;

//行间距 默认10
- (CGFloat)rowMarginInFlowViewLayout:(FlowViewLayout *)flowLayout;

//边距 默认{10, 10, 10, 10}
- (UIEdgeInsets)edgeInsetsInFlowViewLayout:(FlowViewLayout *)flowLayout;

@end

@interface FlowViewLayout : UICollectionViewFlowLayout

@property (nonatomic, weak) id<FlowViewLayoutDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
