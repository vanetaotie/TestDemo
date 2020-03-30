//
//  FilterBar.m
//  TestDemo
//
//  Created by vane on 2020/3/27.
//  Copyright © 2020 vane.greenisland. All rights reserved.
//

#import "FilterBar.h"
#import "BaseFilter.h"

@interface FilterBar () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) FilterModel *filterModel;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableDictionary *filterDic;

@property (nonatomic, strong) NSMutableArray *totalCondition;

@end

@implementation FilterBar

- (instancetype)initWithFrame:(CGRect)frame filterArray:(NSArray *)filterArray {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.filterModel = [[FilterModel alloc] initWithArray:filterArray];
        
        [self initView];
        [self initData];
    }
    return self;
}

- (void)initView {
    [self addSubview:self.collectionView];
}

- (void)initData {
    int i = 0;
    for (FilterItemModel *itemModel in self.filterModel.filterItemArray) {
        BaseFilter *baseFilter = [[BaseFilter alloc] initWithItemModel:itemModel];
        [self.filterDic setObject:baseFilter forKey:[NSString stringWithFormat:@"%d",i]];
        i++;
    }
}

- (void)closeAllBar {
    for (NSString *key in self.filterDic) {
        BaseFilter *baseFilter = [self.filterDic objectForKey:key];
        [baseFilter removeAllFilterView];
    }
}

- (void)updateTotalCondition:(NSDictionary *)conditionDic {
    if ([conditionDic isKindOfClass:[NSNull class]] || [conditionDic isEqual:[NSNull null]] || conditionDic.allKeys.count == 0 || conditionDic.allValues.count == 0) {
         return;
    }
    
    NSString *conditionKey = conditionDic.allKeys[0];
    
    NSDictionary *tempDic;
    for (NSDictionary *dic in self.totalCondition) {
        if ([dic.allKeys containsObject:conditionKey]) {
            tempDic = dic;
        }
    }
    [self.totalCondition removeObject:tempDic];
    [self.totalCondition addObject:conditionDic];
    
    if (self.selectFilterCompletion) {
        self.selectFilterCompletion(self.totalCondition);
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.filterModel.filterItemArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FilterItemModel *model = self.filterModel.filterItemArray[indexPath.row];
    
    FilterBarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FilterBarCell" forIndexPath:indexPath];
    
    [cell setCellData:model indexPath:indexPath];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    FilterItemModel *itemModel = self.filterModel.filterItemArray[indexPath.row];
    itemModel.isSelected = YES;
    
    BaseFilter *baseFilter = [self.filterDic objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
    WS(weakSelf);
    [baseFilter popFilterViewWithStartY:CGRectGetMaxY(self.frame) closeComplete:^(NSMutableDictionary * _Nonnull filters) {
        [weakSelf updateTotalCondition:filters];
    }];
    
    for (NSString *key in self.filterDic) {
        BaseFilter *baseFilter = [self.filterDic objectForKey:key];
        if (![key isEqualToString:[NSString stringWithFormat:@"%ld",(long)indexPath.row]]) {
            [baseFilter closeFilterView];
        }
    }
    
    for (FilterItemModel *tempModel in self.filterModel.filterItemArray) {
        if (![tempModel isEqual:itemModel]) {
            tempModel.isSelected = NO;
        }
    }
    
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.filterModel.filterItemArray.count == 0) {
        return CGSizeZero;
    }
    
    return CGSizeMake(ceil(CGRectGetWidth(self.bounds)/self.filterModel.filterItemArray.count), CGRectGetHeight(self.bounds));
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsZero;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

#pragma mark - Getter

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.scrollEnabled = NO;
        _collectionView.scrollsToTop = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
        [_collectionView registerClass:[FilterBarCell class] forCellWithReuseIdentifier:@"FilterBarCell"];
    }
    return _collectionView;
}

- (NSMutableDictionary *)filterDic {
    if (!_filterDic) {
        _filterDic = [[NSMutableDictionary alloc] init];
    }
    return _filterDic;
}

- (NSMutableArray *)totalCondition {
    if (!_totalCondition) {
        _totalCondition = [NSMutableArray new];
    }
    return _totalCondition;
}

@end


@interface FilterBarCell ()

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIImageView *rightImageView;

@end

@implementation FilterBarCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self initView];
    }
    return self;
}

- (void)initView {
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.rightImageView];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right).offset(10);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
}

- (void)setCellData:(FilterItemModel *)model indexPath:(NSIndexPath *)indexPath {
    self.titleLabel.text = model.filterName;
    
    if (model.isSelected) {
        self.titleLabel.textColor = kFilterSelectTextColor;
        self.rightImageView.hidden = NO;
    } else {
        self.titleLabel.textColor = kFilterBarTextColor;
        self.rightImageView.hidden = YES;
    }
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:13.0f];
        _titleLabel.textColor = kFilterBarTextColor;
    }
    return _titleLabel;
}

- (UIImageView *)rightImageView
{
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc] init];
        _rightImageView.contentMode = UIViewContentModeCenter;
        _rightImageView.image = [UIImage imageNamed:@"icon_checked_yes"];
    }
    return _rightImageView;
}

@end
