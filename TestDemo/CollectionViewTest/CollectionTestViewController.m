//
//  CollectionTestViewController.m
//  TestDemo
//
//  Created by vane on 15/2/27.
//  Copyright (c) 2015年 vane.greenisland. All rights reserved.
//

#import "CollectionTestViewController.h"

@interface CollectionTestViewController ()

@end

@implementation CollectionTestViewController

- (id)init
{
    if ([super init]) {
        finishEditItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(finishEdit:)];
        [[self navigationItem] setRightBarButtonItem:finishEditItem];
        [finishEditItem setEnabled:NO];
        
        webAppData = [[NSMutableArray alloc] init];
        appsCells = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [super viewDidLoad];
    [self setWebAppsData];
    [self initCollectionView];
    //注册cell,设置重用标识符
    [myCollectionView registerClass:[CollectionCell class] forCellWithReuseIdentifier:@"collectionCellIdentify"];
}

- (void)initCollectionView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    myCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 320, [UIScreen mainScreen].bounds.size.height) collectionViewLayout:flowLayout];
    [myCollectionView setBackgroundColor:[UIColor whiteColor]];
    [myCollectionView setDelegate:self];
    [myCollectionView setDataSource:self];
    [self.view addSubview:myCollectionView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [webAppData count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentify = @"collectionCellIdentify";
    CollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentify forIndexPath:indexPath];
    [cell setDelegate:self];
    
    if (indexPath == 0) {
        [appsCells removeAllObjects];
    }
    [appsCells addObject:cell];
    
    NSDictionary *cellData = (NSDictionary *)[webAppData objectAtIndex:indexPath.row];
    [cell setCellData:cellData];
    [cell setIndexPathID:indexPath.row];
    
    return cell;
}

#pragma mark UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    downloadAlartView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"进入下载" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [downloadAlartView show];
}

#pragma mark UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(70, 90);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(25, 35, 25, 25);
}

#pragma mark CollectionCellDelegate

- (void)longPress:(CollectionCell *)cell
{
    for (CollectionCell *cell in appsCells)
    {
        [cell setIsDeleteButtonVisible:NO];
    }
    
    //长按进入编辑模式，启动cell手动排序功能
    panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognizer:)];
    //    [panGesture setCancelsTouchesInView:NO];
    [myCollectionView addGestureRecognizer:panGesture];
    
    [finishEditItem setEnabled:YES];
}

- (void)deleteApp:(CollectionCell *)cell
{
    NSIndexPath *deleteItemsIndexPath = [myCollectionView indexPathForCell:cell];
    NSArray *deleteItems = @[deleteItemsIndexPath];
    
    [webAppData removeObjectAtIndex:deleteItemsIndexPath.row];//移除数据库相应数据
    [myCollectionView deleteItemsAtIndexPaths:deleteItems];//移除UI cell
}

#pragma mark UIAlartViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView == downloadAlartView) {
        if (buttonIndex == 1) {
            NSLog(@"进入下载页面");
        }
    }
}

#pragma mark Other Method

- (void)finishEdit:(id)sender
{
    for (CollectionCell *cell in appsCells)
    {
        [cell setIsDeleteButtonVisible:YES];
    }
    
    //移除所有手势
    while (myCollectionView.gestureRecognizers.count) {
        //        NSLog(@"手势数量 %lu",(unsigned long)myCollectionView.gestureRecognizers.count);
        [myCollectionView removeGestureRecognizer:[myCollectionView.gestureRecognizers objectAtIndex:0]];
    }
    
    [finishEditItem setEnabled:NO];
}

#pragma mark 手动排序

- (void)panGestureRecognizer:(UIPanGestureRecognizer *)sender
{
    UIPanGestureRecognizer *pan = sender;
    UIGestureRecognizerState state = pan.state;
    
    CGPoint location = [pan locationInView:myCollectionView];
    NSIndexPath *indexPath = [myCollectionView indexPathForItemAtPoint:location];
    
    static NSIndexPath *sourceIndexPath = nil;
    
    switch (state) {
        case UIGestureRecognizerStateBegan:{
            if (indexPath) {
                sourceIndexPath = indexPath;
            }
            break;
        }
        case UIGestureRecognizerStateChanged:{
            if (indexPath && ![indexPath isEqual:sourceIndexPath]) {
                [webAppData exchangeObjectAtIndex:indexPath.row withObjectAtIndex:sourceIndexPath.row];
                [myCollectionView moveItemAtIndexPath:sourceIndexPath toIndexPath:indexPath];
                sourceIndexPath = indexPath;
            }
            break;
        }
        default:{
            sourceIndexPath = nil;
            break;
        }
    }
}

#pragma mark TEST webappsdata
//测试数据
- (void)setWebAppsData
{
    NSDictionary *cell1 = @{@"appImage": [UIImage imageNamed:@"feiji"],@"appTitle":@"测试1",@"canDelete":[NSNumber numberWithBool:NO]};
    NSDictionary *cell2 = @{@"appImage": [UIImage imageNamed:@"fox"],@"appTitle":@"测试2",@"canDelete":[NSNumber numberWithBool:NO]};
    NSDictionary *cell3 = @{@"appImage": [UIImage imageNamed:@"mail"],@"appTitle":@"测试3",@"canDelete":[NSNumber numberWithBool:NO]};
    NSDictionary *cell4 = @{@"appImage": [UIImage imageNamed:@"page"],@"appTitle":@"测试4",@"canDelete":[NSNumber numberWithBool:YES]};
    NSDictionary *cell5 = @{@"appImage": [UIImage imageNamed:@"temp"],@"appTitle":@"测试5",@"canDelete":[NSNumber numberWithBool:YES]};
    NSDictionary *cell6 = @{@"appImage": [UIImage imageNamed:@"wifi"],@"appTitle":@"测试6",@"canDelete":[NSNumber numberWithBool:YES]};
    NSDictionary *cell7 = @{@"appImage": [UIImage imageNamed:@"yazi"],@"appTitle":@"测试7",@"canDelete":[NSNumber numberWithBool:YES]};
    NSDictionary *cell8 = @{@"appImage": [UIImage imageNamed:@"yellow"],@"appTitle":@"测试8",@"canDelete":[NSNumber numberWithBool:YES]};
    
    [webAppData addObject:cell1];
    [webAppData addObject:cell2];
    [webAppData addObject:cell3];
    [webAppData addObject:cell4];
    [webAppData addObject:cell5];
    [webAppData addObject:cell6];
    [webAppData addObject:cell7];
    [webAppData addObject:cell8];
}

@end
