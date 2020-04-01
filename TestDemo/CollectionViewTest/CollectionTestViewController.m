//
//  CollectionTestViewController.m
//  TestDemo
//
//  Created by vane on 15/2/27.
//  Copyright (c) 2015年 vane.greenisland. All rights reserved.
//

#import "CollectionTestViewController.h"

#define WS(weakSelf)    __weak __typeof(&*self)weakSelf = self

@interface CollectionTestViewController ()

@end

@implementation CollectionTestViewController
{
    BOOL isEditingMode;//编辑模式
}

- (id)init
{
    if ([super init]) {
        finishEditItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(finishEdit:)];
        [[self navigationItem] setRightBarButtonItem:finishEditItem];
        [finishEditItem setEnabled:NO];
        
        webAppData = [[NSMutableArray alloc] init];
//        appsCells = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setWebAppsData];
    [self initCollectionView];
    //注册cell,设置重用标识符
    [myCollectionView registerClass:[CollectionCell class] forCellWithReuseIdentifier:@"collectionCellIdentify"];
}

- (void)initCollectionView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    myCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) collectionViewLayout:flowLayout];
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
    
//    if (indexPath == 0) {
//        [appsCells removeAllObjects];
//    }
//    [appsCells addObject:cell];
    
    NSDictionary *cellData = (NSDictionary *)[webAppData objectAtIndex:indexPath.row];
//    [cell setCellData:cellData];
    [cell setCellData:cellData withMode:isEditingMode];
//    [cell setIndexPathID:indexPath.row];
    
    cell.selectBlock = ^(CollectionCell *cell, BOOL isSelect) {
        NSIndexPath *index = [myCollectionView indexPathForCell:cell];
        
        NSLog(@"%@",index);
        
        //处理选择模型
    };
    
    [cell testDelegateMethod];
    [cell testDelegateMethod2];
    
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
//    for (CollectionCell *cell in appsCells)
//    {
//        [cell setIsDeleteButtonVisible:YES];
//    }
    isEditingMode = YES;
    [myCollectionView reloadData];
    
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
//    for (CollectionCell *cell in appsCells)
//    {
//        [cell setIsDeleteButtonVisible:NO];
//    }
    
    isEditingMode = NO;
    [myCollectionView reloadData];
    
//    //移除所有手势
//    while (myCollectionView.gestureRecognizers.count) {
////        NSLog(@"手势数量 %lu",(unsigned long)myCollectionView.gestureRecognizers.count);
//        [myCollectionView removeGestureRecognizer:[myCollectionView.gestureRecognizers objectAtIndex:0]];
//    }
    
    int i = 0;
    for (UIGestureRecognizer *gesture in myCollectionView.gestureRecognizers) {
        if (i > 1 && [gesture isKindOfClass:[UIPanGestureRecognizer class]]) {
            [myCollectionView removeGestureRecognizer:gesture];
        }
        i++;
    }
    
    [finishEditItem setEnabled:NO];
}

#pragma mark 手动排序

- (void)panGestureRecognizer:(UIPanGestureRecognizer *)sender
{
    UIPanGestureRecognizer *pan = sender;
   
#if 1
    //iOS9以下
    static NSIndexPath *sourceIndexPath = nil;
    static UIView *mappingImageCell = nil;
    
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:{
            CGPoint location = [pan locationInView:myCollectionView];
            NSIndexPath* indexPath = [myCollectionView indexPathForItemAtPoint:location];
            if (!indexPath) return;
            
            sourceIndexPath = indexPath;
            UICollectionViewCell* targetCell = [myCollectionView cellForItemAtIndexPath:sourceIndexPath];
            //得到当前cell的映射(截图)
            UIView* cellView = [targetCell snapshotViewAfterScreenUpdates:YES];
            mappingImageCell = cellView;
            mappingImageCell.frame = cellView.frame;
            targetCell.hidden = YES;
            [myCollectionView addSubview:mappingImageCell];
            
            cellView.center = targetCell.center;
        }
            break;
        case UIGestureRecognizerStateChanged:{
            CGPoint point = [pan locationInView:myCollectionView];
            //更新cell的位置
            mappingImageCell.center = point;
            NSIndexPath * indexPath = [myCollectionView indexPathForItemAtPoint:point];
            if (indexPath == nil) return;
            
            if (![indexPath isEqual:sourceIndexPath])
            {
                //改变数据源
                [webAppData exchangeObjectAtIndex:indexPath.row withObjectAtIndex:sourceIndexPath.row];
                [myCollectionView moveItemAtIndexPath:sourceIndexPath toIndexPath:indexPath];
                sourceIndexPath = indexPath;
            }
        }
            break;
        case UIGestureRecognizerStateEnded: {
            UICollectionViewCell *cell = [myCollectionView cellForItemAtIndexPath:sourceIndexPath];
            
            [UIView animateWithDuration:0.25 animations:^{
                mappingImageCell.center = cell.center;
            } completion:^(BOOL finished) {
                [mappingImageCell removeFromSuperview];
                cell.hidden = NO;
                mappingImageCell = nil;
                sourceIndexPath = nil;
            }];
        }
            break;
        default:
            mappingImageCell = nil;
            sourceIndexPath = nil;
            break;
    }
#else
    //iOS9以上
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:{
            //判断手势落点位置是否在路径上
            NSIndexPath *indexPath = [myCollectionView indexPathForItemAtPoint:[pan locationInView:myCollectionView]];
            if (indexPath == nil) {
                break;
            }
            //在路径上则开始移动该路径上的cell
            [myCollectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
            NSLog(@"1111");
        }
            break;
        case UIGestureRecognizerStateChanged:
            //移动过程当中随时更新cell位置
            [myCollectionView updateInteractiveMovementTargetPosition:[pan locationInView:myCollectionView]];
            NSLog(@"2222");
            break;
        case UIGestureRecognizerStateEnded:
            //移动结束后关闭cell移动
            [myCollectionView endInteractiveMovement];
            NSLog(@"3333");
            break;
        default:
            [myCollectionView cancelInteractiveMovement];
            NSLog(@"4444");
            break;
    }
#endif
}

#pragma mark - iOS9以上UICollectionViewDataSource代理
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath{
    //返回YES允许其item移动
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath {
    //取出源item数据
    id objc = [webAppData objectAtIndex:sourceIndexPath.item];
    //从资源数组中移除该数据
    [webAppData removeObject:objc];
    //将数据插入到资源数组中的目标位置上
    [webAppData insertObject:objc atIndex:destinationIndexPath.item];
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
    
    for (int i = 9; i < 50; i++) {
        NSDictionary *cell = @{@"appImage": [UIImage imageNamed:@"page"],@"appTitle":[NSString stringWithFormat:@"测试%d",i],@"canDelete":[NSNumber numberWithBool:YES]};
        [webAppData addObject:cell];
    }
}

@end
