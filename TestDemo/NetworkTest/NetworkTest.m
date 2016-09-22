//
//  NetworkTest.m
//  TestDemo
//
//  Created by zhongk on 9/14/16.
//  Copyright © 2016 vane.greenisland. All rights reserved.
//

#import "NetworkTest.h"
#import "AFNetWorking.h"

#import <CommonCrypto/CommonDigest.h>

@implementation NetworkTest
{
    AFHTTPSessionManager *manager;
}

//网络测试
- (void)startNetworkTest
{
    manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://mam1.ft-power.com.cn:10001/netplatform-node/service/"]]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =  [AFJSONResponseSerializer serializer];
    
    manager.requestSerializer.timeoutInterval = 15.0;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", nil];
    
    NSSet <NSData *> *cerSet = [AFSecurityPolicy certificatesInBundle:[NSBundle mainBundle]];
    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate withPinnedCertificates:cerSet];
    
    //AFN测试
    //    [manager GET:@"node/getNode.do" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    //        [alert show];
    //        NSLog(@"%@",responseObject);
    //    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    //        [alert show];
    //        NSLog(@"%@",error);
    //    }];
    
    [self addDLHeaderWithPath:@"category/getapptype.do" andParm:@{@"userType":@"allapp"} andIsIMServer:NO];
    [manager POST:@"category/getapptype.do" parameters:@{@"userType":@"allapp"} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        NSLog(@"%@",error);
    }];
}

- (void)addDLHeaderWithPath:(NSString *)path andParm:(NSDictionary*)parmDic andIsIMServer:(BOOL)isIMServer
{
    UIDevice *device = [UIDevice currentDevice];
    NSString *uuid = [[self generateUUID] lowercaseString];
    [manager.requestSerializer setValue:device.systemVersion forHTTPHeaderField:@"osVersion"];
    [manager.requestSerializer setValue:@"" forHTTPHeaderField:@"imei"];
    [manager.requestSerializer setValue:@"utf-8" forHTTPHeaderField:@"Accept-Charset"];
    [manager.requestSerializer setValue:@"" forHTTPHeaderField:@"macAddr"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%.f*%.f",320.0,480.0] forHTTPHeaderField:@"scrSize"];
    [manager.requestSerializer setValue:@"iphone" forHTTPHeaderField:@"brand"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@.20",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]] forHTTPHeaderField:@"versionName"];
    [manager.requestSerializer setValue:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] forHTTPHeaderField:@"versionCode"];
    [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"osType"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%d",0] forHTTPHeaderField:@"lockStatus"];
    [manager.requestSerializer setValue:uuid forHTTPHeaderField:@"deviceId"];
    
    NSString *preHash = @"jsepc";
    NSString *appClientCode = @"511";
    NSString *appCode = @"NETPLAT";
    NSString *appServerCode = @"GETAPPTYPE";
    
    UInt64 recordTime = [[NSDate date] timeIntervalSince1970]*1000;
    NSString *timeStamp = [NSString stringWithFormat:@"%llu",recordTime];
    
    NSString *headerHash = [self sortAndHashCoder:@[uuid,appClientCode,appCode,appServerCode,timeStamp,preHash]];
    [manager.requestSerializer setValue:appClientCode forHTTPHeaderField:@"APPCLIENTCODE"];
    [manager.requestSerializer setValue:appCode forHTTPHeaderField:@"APPCODE"];
    [manager.requestSerializer setValue:appServerCode forHTTPHeaderField:@"APPSERVERCODE"];
    [manager.requestSerializer setValue:timeStamp forHTTPHeaderField:@"TIMESTAMP"];
    [manager.requestSerializer setValue:headerHash forHTTPHeaderField:@"HASH"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"MAM_iOS_Internal/%@ Pub",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]] forHTTPHeaderField:@"User-Agent"];
    
    [manager.requestSerializer setValue:@"23" forHTTPHeaderField:@"proCode"];
    
    //添加HASHDATA字段
    if (parmDic)
    {
        NSString *bodyStr = [self getJsonStringWith:parmDic];
        bodyStr = [bodyStr stringByAppendingString:timeStamp];
        bodyStr = [bodyStr stringByAppendingString:uuid];
        bodyStr = [self md5StringForString:bodyStr];
        [manager.requestSerializer setValue:bodyStr forHTTPHeaderField:@"HASHDATA"];
    }
    
    [manager.requestSerializer setValue:@"Encryption_None" forHTTPHeaderField:@"Accept-Encoding"];
}

- (NSString *)sortAndHashCoder:(NSArray *)array
{
    array  = [array sortedArrayUsingSelector:@selector(compare:)];
    
    NSString *strResult = @"";
    for (NSString *strObj in array)
    {
        strResult = [strResult stringByAppendingString:strObj];
    }
    
    strResult = [self md5StringForString:strResult];
    
    return strResult;
}

- (NSString *)md5StringForString:(NSString *)string {
    const char *str = [string UTF8String];
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, strlen(str), r);
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10], r[11], r[12], r[13], r[14], r[15]];
}

- (NSString *)getJsonStringWith:(NSDictionary *)dic
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:0 error:&error];
    if (!jsonData)
    {
        return nil;
    }
    else
    {
        NSString *JSONString = [[NSString alloc] initWithBytes:[jsonData bytes]
                                                        length:[jsonData length]
                                                      encoding:NSUTF8StringEncoding];
        return JSONString;
    }
}

- (NSString *)generateUUID
{
    NSString *result = nil;
    
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    if (uuid)
    {
        result = (__bridge_transfer NSString *)CFUUIDCreateString(NULL, uuid);
        CFRelease(uuid);
    }
    
    return result;
}

@end
