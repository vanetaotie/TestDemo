//
//  MainViewController.m
//  TestDemo
//
//  Created by vane on 15/2/2.
//  Copyright (c) 2015年 vane.greenisland. All rights reserved.
//

#import "MainViewController.h"
#import "FloatWindowViewController.h"
#import "EventKitTestViewController.h"
#import "CollectionTestViewController.h"
#import "PlayerViewController.h"
#import "KeyBoardViewController.h"
#import "DLAlertViewController.h"
#import "GAndATestViewController.h"
#import "LimitInputViewController.h"

@implementation MainViewController
{
    UITableView *mainTableView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    mainTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [mainTableView setDelegate:self];
    [mainTableView setDataSource:self];
    
    [self.view addSubview:mainTableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 9;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentify = @"cellIdentify";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"SKStoreProductViewController";//StoreKit
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"FloatWindow";//浮动窗口
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"EventKitTest";//日历事件
    } else if (indexPath.row == 3) {
        cell.textLabel.text = @"CollectionViewTest";
    } else if (indexPath.row == 4) {
        cell.textLabel.text = @"AVPlayerTest";
    } else if (indexPath.row == 5) {
        cell.textLabel.text = @"KeyBoardTest";
    } else if (indexPath.row == 6) {
        cell.textLabel.text = @"DLAlertViewTest";
    } else if (indexPath.row == 7) {
        cell.textLabel.text = @"GraphicAndAnimation";
    } else if (indexPath.row == 8) {
        cell.textLabel.text = @"LimitInputTest";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
//        SKStoreProductViewController *storeProductVC = [[SKStoreProductViewController alloc] init];
//        [storeProductVC setDelegate:self];
//        [self presentViewController:storeProductVC animated:YES completion:nil];
//        [storeProductVC loadProductWithParameters:@{SKStoreProductParameterITunesItemIdentifier:@461703208}
//                                  completionBlock:^(BOOL result, NSError *error){
//                                      if (error) {
//                                          NSLog(@"Error %@ with User Info %@", error, [error userInfo]);
//                                      }
//                                  }];
        
        //企业级app无法使用StoreKit
        UIWebView *myWebView = [[UIWebView alloc] init];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://itunes.apple.com/cn/app/wan-bu/id638808347?mt=8"]];
        [self.view addSubview:myWebView];
        [myWebView loadRequest:request];
        
    } else if (indexPath.row == 1) {
        FloatWindowViewController *floatWindowVC = [[FloatWindowViewController alloc] init];
        [[self navigationController] pushViewController:floatWindowVC animated:YES];
    } else if (indexPath.row == 2) {
        EventKitTestViewController *eventKitTestVC = [[EventKitTestViewController alloc] init];
        [[self navigationController] pushViewController:eventKitTestVC animated:YES];
    } else if (indexPath.row == 3) {
        CollectionTestViewController *collectionTestVC = [[CollectionTestViewController alloc] init];
        [[self navigationController] pushViewController:collectionTestVC animated:YES];
    } else if (indexPath.row == 4) {
//        NSURL *videoUrl = [NSURL URLWithString:@"http://www.jxvdy.com/file/upload/201309/18/18-10-03-19-3.mp4"];
        NSURL *videoUrl = [NSURL fileURLWithPath:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"TestFiles/test.mp4"]];
        PlayerViewController *playerVC = [[PlayerViewController alloc] initWithUrl:videoUrl];
        [playerVC showInViewController:self];
    } else if (indexPath.row == 5) {
        KeyBoardViewController *keyBoardVC = [[KeyBoardViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:keyBoardVC];
        [self presentViewController:nav animated:YES completion:nil];
    } else if (indexPath.row == 6) {
        DLAlertViewController *dlAlertVC = [[DLAlertViewController alloc] init];
        [[self navigationController] pushViewController:dlAlertVC animated:YES];
    } else if (indexPath.row == 7) {
        GAndATestViewController *gAndAVC = [[GAndATestViewController alloc] init];
        [[self navigationController] pushViewController:gAndAVC animated:YES];
    } else if (indexPath.row == 8) {
        LimitInputViewController *limitInputVC = [[LimitInputViewController alloc] init];
        [[self navigationController] pushViewController:limitInputVC animated:YES];
    }
}

#pragma mark - SKStoreProductViewControllerDelegate
- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
