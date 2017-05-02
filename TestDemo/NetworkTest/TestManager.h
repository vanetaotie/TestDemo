//
//  TestManager.h
//  TestDemo
//
//  Created by zhongk on 1/10/17.
//  Copyright © 2017 vane.greenisland. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface TestManager : AFHTTPSessionManager

+ (instancetype)sharedClient;

- (instancetype)initWithTestBaseURL:(NSURL *)url;

- (void)setDefaultHeader:(NSString*)header value:(NSString*)value;

@end
