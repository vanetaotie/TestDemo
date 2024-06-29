//
//  IndicatorViewController.m
//  TestDemo
//
//  Created by vane on 2024/6/29.
//  Copyright © 2024 vane.greenisland. All rights reserved.
//

#import "IndicatorViewController.h"
#import <Masonry/Masonry.h>

@interface IndicatorViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIView *indicatorView;
@property (nonatomic, strong) UIView *sliderView;
@end

@implementation IndicatorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupCollectionView];
    [self setupIndicatorView];
}

- (void)setupCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:self.collectionView];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.view);
        make.height.mas_equalTo(100);
        make.centerY.equalTo(self.view).offset(-50);
    }];
}

- (void)setupIndicatorView {
    self.indicatorView = [[UIView alloc] init];
    self.indicatorView.backgroundColor = [UIColor grayColor];
    self.indicatorView.layer.cornerRadius = 2.5;
    self.indicatorView.layer.masksToBounds = YES;
    [self.view addSubview:self.indicatorView];
    
    self.sliderView = [[UIView alloc] init];
    self.sliderView.backgroundColor = [UIColor redColor];
    self.sliderView.layer.cornerRadius = 2.5;
    self.sliderView.layer.masksToBounds = YES;
    [self.indicatorView addSubview:self.sliderView];
    
    [self.indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.collectionView.mas_bottom).offset(30);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(5);
    }];
    
    [self.sliderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.bottom.equalTo(self.indicatorView);
        make.width.mas_equalTo(40);
    }];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10; // 示例数据
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.contentView.backgroundColor = [self randomColor];
    cell.contentView.layer.masksToBounds = YES;
    cell.contentView.layer.cornerRadius = 10;
    
    return cell;
}

- (UIColor *)randomColor {
    CGFloat red = arc4random() % 256 / 255.0;
    CGFloat green = arc4random() % 256 / 255.0;
    CGFloat blue = arc4random() % 256 / 255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = self.collectionView.bounds.size.height;
    return CGSizeMake(height - 10, height - 10); // cell 为正方形，高度减去间距
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat contentWidth = scrollView.contentSize.width - scrollView.bounds.size.width;
    CGFloat sliderWidth = self.indicatorView.bounds.size.width - self.sliderView.bounds.size.width;
    
    if (contentWidth > 0) {
        CGFloat xOffset = scrollView.contentOffset.x * sliderWidth / contentWidth;
        [self.sliderView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.indicatorView).offset(xOffset);
        }];
    }
}

@end
