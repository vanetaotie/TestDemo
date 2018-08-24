//
//  AmountView.m
//  TestDemo
//
//  Created by vane on 20/06/2018.
//  Copyright © 2018 vane.greenisland. All rights reserved.
//

#import "AmountView.h"

@interface AmountView ()

@property (strong, nonatomic) UIImageView *backgroundImage;
@property (strong, nonatomic) UIButton *reduceBtn;
@property (strong, nonatomic) UILabel *amountLabel;

@end

@implementation AmountView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView {
    [self addSubview:self.backgroundImage];
    [self addSubview:self.reduceBtn];
    [self addSubview:self.amountLabel];
    
    [self.backgroundImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self);
    }];
    
    [self.reduceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(self);
        make.width.mas_equalTo(35.f);
    }];
    
    [self.amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.reduceBtn.mas_right);
        make.top.right.bottom.equalTo(self);
    }];
}

- (void)reduceCount:(UIButton *)sender {
    
    if (self.amount <= 0) {
        NSLog(@"out");
        return;
    }
    
    self.amount--;
    BLOCK_EXEC(self.amountBlock, self.amount);
}

- (UIImageView *)backgroundImage {
    if (!_backgroundImage) {
        _backgroundImage = [[UIImageView alloc] init];
        _backgroundImage.image = [UIImage imageNamed:@"shoppingcart_new_back"];
    }
    return _backgroundImage;
}

- (UIButton *)reduceBtn {
    if (!_reduceBtn) {
        _reduceBtn = [[UIButton alloc] init];
        [_reduceBtn addTarget:self action:@selector(reduceCount:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _reduceBtn;
}

- (UILabel *)amountLabel {
    if (!_amountLabel) {
        _amountLabel = [[UILabel alloc] init];
        _amountLabel.textAlignment = NSTextAlignmentCenter;
        _amountLabel.font = [UIFont systemFontOfSize:22.0];
        _amountLabel.text = @"0";
    }
    return _amountLabel;
}

- (void)setAmount:(NSInteger)amount {
    _amount = amount;
    if (amount <= 0) {
        self.amountLabel.text = @"1";
    } else {
        self.amountLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)amount];
    }
}

@end
