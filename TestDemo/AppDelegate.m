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

@interface AppDelegate () <DLApiDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    NSLog(@"yoho1");

    MainViewController *mainVC = [[MainViewController alloc] init];
    UINavigationController *mainNav = [[UINavigationController alloc] initWithRootViewController:mainVC];
    mainNav.tabBarItem.title = @"main";
    
    UIViewController *testVC = [[UIViewController alloc] init];
    testVC.tabBarItem.title = @"test";
    
    UIViewController *testVC2 = [[UIViewController alloc] init];
    testVC2.tabBarItem.title = @"test2";
    
    UITabBarController *mainTabBarVC = [[UITabBarController alloc] init];
    mainTabBarVC.viewControllers = [NSArray arrayWithObjects:mainNav, testVC, testVC2, nil];
    
    [mainTabBarVC.tabBar showBadgeOnItmIndex:0 tabbarNum:3];
    [mainTabBarVC.tabBar showBadgeOnItmIndex:1 tabbarNum:3];
    
    UINavigationController *appNav = [[UINavigationController alloc] initWithRootViewController:mainTabBarVC];
    appNav.navigationBarHidden = YES;
    //***********************语法测试***********************

    int x = 12345;
    int s = 0;
    while (x != 0) {
        s = s * 10 + x % 10;
        x = x / 10;
    }
    
    NSLog(@"%d",s);

    //***********************语法测试***********************
    
    [self.window setRootViewController:appNav];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
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
