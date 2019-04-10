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
    
//    NSArray<NSNumber*> *heightArray = @[@(300),@(80),@(100),@(80),@(100),@(30),@(100),@(40),@(100),@(80),@(60),@(80),@(100),@(80),@(50),@(80),@(100),@(80),@(70),@(80),@(100),@(80),@(100),@(80),@(100),@(80),@(60),@(80),@(90),@(80),@(20),@(80),@(100),@(80),@(100),@(80),@(100),@(80),@(100),@(80),@(100),@(80),@(100),@(80),@(100),@(80),@(100),@(80),@(100),@(80),@(100),@(80),@(100),@(80),@(100),@(80),@(100),@(80),@(100),@(80),@(100),@(80),@(100),@(80),@(100),@(80),@(100),@(40),@(200),@(500)];
    NSArray<NSNumber*> *heightArray = @[@(300),@(500),@(100),@(200),@(500)];
    self.dataArray = heightArray;
    
    [self.view addSubview:self.collectionView];
}

#pragma mark - UICollectionViewDataSource & UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor redColor];
        
        return cell;
    }
    
    FlowViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FlowViewCell" forIndexPath:indexPath];
    [cell setCellData:self.dataArray[indexPath.row] indexPath:indexPath];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"section-%ld,row-%ld", (long)indexPath.section, (long)indexPath.row);
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(60, 60);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(20, 20, 20, 20);
}

#pragma mark - FlowViewLayoutDelegate

- (CGFloat)flowViewLayout:(FlowViewLayout *)flowLayout heightForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSNumber *height = self.dataArray[indexPath.row];
    return height.floatValue;
}

#pragma mark - Getter

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        FlowViewLayout *layout = [[FlowViewLayout alloc] init];
        layout.delegate = self;

        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
//        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
        [_collectionView registerClass:[FlowViewCell class] forCellWithReuseIdentifier:@"FlowViewCell"];
    }
    return _collectionView;
}

@end
