//
//  ScanTestBottomView.h
//  TestDemo
//
//  Created by vane on 2020/4/3.
//  Copyright © 2020 vane.greenisland. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScanTestModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, ScanModeType) {
    ScanModeType_Goods,
    ScanModeType_Store,
};

@interface ScanTestBottomView : UIView

- (void)setContentData:(ScanTestModel *)model;

@end

NS_ASSUME_NONNULL_END
