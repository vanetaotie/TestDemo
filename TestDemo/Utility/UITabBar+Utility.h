//
//  UITabBar+Utility.h
//  TestDemo
//
//  Created by zhongk on 02/05/2017.
//  Copyright © 2017 vane.greenisland. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (Utility)
/**
 tabbar显示小红点
 
 @param index 第几个控制器显示，从0开始算起
 @param tabbarNum tabbarcontroller一共多少个控制器
 */
- (void)showBadgeOnItemIndex:(int)index tabbarNum:(int)tabbarNum;

/**
 隐藏红点
 
 @param index 第几个控制器隐藏，从0开始算起
 */
- (void)hideBadgeOnItemIndex:(int)index;

/**
 移除控件
 
 @param index 第几个控制器要移除控件，从0开始算起
 */
- (void)removeBadgeOnItemIndex:(int)index;
@end
