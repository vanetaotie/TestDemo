//
//  TestManager.m
//  TestDemo
//
//  Created by zhongk on 1/10/17.
//  Copyright © 2017 vane.greenisland. All rights reserved.
//

#import "TestManager.h"

static TestManager *_sharedClient = nil;

@implementation TestManager
{
    NSMutableURLRequest *_request;
}

- (id)init {
    self = [super init];
    if (self) {
        _request = [[NSMutableURLRequest alloc] init];
    }
    return self;
}

+ (instancetype)sharedClient {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[TestManager alloc] init];
    });
    return _sharedClient;
}

- (instancetype)initWithTestBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    _request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    return self;
}

- (void)setDefaultHeader:(NSString*)header value:(NSString*)value {
    [_request addValue:value forHTTPHeaderField:header];
}

@end
