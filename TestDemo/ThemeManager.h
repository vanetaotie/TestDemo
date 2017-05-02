//
//  ThemeManager.h
//  SkinnedUI
//
//  Created by QFish on 12/3/12.
//  Copyright (c) 2012 http://QFish.Net All rights reserved.
//

#import <Foundation/Foundation.h>

#define kDefaultTheme           @"DefaultTheme"   //默认主题

#define kWhite_Blue             @"White_Blue"

#define kWhite_Green            @"White_Green"


@interface ThemeManager : NSObject

@property (strong, nonatomic) NSString *theme;
@property (strong, nonatomic) UIColor *mainTitleColor;
@property (strong, nonatomic) UIColor *commonColor;
@property (strong, nonatomic) UIColor *topBarDownColor;
@property (strong, nonatomic) UIColor *bottomBarDownColor;
@property (assign, nonatomic) NSInteger fontType;
@property (strong, nonatomic) NSString *colorType;
@property (strong, nonatomic) UIColor *segmentedControlColor;
@property (strong, nonatomic) UIColor *backGroundColor;
@property (strong, nonatomic) UIColor *commonDownColor;

+ (ThemeManager *)sharedInstance;

- (UIImage *)imageWithImageName:(NSString *)imageName;

//获取CommonResource图片
- (UIImage *)imageWithGeneralName:(NSString *)imageName;

@end
