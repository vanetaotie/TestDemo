//
//  DLApi.m
//  TestDemo
//
//  Created by zhongk on 01/08/2017.
//  Copyright © 2017 vane.greenisland. All rights reserved.
//

#import "DLApi.h"
#import <UIKit/UIKit.h>

static DLApiObject *apiObj;

@implementation DLApi

+ (BOOL)registerApp:(NSString *)appID {
    
    return YES;
}

+ (BOOL)sendOAuthReq:(DLApiObject *)req {
    apiObj = req;
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"yidongmenhudlxx://shouquan?%@&%@",req.appID,req.state]];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
        return YES;
    }
    return NO;
}

+ (BOOL)handleOpenURL:(NSURL *)url
             delegate:(id<DLApiDelegate>)delegate{
    NSString *valueUrl = url.absoluteString;
    NSString *tempStr = [[valueUrl componentsSeparatedByString:@"?"] lastObject];
    NSArray *arr = [tempStr componentsSeparatedByString:@"&"];
    NSString *authCode = [arr objectAtIndex:0];
    NSString *state = [arr objectAtIndex:1];
    
    if ([state isEqualToString:apiObj.state]) {
        [delegate respAuthCode:authCode errorString:@""];
        return YES;
    } else {
        [delegate respAuthCode:@"" errorString:@"状态码不一致"];
        return NO;
    }
}

@end
