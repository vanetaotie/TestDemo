//
//  WebViewController.m
//  TestDemo
//
//  Created by zhongk on 11/14/16.
//  Copyright © 2016 vane.greenisland. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController () <UIWebViewDelegate>

@end

@implementation WebViewController
{
    UIWebView *_myWebView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _myWebView = [[UIWebView alloc] initWithFrame:self.view.frame];
    [_myWebView setDelegate:self];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://183.207.186.44:19113/test.html"]];
    [_myWebView loadRequest:request];
    [self.view addSubview:_myWebView];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 400, 100, 40)];
    [btn setTitle:@"清除缓存" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(cleanWebViewCache) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
}

- (void)cleanWebViewCache {
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *each in cookieStorage.cookies) {
        [cookieStorage deleteCookie:each];
    }
    
    NSURLCache * cache = [NSURLCache sharedURLCache];
    [cache removeAllCachedResponses];
    [cache setDiskCapacity:0];
    [cache setMemoryCapacity:0];
    
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"清除成功" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
    [av show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
