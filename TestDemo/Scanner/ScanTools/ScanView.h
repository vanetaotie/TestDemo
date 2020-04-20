//
//  ScanView.h
//  TestDemo
//
//  Created by vane on 2020/4/3.
//  Copyright © 2020 vane.greenisland. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ScanView : UIView

- (instancetype)initWithFrame:(CGRect)frame scanFrame:(CGRect)rect;

- (void)startScanning;
- (void)stopScanning;

@end

NS_ASSUME_NONNULL_END
