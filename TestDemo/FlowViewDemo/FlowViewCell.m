//
//  FlowViewCell.m
//  TestDemo
//
//  Created by vane on 2019/1/29.
//  Copyright © 2019 vane.greenisland. All rights reserved.
//

#import "FlowViewCell.h"

@interface FlowViewCell ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation FlowViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blueColor];
        
        [self addSubview:self.label];
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
    }
    return self;
}

- (void)setCellData:(id)data indexPath:(NSIndexPath *)indexPath{
    NSString *text = [NSString stringWithFormat:@"%ld-(%@)", (long)indexPath.row, data];
    self.label.text = text;
}

- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.textColor = [UIColor redColor];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [UIFont systemFontOfSize:14];
    }
    return _label;
}

@end
