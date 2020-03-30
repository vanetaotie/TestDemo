//
//  SingleFilterView.m
//  TestDemo
//
//  Created by vane on 2020/3/28.
//  Copyright © 2020 vane.greenisland. All rights reserved.
//

#import "SingleFilterView.h"

@interface SingleFilterView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIButton *confirmBtn;
@property (nonatomic, strong) NSMutableArray *selectedArray;

@end

@implementation SingleFilterView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self initView];
    }
    return self;
}

- (void)initView {
    [self addSubview:self.tableView];
    [self addSubview:self.lineView];
    [self addSubview:self.cancelBtn];
    [self addSubview:self.confirmBtn];
}

- (void)reloadData {
    if (self.filterItemModel.supportMutiSelect) {
        self.tableView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), kSingleFilterCellHeight*self.filterItemModel.contentArray.count);
        self.lineView.frame = CGRectMake(0, CGRectGetMaxY(self.tableView.frame), CGRectGetWidth(self.frame), 0.5);
        self.cancelBtn.frame = CGRectMake(0, CGRectGetMaxY(self.tableView.frame)+0.5, CGRectGetWidth(self.frame)/2, kSingleFilterBtnHeight);
        self.confirmBtn.frame = CGRectMake(CGRectGetWidth(self.frame)/2, CGRectGetMaxY(self.tableView.frame), CGRectGetWidth(self.frame) / 2, kSingleFilterBtnHeight);
        
        UIBezierPath *cornerRadiusPath = [UIBezierPath bezierPathWithRoundedRect:self.cancelBtn.bounds byRoundingCorners:UIRectCornerBottomLeft cornerRadii:CGSizeMake(10, 10)];
        CAShapeLayer *cornerRadiusLayer = [[CAShapeLayer alloc] init];
        cornerRadiusLayer.frame = self.cancelBtn.bounds;
        cornerRadiusLayer.path = cornerRadiusPath.CGPath;
        self.cancelBtn.layer.mask = cornerRadiusLayer;
        
        UIBezierPath *cornerRadiusPath1 = [UIBezierPath bezierPathWithRoundedRect:self.confirmBtn.bounds byRoundingCorners:UIRectCornerBottomRight cornerRadii:CGSizeMake(10, 10)];
        CAShapeLayer *cornerRadiusLayer1 = [[CAShapeLayer alloc] init];
        cornerRadiusLayer1.frame = self.confirmBtn.bounds;
        cornerRadiusLayer1.path = cornerRadiusPath1.CGPath;
        self.confirmBtn.layer.mask = cornerRadiusLayer1;
    } else {
        self.tableView.frame = self.bounds;
        self.lineView.frame = CGRectZero;
        self.cancelBtn.frame = CGRectZero;
        self.confirmBtn.frame = CGRectZero;
    }
    
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.filterItemModel.contentArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SingleFilterCell *cell =[tableView dequeueReusableCellWithIdentifier:@"SingleFilterCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[SingleFilterCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SingleFilterCell"];
    }
    
    FliterContentModel *model = self.filterItemModel.contentArray[indexPath.row];
    [cell setCellData:model];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FliterContentModel *model = self.filterItemModel.contentArray[indexPath.row];

    if (self.filterItemModel.supportMutiSelect) {
        
        model.isSelected = !model.isSelected;
        if (model.isSelected) {
            [self.selectedArray addObject:model];
        } else {
            [self.selectedArray removeObject:model];
        }
    } else {
        
        model.isSelected = YES;
        
        for (FliterContentModel *tempModel in self.filterItemModel.contentArray) {
            if (![tempModel isEqual:model]) {
                tempModel.isSelected = NO;
            }
        }
        
        if (self.confirmBlock) {
            self.confirmBlock(@[model]);
        }
    }
    
    [self.tableView reloadData];
}

- (void)cancelBtnClick:(UIButton *)sender {
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}

- (void)confirmBtnClick:(UIButton *)sender {
    if (self.confirmBlock) {
        self.confirmBlock(self.selectedArray);
    }
}

#pragma mark - Getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.rowHeight = kSingleFilterCellHeight;
        [_tableView registerClass:[SingleFilterCell class] forCellReuseIdentifier:@"SingleFilterCell"];
    }
    return _tableView;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor colorWithRed:102.0/255 green:102.0/255 blue:102.0/255 alpha:0.4];
    }
    return _lineView;
}

- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:kFilterTextColor forState:UIControlStateNormal];
        [_cancelBtn setBackgroundColor:[UIColor whiteColor]];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_cancelBtn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (UIButton *)confirmBtn {
    if (!_confirmBtn) {
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_confirmBtn setBackgroundColor:kFilterSelectTextColor];
        _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_confirmBtn addTarget:self action:@selector(confirmBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmBtn;
}

- (NSMutableArray *)selectedArray {
    if (!_selectedArray) {
        _selectedArray = [NSMutableArray new];
    }
    return _selectedArray;
}

@end

@interface SingleFilterCell ()

@property (nonatomic, strong) UILabel *contentTitleLabel;

@end

@implementation SingleFilterCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}

- (void)initView {
    [self addSubview:self.contentTitleLabel];
    
    [self.contentTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.centerY.equalTo(self);
    }];
}

- (void)setCellData:(FliterContentModel *)model {
    self.contentTitleLabel.text = model.contentTitle;
    
    if (model.isSelected) {
        self.contentTitleLabel.textColor = kFilterSelectTextColor;
    } else {
        self.contentTitleLabel.textColor = kFilterTextColor;
    }
}

#pragma mark - Getter
- (UILabel *)contentTitleLabel {
    if (!_contentTitleLabel) {
        _contentTitleLabel = [[UILabel alloc] init];
        _contentTitleLabel.font = [UIFont systemFontOfSize:13.0];
        _contentTitleLabel.textColor = kFilterTextColor;
    }
    return _contentTitleLabel;
}

@end
