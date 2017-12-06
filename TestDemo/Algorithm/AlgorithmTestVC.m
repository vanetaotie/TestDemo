//
//  AlgorithmTestVC.m
//  TestDemo
//
//  Created by vane on 06/12/2017.
//  Copyright © 2017 vane.greenisland. All rights reserved.
//

#import "AlgorithmTestVC.h"

@interface AlgorithmTestVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation AlgorithmTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(self);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"冒泡排序(Bubble Sort)";
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"选择排序(Simple Selection Sort)";
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"插入排序(Straight Insertion Sort)";
    } else if (indexPath.row == 3) {
        cell.textLabel.text = @"希尔排序(Shell Sort)";
    } else if (indexPath.row == 4) {
        cell.textLabel.text = @"堆排序(Heap Sort)";
    } else if (indexPath.row == 5) {
        cell.textLabel.text = @"归并排序(Merging Sort)";
    } else if (indexPath.row == 6) {
        cell.textLabel.text = @"快速排序(Quick Sort)";
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView  = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

@end
