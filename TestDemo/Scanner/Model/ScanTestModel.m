//
//  ScanTestModel.m
//  TestDemo
//
//  Created by vane on 2020/4/8.
//  Copyright © 2020 vane.greenisland. All rights reserved.
//

#import "ScanTestModel.h"

@implementation ScanTestModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        self.goodsCode = [dic objectForKey:@"goodsCode"];
        self.kzCode = [dic objectForKey:@"kzCode"];
        self.goodsName = [dic objectForKey:@"goodsName"];
        self.storeName = [dic objectForKey:@"storeName"];
        self.scanNumber = [dic objectForKey:@"scanNumber"];
    }
    return self;
}

@end
