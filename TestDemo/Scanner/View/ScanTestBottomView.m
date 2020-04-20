//
//  ScanTestBottomView.m
//  TestDemo
//
//  Created by vane on 2020/4/3.
//  Copyright © 2020 vane.greenisland. All rights reserved.
//

#import "ScanTestBottomView.h"

#define kScanBGBlueColor RGBA(101.0,134.0,255.0,1.0)
#define kScanBGGrayColor RGBA(204.0,204.0,204.0,1.0)
#define kScanTextGrayColor RGBA(153.0,153.0,153.0,1.0)

@interface ScanTestBottomView ()

@property (nonatomic, strong) UIView *topStatusBarView;
@property (nonatomic, strong) UILabel *sequenceLabel1;
@property (nonatomic, strong) UILabel *sequenceTip1;
@property (nonatomic, strong) UILabel *sequenceLabel2;
@property (nonatomic, strong) UILabel *sequenceTip2;
@property (nonatomic, strong) UIView *seprateLine;

@property (nonatomic, strong) UIView *emptyView;

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UILabel *goodsCodeLabel;
@property (nonatomic, strong) UILabel *kzCodeLabel;
@property (nonatomic, strong) UILabel *goodsNameTipLabel;
@property (nonatomic, strong) UILabel *goodsNameLabel;
@property (nonatomic, strong) UIView *seprateView;
@property (nonatomic, strong) UILabel *storeNameLabel;
@property (nonatomic, strong) UILabel *scanNumberLabel;
@property (nonatomic, strong) UILabel *currentScanTipLabel;
@property (nonatomic, strong) UIButton *keepOnScanBtn;
@property (nonatomic, strong) UIButton *scanStoreBtn;
@property (nonatomic, strong) UIButton *backToScanGoodsBtn;

@property (nonatomic, assign) ScanModeType currentScanType;

@end

@implementation ScanTestBottomView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self initView];
        [self switchCurrentScanStatus:ScanModeType_Goods];
        
        //test
        [self isContentEmpty:NO];
        [self setContentData:nil];
        //test
    }
    return self;
}

- (void)initView {
    [self addSubview:self.topStatusBarView];
    [self.topStatusBarView addSubview:self.sequenceLabel1];
    [self.topStatusBarView addSubview:self.sequenceTip1];
    [self.topStatusBarView addSubview:self.seprateLine];
    [self.topStatusBarView addSubview:self.sequenceLabel2];
    [self.topStatusBarView addSubview:self.sequenceTip2];
    
    [self addSubview:self.emptyView];
    
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.goodsCodeLabel];
    [self.contentView addSubview:self.kzCodeLabel];
    [self.contentView addSubview:self.goodsNameTipLabel];
    [self.contentView addSubview:self.goodsNameLabel];
    [self.contentView addSubview:self.seprateView];
    [self.contentView addSubview:self.storeNameLabel];
    [self.contentView addSubview:self.scanNumberLabel];
    [self.contentView addSubview:self.currentScanTipLabel];
    [self.contentView addSubview:self.keepOnScanBtn];
    [self.contentView addSubview:self.scanStoreBtn];
    [self.contentView addSubview:self.backToScanGoodsBtn];
    
    [self.sequenceLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.seprateLine).offset(-106);
        make.centerY.equalTo(self.topStatusBarView);
        make.size.mas_equalTo(CGSizeMake(18, 18));
    }];
    
    [self.sequenceTip1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.sequenceLabel1.mas_right).offset(8);
        make.centerY.equalTo(self.topStatusBarView);
        make.size.mas_equalTo(CGSizeMake(60, 20));
    }];
    
    [self.seprateLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.topStatusBarView);
        make.size.mas_equalTo(CGSizeMake(40, 2));
    }];
    
    [self.sequenceLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.seprateLine.mas_right).offset(24);
        make.centerY.equalTo(self.topStatusBarView);
        make.size.mas_equalTo(CGSizeMake(18, 18));
    }];
    
    [self.sequenceTip2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.sequenceLabel2.mas_right).offset(8);
        make.centerY.equalTo(self.topStatusBarView);
        make.size.mas_equalTo(CGSizeMake(60, 20));
    }];
    
    [self.emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.top.equalTo(self.topStatusBarView.mas_bottom);
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.top.equalTo(self.topStatusBarView.mas_bottom);
    }];
    
    [self.goodsCodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.top.equalTo(self.contentView).offset(15);
    }];
    
    [self.kzCodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.top.equalTo(self.goodsCodeLabel.mas_bottom).offset(5);
    }];
    
    [self.goodsNameTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.top.equalTo(self.kzCodeLabel.mas_bottom).offset(5);
    }];
    
    [self.goodsNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(80);
        make.top.equalTo(self.kzCodeLabel.mas_bottom).offset(5);
        make.right.equalTo(self.contentView).offset(-15);
    }];
    
    [self.seprateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.contentView).offset(109);
        make.height.mas_equalTo(9);
    }];
    
    [self.storeNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.top.equalTo(self.seprateView.mas_bottom).offset(13);
    }];
    
    [self.scanNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.top.equalTo(self.storeNameLabel.mas_bottom).offset(5);
    }];
    
    [self.currentScanTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.top.equalTo(self.scanNumberLabel.mas_bottom).offset(5);
    }];
    
    [self.keepOnScanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.bottom.equalTo(self.contentView).offset(-7);
        make.size.mas_equalTo(CGSizeMake((kScreenWidth-29)/2, 40));
    }];
    
    [self.scanStoreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-10);
        make.bottom.equalTo(self.contentView).offset(-7);
        make.size.mas_equalTo(CGSizeMake((kScreenWidth-29)/2, 40));
    }];
    
    [self.backToScanGoodsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.bottom.equalTo(self.contentView).offset(-7);
        make.height.mas_equalTo(40);
    }];
}

#pragma mark - PublicMethod

- (void)setContentData:(ScanTestModel *)model {
    self.goodsCodeLabel.text = [NSString stringWithFormat:@"商品条码：%@",@"123456"];
    self.kzCodeLabel.text = [NSString stringWithFormat:@"康众编码：%@",@"123124122"];
    self.goodsNameLabel.text = @"博世/BOSCH 前刹车片 0986AB2746博世/。/nBOSCH 前刹车片 0986AB2746 ";
    self.storeNameLabel.text = [NSString stringWithFormat:@"推荐库位：%@",@"A01-01-01"];
    self.scanNumberLabel.text = [NSString stringWithFormat:@"待扫描数：%@",@"9"];
    
    [self grayTextByLabel:self.goodsCodeLabel];
    [self grayTextByLabel:self.kzCodeLabel];
    [self grayTextByLabel:self.storeNameLabel];
    [self grayTextByLabel:self.scanNumberLabel];
}

#pragma mark - PrivateMethod

- (void)isContentEmpty:(BOOL)isEmpty {
    self.emptyView.hidden = !isEmpty;
    self.contentView.hidden = isEmpty;
}

- (void)switchCurrentScanStatus:(ScanModeType)modeType {
    self.currentScanType = modeType;
    
    self.keepOnScanBtn.hidden = modeType == ScanModeType_Goods?NO:YES;
    self.scanStoreBtn.hidden = modeType == ScanModeType_Goods?NO:YES;
    self.backToScanGoodsBtn.hidden = modeType == ScanModeType_Goods?YES:NO;
    
    if (modeType == ScanModeType_Goods) {
        self.sequenceLabel1.backgroundColor = kScanBGBlueColor;
        self.sequenceTip1.textColor = kScanBGBlueColor;
        
        self.sequenceLabel2.backgroundColor = kScanBGGrayColor;
        self.sequenceTip2.textColor = kScanTextGrayColor;
    } else {
        self.sequenceLabel1.backgroundColor = kScanBGGrayColor;
        self.sequenceTip1.textColor = kScanTextGrayColor;
        
        self.sequenceLabel2.backgroundColor = kScanBGBlueColor;
        self.sequenceTip2.textColor = kScanBGBlueColor;
    }
}

//修改冒号部分文字颜色
- (void)grayTextByLabel:(UILabel *)label
{
    if ([label.text containsString:@"："]) {
        NSMutableAttributedString *noteString = [[NSMutableAttributedString alloc] initWithString:label.text];
        NSRange stringRange = NSMakeRange(0, [[noteString string] rangeOfString:@"："].location + 1);
        [noteString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:13.0] range:stringRange];
        [noteString addAttribute:NSForegroundColorAttributeName value:kScanTextGrayColor range:stringRange];
        [label setAttributedText:noteString];
    }
}

#pragma mark - Actions

- (void)keepOnScan:(UIButton *)sender {
    
}

- (void)scanStore:(UIButton *)sender {
    [self switchCurrentScanStatus:ScanModeType_Store];
}

- (void)backToScanGoods:(UIButton *)sender {
    [self switchCurrentScanStatus:ScanModeType_Goods];
}

#pragma mark - Getter

- (UIView *)topStatusBarView {
    if (!_topStatusBarView) {
        _topStatusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 44)];
        _topStatusBarView.backgroundColor = [UIColor colorWithRed:247.0f/255.0f green:247.0f/255.0f blue:247.0f/255.0f alpha:1.0f];
        
        UIBezierPath *cornerRadiusPath = [UIBezierPath bezierPathWithRoundedRect:_topStatusBarView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
        CAShapeLayer *cornerRadiusLayer = [[CAShapeLayer alloc] init];
        cornerRadiusLayer.frame = _topStatusBarView.bounds;
        cornerRadiusLayer.path = cornerRadiusPath.CGPath;
        _topStatusBarView.layer.mask = cornerRadiusLayer;
    }
    return _topStatusBarView;
}

- (UILabel *)sequenceLabel1 {
    if (!_sequenceLabel1) {
        _sequenceLabel1 = [[UILabel alloc] init];
        _sequenceLabel1.font = [UIFont boldSystemFontOfSize:12];
        _sequenceLabel1.backgroundColor = kScanBGBlueColor;
        _sequenceLabel1.textColor = [UIColor whiteColor];
        _sequenceLabel1.textAlignment = NSTextAlignmentCenter;
        _sequenceLabel1.layer.cornerRadius = ceil(18/2.0);
        _sequenceLabel1.layer.masksToBounds = YES;
        _sequenceLabel1.text = @"1";
    }
    return _sequenceLabel1;
}

- (UILabel *)sequenceLabel2 {
    if (!_sequenceLabel2) {
        _sequenceLabel2 = [[UILabel alloc] init];
        _sequenceLabel2.font = [UIFont boldSystemFontOfSize:12];
        _sequenceLabel2.backgroundColor = kScanBGGrayColor;
        _sequenceLabel2.textColor = [UIColor whiteColor];
        _sequenceLabel2.textAlignment = NSTextAlignmentCenter;
        _sequenceLabel2.layer.cornerRadius = ceil(18/2.0);
        _sequenceLabel2.layer.masksToBounds = YES;
        _sequenceLabel2.text = @"2";
    }
    return _sequenceLabel2;
}

- (UILabel *)sequenceTip1 {
    if (!_sequenceTip1) {
        _sequenceTip1 = [[UILabel alloc] init];
        _sequenceTip1.font = [UIFont systemFontOfSize:14];
        _sequenceTip1.textColor = kScanBGBlueColor;
        _sequenceTip1.text = @"扫描商品";
    }
    return _sequenceTip1;
}

- (UILabel *)sequenceTip2 {
    if (!_sequenceTip2) {
        _sequenceTip2 = [[UILabel alloc] init];
        _sequenceTip2.font = [UIFont systemFontOfSize:14];
        _sequenceTip2.textColor = kScanTextGrayColor;
        _sequenceTip2.text = @"扫描库位";
    }
    return _sequenceTip2;
}

- (UIView *)seprateLine {
    if (!_seprateLine) {
        _seprateLine = [[UIView alloc] init];
        _seprateLine.backgroundColor = kScanBGGrayColor;
    }
    return _seprateLine;
}

- (UIView *)emptyView {
    if (!_emptyView) {
        _emptyView = [[UIView alloc] init];
        _emptyView.backgroundColor = [UIColor whiteColor];
        
        UILabel *tipLabel = [[UILabel alloc] init];
        tipLabel.font = [UIFont systemFontOfSize:13];
        tipLabel.textColor = kScanTextGrayColor;
        tipLabel.textAlignment = NSTextAlignmentCenter;
        tipLabel.text = @"请先扫描商品";
        [_emptyView addSubview:tipLabel];
        [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_emptyView).offset(141);
            make.size.mas_equalTo(CGSizeMake(self.frame.size.width, 19));
        }];
        
        UIButton *quitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [quitBtn setTitle:@"退出扫码" forState:UIControlStateNormal];
        [quitBtn setTitleColor:kScanBGBlueColor forState:UIControlStateNormal];
        [quitBtn.titleLabel setFont:[UIFont systemFontOfSize:17]];
        quitBtn.layer.cornerRadius = 20;
        quitBtn.layer.borderColor = kScanBGBlueColor.CGColor;
        quitBtn.layer.borderWidth = 1.0;
        quitBtn.layer.masksToBounds = YES;
        [_emptyView addSubview:quitBtn];
        [quitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_emptyView).offset(10);
            make.right.equalTo(_emptyView).offset(-10);
            make.bottom.equalTo(_emptyView).offset(-7);
            make.height.mas_equalTo(40);
        }];
    }
    return _emptyView;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor whiteColor];
    }
    return _contentView;
}

- (UILabel *)goodsCodeLabel {
    if (!_goodsCodeLabel) {
        _goodsCodeLabel = [[UILabel alloc] init];
        _goodsCodeLabel.font = [UIFont systemFontOfSize:13];
        _goodsCodeLabel.textColor = [UIColor blackColor];
    }
    return _goodsCodeLabel;
}

- (UILabel *)kzCodeLabel {
    if (!_kzCodeLabel) {
        _kzCodeLabel = [[UILabel alloc] init];
        _kzCodeLabel.font = [UIFont systemFontOfSize:13];
        _kzCodeLabel.textColor = [UIColor blackColor];
    }
    return _kzCodeLabel;
}

- (UILabel *)goodsNameTipLabel {
    if (!_goodsNameTipLabel) {
        _goodsNameTipLabel = [[UILabel alloc] init];
        _goodsNameTipLabel.font = [UIFont systemFontOfSize:13];
        _goodsNameTipLabel.textColor = kScanTextGrayColor;
        _goodsNameTipLabel.text = @"商品名称：";
    }
    return _goodsNameTipLabel;
}

- (UILabel *)goodsNameLabel {
    if (!_goodsNameLabel) {
        _goodsNameLabel = [[UILabel alloc] init];
        _goodsNameLabel.font = [UIFont systemFontOfSize:13];
        _goodsNameLabel.textColor = [UIColor blackColor];
        _goodsNameLabel.numberOfLines = 2;
        _goodsNameLabel.preferredMaxLayoutWidth = kScreenWidth - 65.0;
    }
    return _goodsNameLabel;
}

- (UIView *)seprateView {
    if (!_seprateView) {
        _seprateView = [[UIView alloc] init];
        _seprateView.backgroundColor = RGBA(247.0,247.0,247.0,1.0);
    }
    return _seprateView;
}

- (UILabel *)storeNameLabel {
    if (!_storeNameLabel) {
        _storeNameLabel = [[UILabel alloc] init];
        _storeNameLabel.font = [UIFont systemFontOfSize:13];
        _storeNameLabel.textColor = [UIColor blackColor];
    }
    return _storeNameLabel;
}

- (UILabel *)scanNumberLabel {
    if (!_scanNumberLabel) {
        _scanNumberLabel = [[UILabel alloc] init];
        _scanNumberLabel.font = [UIFont systemFontOfSize:13];
        _scanNumberLabel.textColor = [UIColor blackColor];
    }
    return _scanNumberLabel;
}

- (UILabel *)currentScanTipLabel {
    if (!_currentScanTipLabel) {
        _currentScanTipLabel = [[UILabel alloc] init];
        _currentScanTipLabel.font = [UIFont systemFontOfSize:13];
        _currentScanTipLabel.textColor = kScanTextGrayColor;
        _currentScanTipLabel.text = @"本次扫描：";
    }
    return _currentScanTipLabel;
}

- (UIButton *)keepOnScanBtn {
    if (!_keepOnScanBtn) {
        _keepOnScanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_keepOnScanBtn setTitle:@"继续扫描" forState:UIControlStateNormal];
        [_keepOnScanBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_keepOnScanBtn.titleLabel setFont:[UIFont systemFontOfSize:17]];
        [_keepOnScanBtn setBackgroundColor:kScanBGBlueColor];
        _keepOnScanBtn.layer.cornerRadius = 20;
        _keepOnScanBtn.layer.masksToBounds = YES;
        [_keepOnScanBtn addTarget:self action:@selector(keepOnScan:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _keepOnScanBtn;
}

- (UIButton *)scanStoreBtn {
    if (!_scanStoreBtn) {
        _scanStoreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_scanStoreBtn setTitle:@"扫描库位" forState:UIControlStateNormal];
        [_scanStoreBtn setTitleColor:kScanBGBlueColor forState:UIControlStateNormal];
        [_scanStoreBtn.titleLabel setFont:[UIFont systemFontOfSize:17]];
        _scanStoreBtn.layer.cornerRadius = 20;
        _scanStoreBtn.layer.borderColor = kScanBGBlueColor.CGColor;
        _scanStoreBtn.layer.borderWidth = 1.0;
        _scanStoreBtn.layer.masksToBounds = YES;
        [_scanStoreBtn addTarget:self action:@selector(scanStore:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _scanStoreBtn;
}

- (UIButton *)backToScanGoodsBtn {
    if (!_backToScanGoodsBtn) {
        _backToScanGoodsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backToScanGoodsBtn setTitle:@"返回扫描商品" forState:UIControlStateNormal];
        [_backToScanGoodsBtn setTitleColor:kScanBGBlueColor forState:UIControlStateNormal];
        [_backToScanGoodsBtn.titleLabel setFont:[UIFont systemFontOfSize:17]];
        _backToScanGoodsBtn.layer.cornerRadius = 20;
        _backToScanGoodsBtn.layer.borderColor = kScanBGBlueColor.CGColor;
        _backToScanGoodsBtn.layer.borderWidth = 1.0;
        _backToScanGoodsBtn.layer.masksToBounds = YES;
        [_backToScanGoodsBtn addTarget:self action:@selector(backToScanGoods:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backToScanGoodsBtn;
}

@end
