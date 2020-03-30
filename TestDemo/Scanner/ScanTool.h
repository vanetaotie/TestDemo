//
//  ScanTool.h
//  TestDemo
//
//  Created by vane on 2020/3/30.
//  Copyright © 2020 vane.greenisland. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ScanToolDelegate<NSObject>

@required
- (void)didRecieveScanResult:(NSString *)resultString;

@end

@interface ScanTool : NSObject

@property (weak, nonatomic) id<ScanToolDelegate> delegate;

- (instancetype)initWithPreview:(UIView *)preview;
- (void)showPreviewLayer;
- (void)stopPreviewLayer;

@end

NS_ASSUME_NONNULL_END
