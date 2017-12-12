//
//  WebViewController.m
//  TestDemo
//
//  Created by zhongk on 11/14/16.
//  Copyright © 2016 vane.greenisland. All rights reserved.
//

#import "WebViewController.h"
#import <WebKit/WebKit.h>

@interface WebViewController () <UIWebViewDelegate, WKNavigationDelegate>

@property (strong, nonatomic) UIWebView *uiWebView;
@property (strong, nonatomic) WKWebView *wkWebView;

@property (strong, nonatomic) UIScrollView *myview;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initWKWebView];

    NSString *height_str = @"37592";//37592
    NSLog(@"string = %@, %f",height_str, self.wkWebView.frame.size.height);

    CGRect frame = self.wkWebView.frame;
    frame.size.height = [height_str floatValue];
    self.wkWebView.frame = frame;

    NSLog(@"string = %@, %f",height_str, self.wkWebView.frame.size.height);

    [self requestWK];
    
    
    
//    [self initUIWebView];
//
//    NSString *height_str = @"37592";//37592
//    NSLog(@"string = %@, %f",height_str, self.uiWebView.frame.size.height);
//
//    CGRect frame = self.uiWebView.frame;
//    frame.size.height = [height_str floatValue];
//    self.uiWebView.frame = frame;
//
//    NSLog(@"string = %@, %f",height_str, self.uiWebView.frame.size.height);
//
//    [self requestUI];
    
    
    
//    [self.view addSubview:self.myview];
//
//    NSString *height_str = @"37592";//37592
//    NSLog(@"string = %@, %f",height_str, self.myview.frame.size.height);
//
//    CGRect frame = self.myview.frame;
//    frame.size.height = [height_str floatValue];
//    self.myview.frame = frame;
//
//    NSLog(@"string = %@, %f",height_str, self.myview.frame.size.height);
}

- (UIScrollView *)myview
{
    if (!_myview) {
        _myview = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _myview.backgroundColor = [UIColor yellowColor];
    }
    return _myview;
}

#pragma mark - WKWebviewTest
- (void)initWKWebView
{
    [self.view addSubview:self.wkWebView];
}

- (void)requestWK
{
    [_wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]]];
}

- (WKWebView *)wkWebView
{
    if (!_wkWebView) {
        _wkWebView = [[WKWebView alloc] initWithFrame:self.view.bounds];
        _wkWebView.backgroundColor = [UIColor redColor];
    }
    return _wkWebView;
}

#pragma mark - UIWebviewTest
- (void)initUIWebView
{
    [self.view addSubview:self.uiWebView];
    
//    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 400, 100, 40)];
//    [btn setTitle:@"清除缓存" forState:UIControlStateNormal];
//    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    [btn addTarget:self action:@selector(cleanWebViewCache:withText:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
}

- (void)requestUI
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.jianshu.com/p/177e44a411db"]];//http://183.207.186.44:19113/test.html
    [self.uiWebView loadRequest:request];
}

- (void)cleanWebViewCache:(NSString *)testA withText:(NSString *)testB {
    NSLog(@"调用cleanWebViewCache成功--%@--%@",testA,testB);
    
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

- (UIWebView *)uiWebView
{
    if (!_uiWebView) {
        _uiWebView = [[UIWebView alloc] initWithFrame:self.view.frame];
        _uiWebView.backgroundColor = [UIColor blueColor];
    }
    return _uiWebView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
