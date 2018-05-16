//
//  HorizontalViewController.m
//  TestDemo
//
//  Created by yoho on 2018/4/26.
//  Copyright © 2018年 vane.greenisland. All rights reserved.
//

#import "HorizontalViewController.h"

@implementation HorizontalModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

@end

@interface HorizontalViewController () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) NSMutableArray *topDataArray;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) UITableView *topTableView;

@end

static CGFloat itemWidth = 75;
static CGFloat itemMargin = 10;
static CGFloat itemHeight = 95;
static CGFloat topViewHeight = 40;
static CGFloat topToItemMargin = 5;
static CGFloat topViewHeaderWidth = 45;

@implementation HorizontalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //生成二维数组
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.dataArray];
    for (int i = 0; i < array.count; i++) {
        HorizontalModel *model = array[i];
        NSMutableArray *tempArray = [NSMutableArray new];
        [tempArray addObject:model.topString];
        for (int j = i + 1; j < array.count; j++) {
            HorizontalModel *lastModel = array[j];
            if ([model.topString isEqualToString:lastModel.topString]) {
                [tempArray addObject:lastModel.topString];
                [array removeObjectAtIndex:j];
                j-=1;
            }
        }
        [self.topDataArray addObject:tempArray];
    }
    
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.topTableView];
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
        for (int i = 0; i < 15; i++) {
            HorizontalModel *model = [[HorizontalModel alloc] init];
            model.isFirst = NO;
            model.title = @"test";
            if (i >= 0 && i < 3) {
                model.topString = @"Str1";
            } else if (i >= 3 && i < 10) {
                model.topString = @"Str2";
            } else {
                model.topString = @"Str3";
            }
            if (i == 0 || i == 3 || i == 10) {
                model.isFirst = YES;
            }
            [_dataArray addObject:model];
        }
    }
    return _dataArray;
}

- (NSMutableArray *)topDataArray
{
    if (!_topDataArray) {
        _topDataArray = [NSMutableArray new];
    }
    return _topDataArray;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(itemWidth, itemHeight);
        layout.sectionInset = UIEdgeInsetsMake(itemMargin, itemMargin, itemMargin, itemMargin);
        layout.minimumLineSpacing = itemMargin;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 300, self.view.frame.size.width, itemHeight+itemMargin*2) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.scrollsToTop = NO;
        [_collectionView registerClass:[HorizontalCell class] forCellWithReuseIdentifier:@"HorizontalCell"];
    }
    return _collectionView;
}

- (UITableView *)topTableView
{
    if (!_topTableView) {
        _topTableView = [[UITableView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-itemMargin*2, self.collectionView.frame.origin.y-(self.view.frame.size.width-itemMargin*2)/2 - topViewHeight/2 - topToItemMargin, topViewHeight, self.view.frame.size.width-itemMargin*2) style:UITableViewStylePlain];
        _topTableView.backgroundColor = [UIColor whiteColor];
        _topTableView.delegate = self;
        _topTableView.dataSource = self;
        _topTableView.showsHorizontalScrollIndicator = NO;
        _topTableView.showsVerticalScrollIndicator = NO;
        _topTableView.scrollsToTop = NO;
        _topTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _topTableView.transform = CGAffineTransformMakeRotation(-M_PI_2);
        _topTableView.bounces = NO;
        _topTableView.scrollEnabled = NO;
        [_topTableView registerClass:[HorizontalTopCell class] forCellReuseIdentifier:@"HorizontalTopCell"];
    }
    return _topTableView;
}

#pragma mark - view联动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.collectionView) {
        CGPoint offset = scrollView.contentOffset;
        self.topTableView.contentOffset = CGPointMake(offset.y, offset.x);
    }
}

#pragma mark - UICollectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HorizontalCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HorizontalCell" forIndexPath:indexPath];
    HorizontalModel *model = self.dataArray[indexPath.row];
    if (model.isFirst) {
        cell.backgroundColor = [UIColor greenColor];
    } else {
        cell.backgroundColor = [UIColor yellowColor];
    }
    [cell setCellData:model];
    
    return cell;
}


#pragma mark - UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.topDataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = self.topDataArray[section];
    return array.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return itemWidth+itemMargin-topViewHeaderWidth;
    }
    return itemWidth+itemMargin;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return topViewHeaderWidth;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HorizontalTopCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HorizontalTopCell" forIndexPath:indexPath];
    cell.contentView.transform = CGAffineTransformMakeRotation(M_PI_2);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.topTableView.frame.size.width, topViewHeaderWidth)];//header宽度30
    view.backgroundColor = [UIColor whiteColor];
    view.transform = CGAffineTransformMakeRotation(M_PI_2);
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, topViewHeaderWidth, 20)];
    label.textAlignment = NSTextAlignmentCenter;
    [view addSubview:label];
    
    label.text = self.topDataArray[section][0];
    
    return view;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

@implementation HorizontalCell
{
    UILabel *titleLabel;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView
{
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, self.frame.size.height)];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:16.0];
    [self addSubview:titleLabel];
}

- (void)setCellData:(HorizontalModel *)model
{
    titleLabel.text = model.title;
}

@end

@implementation HorizontalTopCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView
{
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.contentView.frame.size.height/2, itemWidth+itemMargin, 1)];
    line.backgroundColor = [UIColor blackColor];
    [self.contentView addSubview:line];
}

@end
