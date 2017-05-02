//
//  ThemeManager.h
//  SkinnedUI
//
//  Created by QFish on 12/3/12.
//  Copyright (c) 2012 http://QFish.Net All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define kDefaultTheme           @"DefaultTheme"   //默认主题

#define kWhite_Blue             @"White_Blue"

#define kWhite_Green            @"White_Green"


@interface ThemeManager : NSObject

+ (ThemeManager *)sharedInstance;

- (UIImage *)imageWithImageName:(NSString *)imageName;

//获取CommonResource图片
- (UIImage *)imageWithGeneralName:(NSString *)imageName;

@end
