//
//  CTViewController.m
//  TestDemo
//
//  Created by vane on 20/11/2017.
//  Copyright © 2017 vane.greenisland. All rights reserved.
//

#import "CTViewController.h"
#import "CTCollectionViewCell.h"
#import "CTCollectionReusableView.h"

static NSString *const kCellTypeBanner = @"kCellTypeBanner";        //Banner轮播位
static NSString *const kCellTypeColumns = @"kCellTypeColumns";      //栏目资源位
static NSString *const kCellTypePopularity = @"kCellTypePopularity";//人气资源位
static NSString *const kCellTypePalette = @"kCellTypePalette";      //搭配资源位
static NSString *const kCellTypeGoods = @"kCellTypeGoods";          //好货资源位
static NSString *const kCellTypeShow = @"kCellTypeShow";            //晒单资源位
static NSString *const kCellTypeInfomation = @"kCellTypeInfomation";//信息流资源位

@interface CTViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) NSMutableArray *cellTypeArray;
@property (strong, nonatomic) UICollectionView *mainCollectionView;

@end

@implementation CTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupCellTypeArray];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setupCellTypeArray
{
    [self.cellTypeArray removeAllObjects];
    
//    [self.cellTypeArray addObject:kCellTypeBanner];
    [self.cellTypeArray addObject:kCellTypeColumns];
    [self.cellTypeArray addObject:kCellTypePopularity];
    [self.cellTypeArray addObject:kCellTypePalette];
    [self.cellTypeArray addObject:kCellTypeGoods];
    [self.cellTypeArray addObject:kCellTypeShow];
    [self.cellTypeArray addObject:kCellTypeInfomation];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSString *cellType = self.cellTypeArray[section];
    
    if ([cellType isEqualToString:kCellTypePalette]) {
        return 10;
    } else if ([cellType isEqualToString:kCellTypeGoods]) {
        return 4;
    } else if ([cellType isEqualToString:kCellTypeShow]) {
        return 10;
    } else if ([cellType isEqualToString:kCellTypeInfomation]) {
        return 6;
    }
    
    return 1;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [self.cellTypeArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellType = self.cellTypeArray[indexPath.section];
    
    return [UICollectionViewCell new];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellType = self.cellTypeArray[indexPath.section];
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
    } else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        
    }
    
    return nil;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellType = self.cellTypeArray[indexPath.section];
    
}

- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
#ifdef __IPHONE_11_0
    if (@available(iOS 11.0, *)) {
        view.layer.zPosition = 0;
    }
#endif
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellType = self.cellTypeArray[indexPath.section];
    CGSize cellSize = CGSizeZero;
    
    return cellSize;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    NSString *cellType = self.cellTypeArray[section];
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    NSString *cellType = self.cellTypeArray[section];

    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    NSString *cellType = self.cellTypeArray[section];

    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    NSString *cellType = self.cellTypeArray[section];

    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeZero;
}

#pragma mark - Getter&Setter
- (NSMutableArray *)cellTypeArray
{
    if (!_cellTypeArray) {
        _cellTypeArray = [NSMutableArray new];
    }
    
    return _cellTypeArray;
}

- (UICollectionView *)mainCollectionView
{
    if (_mainCollectionView) {
        _mainCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:[UICollectionViewFlowLayout new]];
        _mainCollectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _mainCollectionView.dataSource = self;
        _mainCollectionView.delegate = self;
    }
    return _mainCollectionView;
}

@end
