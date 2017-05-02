//
//  ThemeManager.m
//  SkinnedUI
//
//  Created by QFish on 12/3/12.
//  Copyright (c) 2012 QFish.Net. All rights reserved.
//

#import "ThemeManager.h"

@implementation ThemeManager

+ (ThemeManager *)sharedInstance
{
    static dispatch_once_t once;
    static ThemeManager *instance = nil;
    dispatch_once( &once, ^{ instance = [[ThemeManager alloc] init]; } );
    return instance;
}

- (UIImage *)imageWithImageName:(NSString *)imageName
{
    NSString *topicPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:kDefaultTheme];
    NSString *resourcePath = [NSString stringWithFormat:@"%@/resource",topicPath];
    NSString *imageNewName = [imageName stringByAppendingString:@"@2x.png"];
    NSString *directory = [NSString stringWithFormat:@"%@/%@",resourcePath,imageNewName];
    
    UIImage *image = [UIImage imageWithContentsOfFile:directory];
    if (image) {
        return image;
    }
    else
    {
        return [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",imageName]];
    }
}

//获取CommonResource图片
- (UIImage *)imageWithGeneralName:(NSString *)imageName {
    NSString *rescourcePath = [[NSBundle mainBundle] pathForResource:@"CommonResource" ofType:@"bundle"];
    NSBundle *bundle =[NSBundle bundleWithPath:rescourcePath];
//    NSString *imagePath = [bundle pathForResource:imageName ofType:@".png" inDirectory:nil];
    NSString *imagePath = [[bundle resourcePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",imageName]];
    
    return [UIImage imageWithContentsOfFile:imagePath];
}

@end
