//
//  FilterTestViewController.m
//  TestDemo
//
//  Created by vane on 2020/3/27.
//  Copyright © 2020 vane.greenisland. All rights reserved.
//

#import "FilterTestViewController.h"
#import "FilterBar.h"
#import "FilterModel.h"

@interface FilterTestViewController ()

@property (nonatomic, strong) FilterBar *filterBar;
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation FilterTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self initData];
    [self initView];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.filterBar closeAllBar];
}

- (void)initData {
    self.dataArray = @[@{@"title":@"状态",@"filterId":@"1",@"type":@"1",@"muti":@1,@"content":@[@{@"title":@"未入库",@"sortId":@"1"},
                                                                  @{@"title":@"已完成",@"sortId":@"2"},
                                                                  @{@"title":@"已关闭",@"sortId":@"3"}]},
                       @{@"title":@"业务类型",@"filterId":@"2",@"type":@"1",@"muti":@0,@"content":@[@{@"title":@"智能货柜",@"sortId":@"7"},
                                                                    @{@"title":@"天猫养车",@"sortId":@"8"}]},
                       @{@"title":@"区域选择",@"filterId":@"3",@"type":@"3"}];
}

- (void)initView {
    [self.view addSubview:self.filterBar];
}

- (FilterBar *)filterBar {
    if (!_filterBar) {
        _filterBar = [[FilterBar alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 50) filterArray:self.dataArray];
        
        WS(weakSelf);
        _filterBar.selectFilterCompletion = ^(NSArray * _Nonnull filterCondition) {
            NSLog(@"%@",filterCondition);
            
            //打印结果****
            NSString *resultString = @"筛选条件：";
            for (NSDictionary *dic in filterCondition) {
                
                for (NSString *key in dic) {
                    NSArray *valueArray = [dic objectForKey:key];
                    
                    for (FliterContentModel *model in valueArray) {
                        resultString = [resultString stringByAppendingString:[NSString stringWithFormat:@"%@+",model.contentTitle]];
                    }
                }
            }
            resultString = [resultString substringToIndex:([resultString length]-1)];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:resultString delegate:weakSelf cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            //打印结果****
        };
    }
    return _filterBar;
}

@end
