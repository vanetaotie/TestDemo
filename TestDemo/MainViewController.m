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
#import "ScrollTextViewController.h"
#import "QCodeTestViewController.h"
#import "NetworkTest.h"
//#import "WebViewController.h"

#import "DLImage.h"
#import "ThemeManager.h"
#import "UITabBar+Utility.h"

@implementation MainViewController
{
    UITableView *mainTableView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    mainTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [mainTableView setDelegate:self];
    [mainTableView setDataSource:self];
    
    [self.view addSubview:mainTableView];
    
    UIButton *addBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [addBtn setImage:IMG_ACCOUNT_HEAD forState:UIControlStateNormal];
    [addBtn setImage:[UIImage imageNamed:@"feiji"] forState:UIControlStateHighlighted];
//    [addBtn addTarget:self action:@selector(rightBarButtonItemClip:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBtnItem = [[UIBarButtonItem alloc] initWithCustomView:addBtn];
    NSArray *buttonArr = [[NSArray alloc]initWithObjects:backBtnItem, nil];
    self.navigationItem.rightBarButtonItems = buttonArr;
    
//    [self.tabBarController.tabBar showBadgeOnItmIndex:0 tabbarNum:2];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 12;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentify = @"cellIdentify";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }
    
    if (indexPath.row == 0) {
//        cell.textLabel.text = @"SKStoreProductViewController";//StoreKit
        cell.textLabel.text = @"NetworkTest";
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
    } else if (indexPath.row == 9) {
        cell.textLabel.text = @"ScrollTextLabel";
    } else if (indexPath.row == 10) {
        cell.textLabel.text = @"QCodeTest";
    } else if (indexPath.row == 11) {
        cell.textLabel.text = @"UIWebViewTest";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.tabBarController.tabBar hideBadgeOnItemIndex:0];
    
    if (indexPath.row == 0) {
////        SKStoreProductViewController *storeProductVC = [[SKStoreProductViewController alloc] init];
////        [storeProductVC setDelegate:self];
////        [self presentViewController:storeProductVC animated:YES completion:nil];
////        [storeProductVC loadProductWithParameters:@{SKStoreProductParameterITunesItemIdentifier:@461703208}
////                                  completionBlock:^(BOOL result, NSError *error){
////                                      if (error) {
////                                          NSLog(@"Error %@ with User Info %@", error, [error userInfo]);
////                                      }
////                                  }];
//        
//        //企业级app无法使用StoreKit
//        UIWebView *myWebView = [[UIWebView alloc] init];
//        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://itunes.apple.com/cn/app/wan-bu/id638808347?mt=8"]];
//        [self.view addSubview:myWebView];
//        [myWebView loadRequest:request];
        
        NetworkTest *test = [[NetworkTest alloc] init];
        [test startNetworkTest];
//        [test startTestManager];
    } else if (indexPath.row == 1) {
        FloatWindowViewController *floatWindowVC = [[FloatWindowViewController alloc] init];
        [floatWindowVC setHidesBottomBarWhenPushed:YES];
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
    } else if (indexPath.row == 9) {
        ScrollTextViewController *scrollTextVC = [[ScrollTextViewController alloc] init];
        [[self navigationController] pushViewController:scrollTextVC animated:YES];
    } else if (indexPath.row == 10) {
        QCodeTestViewController *qCodeVC = [[QCodeTestViewController alloc] init];
        [[self navigationController] pushViewController:qCodeVC animated:YES];
    } else if (indexPath.row == 11) {
//        WebViewController *webVC = [[WebViewController alloc] init];
//        [[self navigationController] pushViewController:webVC animated:YES];
        
        //实例方法
//        id webViewController;
//        Class myClass = NSClassFromString(@"WebViewController");
//        if (myClass) {
//            webViewController = [myClass new];
//        }
//        SEL sel = NSSelectorFromString(@"cleanWebViewCache:withText:");
//        if (webViewController && [webViewController respondsToSelector:sel]) {
//            [webViewController performSelector:sel withObject:@"aaaaa" withObject:@"bbbbb"];
//        }
        
        //类方法
        Class myClass = NSClassFromString(@"WebViewController");
        SEL sel = NSSelectorFromString(@"testMethod:withText:");
        if (myClass && [myClass respondsToSelector:sel]) {
            [[myClass class] performSelector:sel withObject:@"aaa" withObject:@"bbb"];
        }
    }
}

#pragma mark - SKStoreProductViewControllerDelegate
- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
