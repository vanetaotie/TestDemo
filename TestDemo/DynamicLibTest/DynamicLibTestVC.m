//
//  DynamicLibTestVC.m
//  TestDemo
//
//  Created by vane on 2021/12/27.
//  Copyright © 2021 vane.greenisland. All rights reserved.
//

#import "DynamicLibTestVC.h"
#include <dlfcn.h>

@interface DynamicLibTestVC ()

@end

@implementation DynamicLibTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(120, 100, 150, 50)];
    [button1 setBackgroundColor:[UIColor blueColor]];
    [button1 setTitle:@"使用NSBundle加载动态库" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(btnClick1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(120, 200, 150, 50)];
    [button2 setBackgroundColor:[UIColor blueColor]];
    [button2 setTitle:@"使用dlopen加载动态库" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(btnClick2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    UIButton *button3 = [[UIButton alloc] initWithFrame:CGRectMake(120, 300, 150, 50)];
    [button3 setBackgroundColor:[UIColor blueColor]];
    [button3 setTitle:@"调用动态库中的方法" forState:UIControlStateNormal];
    [button3 addTarget:self action:@selector(btnClick3) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
}

- (void)btnClick1
{
    //从服务器去下载并且存入Documents下(只要知道存哪里即可),事先要知道framework名字,然后去加载
    NSString *frameworkPath = [NSString stringWithFormat:@"%@/Documents/DynamicLlibTest.framework",NSHomeDirectory()];
    
    NSError *err = nil;
    NSBundle *bundle = [NSBundle bundleWithPath:frameworkPath];
    NSString *str = @"加载动态库失败!";
    if ([bundle loadAndReturnError:&err]) {
        NSLog(@"bundle load framework success.");
        str = @"加载动态库成功!";
    } else {
        NSLog(@"bundle load framework err:%@",err);
    }
}

- (void)btnClick2
{
    // 动态库中真正的可执行代码为DynamicLlib.framework/DynamicLlib文件，因此使用dlopen时指定加载动态库的路径为DynamicLlib.framework/DynamicLlib
    NSString *documentsPath = [NSString stringWithFormat:@"%@/Documents/DynamicLlibTest.framework/DynamicLlibTest",NSHomeDirectory()];
    if (dlopen([documentsPath cStringUsingEncoding:NSUTF8StringEncoding], RTLD_NOW) == NULL) {
        char *error = dlerror();
        NSLog(@"dlopen error: %s", error);
    } else {
        NSLog(@"dlopen load framework success.");
    }
}

- (void)btnClick3
{
    Class DynamicLlibClass = NSClassFromString(@"DynamicLlib");
    if(DynamicLlibClass){
        //事先要知道有什么方法在这个framework中
        id object = [[DynamicLlibClass alloc] init];
        //由于没有引入相关头文件故通过performSelector调用
        [object performSelector:@selector(doSomething)];
    }else {
        NSLog(@"调用方法失败!");
    }
}
@end
