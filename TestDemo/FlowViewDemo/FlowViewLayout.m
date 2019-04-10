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
    
    NSLog(@"prepareLayout");
    
    ///获取当前collectionView对应区的item
    NSUInteger sectionCount = [self.collectionView numberOfSections];
    
//    for (NSInteger section = 0; section < sectionCount; section++) {
//        NSInteger count = [self.collectionView numberOfItemsInSection:section];
//        for (int i = 0; i < count; i++) {
//            UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:section]];
//            [self.attributesArray addObject:attributes];
////            NSLog(@"section%ld--i%d--attributes%@", (long)section, i, attributes);
//        }
//    }
    
    NSInteger count = [self.collectionView numberOfItemsInSection:sectionCount - 1];
    for (int i = 0; i < count; i++) {
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:sectionCount - 1]];
        [self.attributesArray addObject:attributes];
    }
}

///返回collectionView的内容的尺寸
- (CGSize)collectionViewContentSize {
    
    NSLog(@"collectionViewContentSize");
    
    CGFloat maxContentHeight = CGRectGetMaxY([self.itemArray firstObject].frame);
    
    for (UICollectionViewLayoutAttributes *attributes in self.itemArray) {
        if (maxContentHeight < CGRectGetMaxY(attributes.frame)) {
            maxContentHeight = CGRectGetMaxY(attributes.frame);
        }
    }
    
    NSLog(@"itemArray---%@", self.itemArray);
    
    return CGSizeMake(self.collectionView.bounds.size.width, maxContentHeight + self.edgeInsets.bottom);
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSLog(@"layoutAttributesForElementsInRect");
    
    NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
    NSMutableArray *allAttributes = [NSMutableArray array];
    for (UICollectionViewLayoutAttributes *attribute in attributes) {
        
        NSUInteger sectionCount = [self.collectionView numberOfSections];
        if (attribute.indexPath.section != sectionCount - 1) {
            [allAttributes addObject:attribute];
        }
    }
    
    for (UICollectionViewLayoutAttributes *att in self.attributesArray) {
        [allAttributes addObject:att];
    }
    
    NSLog(@"arr---%@", allAttributes);
    return allAttributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"section%ld---row%ld", (long)indexPath.section, (long)indexPath.row);
    
    UICollectionViewLayoutAttributes *attributs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGSize itemSize = CGSizeZero;
    UIEdgeInsets edgeInsets = UIEdgeInsetsZero;
    if (_delegate && [_delegate respondsToSelector:@selector(collectionView:layout:sizeForItemAtIndexPath:)]) {
        itemSize = [_delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];
    } else {
        itemSize = self.itemSize;
    }
    if (_delegate && [_delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]) {
        edgeInsets = [_delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:indexPath.section];
    } else {
        edgeInsets = self.sectionInset;
    }

    CGFloat frontSectionHeight = 100;//?计算所有瀑布流楼层之前的高度
    
    ///item的宽度，根据左右间距和中间间距算出item宽度
    CGFloat itemWidth = (self.collectionView.bounds.size.width - (self.edgeInsets.left + self.edgeInsets.right + (self.columnCount - 1) * self.columnMargin)) /  self.columnCount;
    
    ///item的高度
    CGFloat itemHeight = [self.delegate flowViewLayout:self heightForItemAtIndexPath:indexPath];
    
    if (self.itemArray.count < self.columnCount) {
        [self.itemArray addObject:attributs];
        CGRect itemFrame = CGRectMake(self.edgeInsets.left + (itemWidth + self.columnMargin) * (self.itemArray.count - 1), self.edgeInsets.top + frontSectionHeight, itemWidth, itemHeight);
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
