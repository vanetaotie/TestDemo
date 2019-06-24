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

/**同基础UICollectionView的代理设置,如有除瀑布流以外section、header、footer，必须实现**/
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(FlowViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(FlowViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section;

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(FlowViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section;

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(FlowViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section;

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(FlowViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section;

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(FlowViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section;

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
