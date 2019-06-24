//
//  AppDelegate.m
//  TestDemo
//
//  Created by vane on 15/2/2.
//  Copyright (c) 2015年 vane.greenisland. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "UITabBar+Utility.h"
#import "DLApi.h"
#import "NSString+Utility.h"

#import <CommonCrypto/CommonHMAC.h>

#import "FlowViewController.h"
#import "SpecialScrollVC.h"

@interface AppDelegate () <DLApiDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSLog(@"Path---%@", paths);
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.

    SwiftTest *vc = [[SwiftTest alloc] init];
    NSLog(@"SwiftDemo:%@", [vc f1]);
    [vc f2];
    
    char c1, c2;
    c1 = 'a';
    c2 = 97;
    
    NSString *string = @"___VBAR_CONFIG_V1.1.0___{ssid='12345',psk='12345',reboot=1}";
    NSString *md5String = [string zy_md5String];
    NSString *base64String = [md5String zy_base64EncodeString];
//    [self HMacHashWithKey:@"1234512345123451" data:string];
    
    MainViewController *mainVC = [[MainViewController alloc] init];
    UINavigationController *mainNav = [[UINavigationController alloc] initWithRootViewController:mainVC];
    mainNav.tabBarItem.title = @"main";
    
    FlowViewController *testVC = [[FlowViewController alloc] init];
//    SpecialScrollVC *testVC = [[SpecialScrollVC alloc] init];
    UINavigationController *testNav = [[UINavigationController alloc] initWithRootViewController:testVC];
    testVC.tabBarItem.title = @"test";

    UITabBarController *mainTabBarVC = [[UITabBarController alloc] init];
    mainTabBarVC.viewControllers = [NSArray arrayWithObjects:mainNav, testNav, nil];

    [mainTabBarVC.tabBar showBadgeOnItemIndex:1 tabbarNum:2];

    UINavigationController *appNav = [[UINavigationController alloc] initWithRootViewController:mainTabBarVC];
    appNav.navigationBarHidden = YES;
    
    [self.window setRootViewController:appNav];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

-  (NSString *)HMacHashWithKey:(NSString *)key data:(NSString *)data{
    const char *cKey  = [key cStringUsingEncoding:NSASCIIStringEncoding];
    const char *cData = [data cStringUsingEncoding:NSASCIIStringEncoding];
    
    unsigned char cHMAC[CC_SHA256_DIGEST_LENGTH];
    
    //关键部分
    CCHmac(kCCHmacAlgSHA256, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    
    NSData *HMAC = [[NSData alloc] initWithBytes:cHMAC
                                          length:sizeof(cHMAC)];
    
    //将加密结果进行一次BASE64编码。
    NSString *hash = [HMAC base64EncodedStringWithOptions:0];
    return hash;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    if ([url.scheme isEqualToString:@"123456"]) {
        return [DLApi handleOpenURL:url delegate:self];
    }
    
    return YES;
}

- (void)respAuthCode:(NSString *)authCode errorString:(NSString *)errorStr {
    NSLog(@"authCode==================%@",authCode);
    NSLog(@"errorStr==================%@",errorStr);
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
