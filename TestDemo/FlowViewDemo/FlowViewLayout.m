//
//  FlowViewLayout.m
//  TestDemo
//
//  Created by vane on 2019/1/29.
//  Copyright © 2019 vane.greenisland. All rights reserved.
//

#import "FlowViewLayout.h"

/** 默认列数*/
static const NSInteger FlowViewDefaultColumeCount = 2;
/** 默认列间距*/
static const NSInteger FlowViewDefaultColumeMargin = 10;
/** 默认行间距*/
static const CGFloat FlowViewDefaultRowMargin = 10;
/** 默认边距*/
static const UIEdgeInsets FlowViewDefaultEdgeInset = {10, 10, 10, 10};

@interface FlowViewLayout ()

@property (nonatomic,strong) NSMutableArray *attributesArray;
@property (nonatomic,strong) NSMutableArray<UICollectionViewLayoutAttributes*> *itemArray;
@property (nonatomic,assign) CGFloat totalHeight;

/** 列数*/
- (NSInteger)columnCount;
/** 列间距*/
- (CGFloat)columnMargin;
/** 行间距*/
- (CGFloat)rowMargin;
/** 边距*/
- (UIEdgeInsets)edgeInsets;

@end

@implementation FlowViewLayout

#pragma mark - item 配置

- (NSInteger)columnCount {
    if ([self.delegate respondsToSelector:@selector(columnCountInFlowViewLayout:)]) {
        return [self.delegate columnCountInFlowViewLayout:self];
    } else {
        return FlowViewDefaultColumeCount;
    }
}

- (CGFloat)columnMargin {
    if ([self.delegate respondsToSelector:@selector(columnMarginInFlowViewLayout:)]) {
        return [self.delegate columnMarginInFlowViewLayout:self];
    } else {
        return FlowViewDefaultColumeMargin;
    }
}

- (CGFloat)rowMargin {
    if ([self.delegate respondsToSelector:@selector(rowMarginInFlowViewLayout:)]) {
        return [self.delegate rowMarginInFlowViewLayout:self];
    } else {
        return FlowViewDefaultRowMargin;
    }
}

- (UIEdgeInsets)edgeInsets {
    if ([self.delegate respondsToSelector:@selector(edgeInsetsInFlowViewLayout:)]) {
        return [self.delegate edgeInsetsInFlowViewLayout:self];
    } else {
        return FlowViewDefaultEdgeInset;
    }
}

#pragma mark - Method

- (void)prepareLayout {
    
    [super prepareLayout];
    
    [self.attributesArray removeAllObjects];
    [self.itemArray removeAllObjects];
    self.totalHeight = 0;
    
    //获取当前collectionView对应区的item
    NSUInteger sectionCount = [self.collectionView numberOfSections];
    for (NSInteger section = 0; section < sectionCount; section++) {
        NSInteger count = [self.collectionView numberOfItemsInSection:section];
        
        if ([self.delegate respondsToSelector:@selector(collectionView:layout:referenceSizeForHeaderInSection:)]) {
            UICollectionViewLayoutAttributes *headerAttr = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:[NSIndexPath indexPathWithIndex:section]];
            [self.attributesArray addObject:headerAttr];
        }
        
        for (int i = 0; i < count; i++) {
            UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:section]];
            [self.attributesArray addObject:attributes];
        }
        
        if ([self.delegate respondsToSelector:@selector(collectionView:layout:referenceSizeForFooterInSection:)]) {
            UICollectionViewLayoutAttributes *footerAttr = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter atIndexPath:[NSIndexPath indexPathWithIndex:section]];
            [self.attributesArray addObject:footerAttr];
        }
    }
}

///返回collectionView的内容的尺寸
- (CGSize)collectionViewContentSize {
    CGFloat maxContentHeight = CGRectGetMaxY([self.itemArray firstObject].frame);
    
    for (UICollectionViewLayoutAttributes *attributes in self.itemArray) {
        if (maxContentHeight < CGRectGetMaxY(attributes.frame)) {
            maxContentHeight = CGRectGetMaxY(attributes.frame);
        }
    }
    return CGSizeMake(self.collectionView.bounds.size.width, maxContentHeight + self.edgeInsets.bottom);
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.attributesArray;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewLayoutAttributes *layoutAttrs = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:elementKind withIndexPath:indexPath];
    NSUInteger sectionCount = [self.collectionView numberOfSections];
    CGSize viewSize;
    
    if (elementKind == UICollectionElementKindSectionHeader) {
        viewSize = [self.delegate collectionView:self.collectionView layout:self referenceSizeForHeaderInSection:indexPath.section];
    } else if (elementKind == UICollectionElementKindSectionFooter){
        if (indexPath.section == sectionCount - 1) {
            viewSize = CGSizeZero;  //瀑布流footer不计算
        } else {
            viewSize = [self.delegate collectionView:self.collectionView layout:self referenceSizeForFooterInSection:indexPath.section];
        }
    }
    layoutAttrs.frame = CGRectMake(0, self.totalHeight, viewSize.width, viewSize.height);
    self.totalHeight += viewSize.height;
    return layoutAttrs;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {

    UICollectionViewLayoutAttributes *attributs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    NSUInteger sectionCount = [self.collectionView numberOfSections];
    
    if (indexPath.section == sectionCount - 1) {
        ///item的宽度，根据左右间距和中间间距算出item宽度
        CGFloat itemWidth = (self.collectionView.bounds.size.width - (self.edgeInsets.left + self.edgeInsets.right + (self.columnCount - 1) * self.columnMargin)) /  self.columnCount;
        
        ///item的高度
        CGFloat itemHeight = [self.delegate flowViewLayout:self heightForItemAtIndexPath:indexPath];
        
        CGFloat y = self.totalHeight;
        
        if (self.itemArray.count < self.columnCount) {
            [self.itemArray addObject:attributs];
            CGRect itemFrame = CGRectMake(self.edgeInsets.left + (itemWidth + self.columnMargin) * (self.itemArray.count - 1), self.edgeInsets.top + y, itemWidth, itemHeight);
            attributs.frame = itemFrame;
        } else {
            UICollectionViewLayoutAttributes *fristAttri = [self.itemArray firstObject];
            CGFloat minY = CGRectGetMaxY(fristAttri.frame);
            CGFloat Y = minY;
            NSInteger index = 0;
            CGRect itemFrame = CGRectMake(fristAttri.frame.origin.x, CGRectGetMaxY(fristAttri.frame) + self.rowMargin, itemWidth, itemHeight);
            for (UICollectionViewLayoutAttributes *attri in self.itemArray) {
                if (minY > CGRectGetMaxY(attri.frame)) {
                    minY = CGRectGetMaxY(attri.frame);
                    Y = minY;
                    itemFrame = CGRectMake(attri.frame.origin.x, Y + self.rowMargin, itemWidth, itemHeight);
                    NSInteger currentIndex = [self.itemArray indexOfObject:attri];
                    index = currentIndex;
                }
            }
            attributs.frame = itemFrame;
            [self.itemArray replaceObjectAtIndex:index withObject:attributs];
        }
        
        return attributs;
    } else {
        CGSize itemSize = [self.delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];
        UIEdgeInsets edgeInsets = [self.delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:indexPath.section];
        CGFloat lineSpacing = [self.delegate collectionView:self.collectionView layout:self minimumLineSpacingForSectionAtIndex:indexPath.section];
        CGFloat interitemSpacing = [self.delegate collectionView:self.collectionView layout:self minimumInteritemSpacingForSectionAtIndex:indexPath.section];
        
        if (indexPath.item == 0) {
            NSInteger itemCount = [self.collectionView numberOfItemsInSection:indexPath.section];
            CGFloat maxCountARow = (self.collectionView.frame.size.width - edgeInsets.left - edgeInsets.right + interitemSpacing) / (itemSize.width + interitemSpacing);
            NSInteger rowCount = ceil(itemCount / floor(maxCountARow));
            
            self.totalHeight += itemSize.height * rowCount + lineSpacing * (rowCount - 1) + edgeInsets.top + edgeInsets.bottom;//section高度
        }
        
        return [super layoutAttributesForItemAtIndexPath:indexPath];
    }
    
    return attributs;
}

- (NSMutableArray *)attributesArray {
    if (!_attributesArray) {
        _attributesArray = [NSMutableArray array];
    }
    return _attributesArray;
}

- (NSMutableArray *)itemArray {
    if (!_itemArray) {
        _itemArray = [NSMutableArray array];
    }
    return _itemArray;
}

@end
