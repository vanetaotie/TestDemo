//
//  UITabBar+Utility.m
//  TestDemo
//
//  Created by zhongk on 02/05/2017.
//  Copyright © 2017 vane.greenisland. All rights reserved.
//

#import "UITabBar+Utility.h"

@implementation UITabBar (Utility)

- (void)showBadgeOnItmIndex:(int)index tabbarNum:(int)tabbarNum {
    [self removeBadgeOnItemIndex:index];
    //label为小红点，并设置label属性
    UILabel *label = [[UILabel alloc]init];
    label.tag = 1000+index;
    label.layer.cornerRadius = 5;
    label.clipsToBounds = YES;
    label.backgroundColor = [UIColor redColor];
    CGRect tabFrame = self.frame;
    
    //计算小红点的X值，根据第index控制器，小红点在每个tabbar按钮的中部偏移0.1，即是每个按钮宽度的0.6倍
    CGFloat percentX = (index+0.6);
    CGFloat tabBarButtonW = CGRectGetWidth(tabFrame)/tabbarNum;
    CGFloat x = percentX*tabBarButtonW;
    CGFloat y = 0.1*CGRectGetHeight(tabFrame);
    //10为小红点的高度和宽度
    label.frame = CGRectMake(x, y, 10, 10);
    
    [self addSubview:label];
    //把小红点移到最顶层
    [self bringSubviewToFront:label];
}

- (void)hideBadgeOnItemIndex:(int)index {
    [self removeBadgeOnItemIndex:index];
}

- (void)removeBadgeOnItemIndex:(int)index {
    for (UIView*subView in self.subviews) {
        if (subView.tag == 1000+index) {
            [subView removeFromSuperview];
        }
    }
}
@end
