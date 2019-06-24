//
//  FlowViewController.m
//  TestDemo
//
//  Created by vane on 2019/1/28.
//  Copyright © 2019 vane.greenisland. All rights reserved.
//

#import "FlowViewController.h"
#import "FlowViewCell.h"
#import "FlowViewLayout.h"

@interface FlowViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, FlowViewLayoutDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation FlowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"FlowTest";
    
    NSArray<NSNumber*> *heightArray = @[@(300),@(80),@(100),@(80),@(100),@(30),@(100),@(40),@(100),@(80),@(60),@(80),@(100),@(80),@(50),@(80),@(100),@(80),@(70),@(80),@(100),@(80),@(100),@(80),@(100),@(80),@(60),@(80),@(90),@(80),@(20),@(80),@(100),@(80),@(100),@(80),@(100),@(80),@(100),@(80),@(100),@(80),@(100),@(80),@(100),@(80),@(100),@(80),@(100),@(80),@(100),@(80),@(100),@(80),@(100),@(80),@(100),@(80),@(100),@(80),@(100),@(80),@(100),@(80),@(100),@(80),@(100),@(40),@(200),@(500)];
//    NSArray<NSNumber*> *heightArray = @[@(300),@(500),@(100),@(200),@(500)];
    self.dataArray = heightArray;
    
    [self.view addSubview:self.collectionView];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"刷新" style:UIBarButtonItemStylePlain target:self action:@selector(clickTest)];
    [self navigationItem].rightBarButtonItem = rightItem;
}

- (void)clickTest {
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource & UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }
    if (section == 1) {
        return 10;
    }
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell0" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor redColor];
        
        return cell;
    }
    
    if (indexPath.section == 1) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell1" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor greenColor];
        
        return cell;
    }
    
    FlowViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FlowViewCell" forIndexPath:indexPath];
    [cell setCellData:self.dataArray[indexPath.row] indexPath:indexPath];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
        headerView.backgroundColor = [UIColor blackColor];
        return headerView;
    } else {
        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footer" forIndexPath:indexPath];
        footerView.backgroundColor = [UIColor brownColor];
        return footerView;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"section-%ld,row-%ld", (long)indexPath.section, (long)indexPath.row);
}

#pragma mark - FlowViewLayoutDelegate

- (CGFloat)flowViewLayout:(FlowViewLayout *)flowLayout heightForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSNumber *height = self.dataArray[indexPath.row];
    return height.floatValue;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(FlowViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(60, 60);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(FlowViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(20, 20, 20, 20);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(FlowViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 20;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(FlowViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 20;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(FlowViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(self.view.frame.size.width, 50);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(FlowViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(self.view.frame.size.width, 15);
}

#pragma mark - Getter

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        FlowViewLayout *layout = [[FlowViewLayout alloc] init];
        layout.delegate = self;

        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Cell0"];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Cell1"];
        [_collectionView registerClass:[FlowViewCell class] forCellWithReuseIdentifier:@"FlowViewCell"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    }
    return _collectionView;
}

@end
