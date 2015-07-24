//
//  CollectionTestViewController.h
//  TestDemo
//
//  Created by vane on 15/2/27.
//  Copyright (c) 2015年 vane.greenisland. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionCell.h"

@interface CollectionTestViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIAlertViewDelegate,CollectionCellDelegate>
{
    UICollectionView *myCollectionView;
    NSMutableArray *webAppData; //存储获取的数据源
    NSMutableArray *appsCells; //存储生成的cell用于遍历
    
    UIBarButtonItem *finishEditItem;//完成编辑模式
    UIPanGestureRecognizer *panGesture;//移动cell手势
    UIAlertView *downloadAlartView;//进入下载提示
}

@end
