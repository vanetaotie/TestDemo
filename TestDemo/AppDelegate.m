//
//  AppDelegate.m
//  TestDemo
//
//  Created by vane on 15/2/2.
//  Copyright (c) 2015年 vane.greenisland. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.

    MainViewController *mainVC = [[MainViewController alloc] init];
    UINavigationController *mainNav = [[UINavigationController alloc] initWithRootViewController:mainVC];
    
    //***********************语法测试***********************

    int x = 12345;
    int s = 0;
    while (x != 0) {
        s = s * 10 + x % 10;
        x = x / 10;
    }
    
    NSLog(@"%d",s);
    
    NSString *urlString = @"http://robocob.tp-ecp.com:8081/robocop-web/appview/action.do?method=linkFileContextURL&pass=1490860436963&ID=1074755&pub=0&UUID=b7d4869c-2d01-47cc-b15d-60017cc97c68";
    NSURL *url = [NSURL URLWithString:urlString];
    
    //***********************语法测试***********************
    
    [self.window setRootViewController:mainNav];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
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
