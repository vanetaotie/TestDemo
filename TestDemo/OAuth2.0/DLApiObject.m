//
//  DLApiObject.m
//  TestDemo
//
//  Created by zhongk on 01/08/2017.
//  Copyright © 2017 vane.greenisland. All rights reserved.
//

#import "DLApiObject.h"

@implementation DLApiObject

- (id)init {
    if ([super init]) {
        _scope = @"snsapi_userinfo";
    }
    return self;
}

@end
