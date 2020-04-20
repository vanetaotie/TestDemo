//
//  ScanTestViewModel.h
//  TestDemo
//
//  Created by vane on 2020/4/8.
//  Copyright © 2020 vane.greenisland. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ScanTestViewModel : NSObject

- (void)fetchScanGoodsInfo:(BoolBlock)completionBlock;

@end

NS_ASSUME_NONNULL_END
