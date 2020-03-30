//
//  FilterModel.m
//  TestDemo
//
//  Created by vane on 2020/3/27.
//  Copyright © 2020 vane.greenisland. All rights reserved.
//

#import "FilterModel.h"

@implementation FilterModel

- (instancetype)initWithArray:(NSArray *)array {
    self = [super init];
    if (self) {
        for (NSDictionary *filterInfo in array){
            FilterItemModel *filterItem = [[FilterItemModel alloc] initWithDic:filterInfo];
            [self.filterItemArray addObject:filterItem];
        }
    }
    return self;
}

- (NSMutableArray *)filterItemArray {
    if (!_filterItemArray) {
        _filterItemArray = [NSMutableArray new];
    }
    return _filterItemArray;
}

@end


@implementation FilterItemModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        self.filterName = [dic objectForKey:@"title"];
        self.filterId = [dic objectForKey:@"filterId"];
        self.filterType = [[dic objectForKey:@"type"] integerValue];
        self.supportMutiSelect = [[dic objectForKey:@"muti"] boolValue];
        
        NSArray *contentArray = [dic objectForKey:@"content"];
        for (NSDictionary *contentDic in contentArray) {
            FliterContentModel *model = [[FliterContentModel alloc] initWithDic:contentDic];
            [self.contentArray addObject:model];
        }
    }
    return self;
}

- (NSMutableArray *)contentArray {
    if (!_contentArray) {
        _contentArray = [NSMutableArray new];
    }
    return _contentArray;
}

@end


@implementation FliterContentModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        self.contentTitle = [dic objectForKey:@"title"];
        self.contentSortId = [dic objectForKey:@"sortId"];
    }
    return self;
}

@end
