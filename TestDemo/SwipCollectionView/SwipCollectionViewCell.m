//
//  SwipCollectionViewCell.m
//  TestDemo
//
//  Created by vane on 15/06/2018.
//  Copyright © 2018 vane.greenisland. All rights reserved.
//

#import "SwipCollectionViewCell.h"
#import "AmountView.h"

@interface SwipCollectionViewCell ()

@property (strong, nonatomic) UIView *customView;
@property (strong, nonatomic) AmountView *amountView;

@end

@implementation SwipCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.revealView = self.customView;
        
        [self.contentView addSubview:self.amountView];
        [self.amountView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(90.f, 35.f));
        }];
    }
    return self;
}

- (void)setCellData:(NSArray *)array indexPath:(NSIndexPath *)indexPath {
    NSInteger num = [array[indexPath.row] integerValue];
    
    self.amountView.amount = num;
}

- (void)deleteAction:(UIButton *)sender {
    NSLog(@"删除");
    [self hideRevealViewAnimated:YES];
}

- (void)moreAction:(UIButton *)sender {
    NSLog(@"更多");
}

//调整数量
- (void)reduceAmountWithNumber:(NSInteger)number {
    if (number == 0) {
        NSLog(@"删除cell");
    }
    NSLog(@"%ld",(long)number);
}

- (UIView *)customView {
    if (!_customView) {
        _customView = ({
            UIView *tmpView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width - 160, 0, 160, self.frame.size.height)];
            tmpView.backgroundColor = [UIColor clearColor];
            tmpView;
        });
        UIButton *deleteButton = ({
            UIButton *tmpBtn = [[UIButton alloc] initWithFrame:CGRectMake(_customView.frame.size.width - 80, 0, 80, _customView.frame.size.height)];
            [tmpBtn setTitle:self.deleteButtonTitle == nil? @"删除":self.deleteButtonTitle forState:UIControlStateNormal];
            [tmpBtn setImage:[UIImage imageNamed:@"shoppingcart_new_delete"] forState:UIControlStateNormal];
            [tmpBtn setTitleEdgeInsets:UIEdgeInsetsMake(tmpBtn.imageView.frame.size.height + 10.0,-tmpBtn.imageView.frame.size.width, 0.0, 0.0)];
            [tmpBtn setImageEdgeInsets:UIEdgeInsetsMake(-tmpBtn.titleLabel.frame.size.height, 0.0, 0.0, -tmpBtn.titleLabel.bounds.size.width)];
            [tmpBtn addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
            [tmpBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [tmpBtn setBackgroundColor:[UIColor colorWithRed:255/255.0 green:58/255.0 blue:58/255.0 alpha:1]];
            tmpBtn.titleLabel.font = [UIFont systemFontOfSize:20];
            tmpBtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
            tmpBtn;
        });
        UIButton *moreButton = ({
            UIButton *tmpBtn = [[UIButton alloc] initWithFrame:CGRectMake(_customView.frame.size.width - 160, 0, 80, _customView.frame.size.height)];
            [tmpBtn setTitle:self.deleteButtonTitle == nil? @"线上\n发货":self.deleteButtonTitle forState:UIControlStateNormal];
            [tmpBtn addTarget:self action:@selector(moreAction:) forControlEvents:UIControlEventTouchUpInside];
            [tmpBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [tmpBtn setBackgroundColor:[UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1]];
            tmpBtn.titleLabel.font = [UIFont systemFontOfSize:20];
            tmpBtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
            tmpBtn;
        });
        [_customView addSubview:deleteButton];
        [_customView addSubview:moreButton];
    }
    return _customView;
}

- (AmountView *)amountView {
    if (!_amountView) {
        _amountView = [[AmountView alloc] init];
        WS(weakSelf);
        _amountView.amountBlock = ^(NSInteger amount) {
            [weakSelf reduceAmountWithNumber:amount];
        };
    }
    return _amountView;
}

@end
