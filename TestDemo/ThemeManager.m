//
//  ThemeManager.m
//  SkinnedUI
//
//  Created by QFish on 12/3/12.
//  Copyright (c) 2012 QFish.Net. All rights reserved.
//

#import "ThemeManager.h"
#import "NSXMLElement+XMPP.h"


@implementation ThemeManager

@synthesize theme = _theme;
@synthesize mainTitleColor = _mainTitleColor;
@synthesize commonColor = _commonColor;
@synthesize topBarDownColor = _topBarDownColor;
@synthesize bottomBarDownColor = _bottomBarDownColor;
@synthesize fontType = _fontType;
@synthesize backGroundColor = _backGroundColor;
@synthesize commonDownColor = _commonDownColor;
@synthesize segmentedControlColor = _segmentedControlColor;
@synthesize colorType = _colorType;

+ (ThemeManager *)sharedInstance
{
    static dispatch_once_t once;
    static ThemeManager *instance = nil;
    dispatch_once( &once, ^{ instance = [[ThemeManager alloc] init]; } );
    return instance;
}

- (void)setTheme:(NSString *)theme
{
    if (_theme)
    {
        _theme = nil;;
    }
    _theme = [theme copy];
    
    [[NSUserDefaults standardUserDefaults] setObject:theme forKey:kThemeSetting];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:kThemeDidChangeNotification
     object:_theme];
    
}

- (UIImage *)imageWithImageName:(NSString *)imageName
{
    if ([_theme isEqualToString:kDefaultTheme]) {
        return [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",imageName]];
    }

    NSString *topicPath = [PATH_OF_DOCUMENT stringByAppendingPathComponent:_theme];
    NSString *resourcePath = [NSString stringWithFormat:@"%@/resource",topicPath];
    NSString *imageNewName = [imageName stringByAppendingString:@"@2x.png"];
    NSString *directory = [NSString stringWithFormat:@"%@/%@",resourcePath,imageNewName];
    
    UIImage *image = [UIImage imageWithContentsOfFile:directory];
//    UIImage *image = [UIImage imageNamed:directory];
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
    NSString *imagePath = [bundle pathForResource:imageName ofType:@".png"];
    
    return [UIImage imageWithContentsOfFile:imagePath];
}

- (NSString *)theme
{
    if ( _theme == nil )
    {
        _theme = [[NSUserDefaults standardUserDefaults] objectForKey:kThemeSetting];
    }
    return _theme;
}

- (UIColor *)mainTitleColor
{
    UIColor *color = [[UIColor alloc]init];
    if (![DL_Current_Theme isEqualToString:kDefaultTheme]) {
        color = [self getColorFormXml:@"mainTitleColor"];
    }
    return color;
}

- (UIColor *)commonColor
{
    UIColor *color = [[UIColor alloc]init];
    if (![DL_Current_Theme isEqualToString:kDefaultTheme]) {
        color = [self getColorFormXml:@"commonColor"];
    }
    return color;
}

- (UIColor *)commonDownColor
{
    UIColor *color = [[UIColor alloc]init];
    if (![DL_Current_Theme isEqualToString:kDefaultTheme]) {
        color = [self getColorFormXml:@"commonDownColor"];
    }
    return color;
}

- (UIColor *)topBarDownColor
{
    UIColor *color = [[UIColor alloc]init];
    if (![DL_Current_Theme isEqualToString:kDefaultTheme]) {
        color = [self getColorFormXml:@"topBarDownColor"];
    }
    return color;
}

- (UIColor *)segmentedControlColor
{
    UIColor *color = [[UIColor alloc]init];
    if (![DL_Current_Theme isEqualToString:kDefaultTheme]) {
        color = [self getColorFormXml:@"segmentedControlColor"];
    }
    return color;
}

- (UIColor *)bottomBarDownColor
{
    UIColor *color = [[UIColor alloc]init];
    if (![DL_Current_Theme isEqualToString:kDefaultTheme]) {
        color = [self getColorFormXml:@"bottomBarDownColor"];
    }
    return color;
}

- (UIColor *)backGroundColor
{
    UIColor *color = [[UIColor alloc]init];
    if (![DL_Current_Theme isEqualToString:kDefaultTheme]) {
        color = [self getColorFormXml:@"backGroundColor"];
    }
    return color;
}

-(NSString*)colorType
{
    NSString *colortype = @"GREEN";
    if (![_theme isEqualToString:kDefaultTheme]) {
        
        NSString *topicPath = [PATH_OF_DOCUMENT stringByAppendingPathComponent:_theme];
        
        NSString *configXmlPath = [topicPath  stringByAppendingPathComponent:@"config.xml"];
        NSString *xmlString = [[NSString alloc] initWithContentsOfFile:configXmlPath encoding:NSUTF8StringEncoding error:nil];
        NSXMLElement* xmlEle = [[DDXMLElement alloc] initWithXMLString:xmlString error:nil];
        
        colortype = [[xmlEle elementForName:@"colorType"] stringValue];
    }
    return colortype;
}

- (NSInteger)fontType
{
    NSInteger font = 1;
    if (![_theme isEqualToString:kDefaultTheme]) {
        
        NSString *topicPath = [PATH_OF_DOCUMENT stringByAppendingPathComponent:_theme];
        
        NSString *configXmlPath = [topicPath stringByAppendingPathComponent:@"config.xml"];
        NSString *xmlString = [[NSString alloc] initWithContentsOfFile:configXmlPath encoding:NSUTF8StringEncoding error:nil];
        NSXMLElement* xmlEle = [[DDXMLElement alloc] initWithXMLString:xmlString error:nil];
        
        NSString *fontString = [[xmlEle elementForName:@"fontType"] stringValue];
        font = [fontString intValue];
    }
    return font;
}

-(UIColor *)getColorFormXml:(NSString*)colorValue
{
    NSString *topicPath = [PATH_OF_DOCUMENT stringByAppendingPathComponent:_theme];
    
    NSString *configXmlPath = [topicPath stringByAppendingPathComponent:@"config.xml"];
    NSString *xmlString = [[NSString alloc] initWithContentsOfFile:configXmlPath encoding:NSUTF8StringEncoding error:nil];
    NSXMLElement* xmlEle = [[DDXMLElement alloc] initWithXMLString:xmlString error:nil];
    
    NSString *colorString = [[xmlEle elementForName:colorValue] stringValue];
    NSArray *colorArr = [colorString componentsSeparatedByString:@","];
    float colorR = [colorArr[0] floatValue];
    float colorG = [colorArr[1] floatValue];
    float colorB = [colorArr[2] floatValue];

    UIColor *color = RGBA(colorR,colorG,colorB, 1.0);
    return color;
}

@end
