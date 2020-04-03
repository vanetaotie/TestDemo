//
//  ScanView.m
//  TestDemo
//
//  Created by vane on 2020/4/3.
//  Copyright © 2020 vane.greenisland. All rights reserved.
//

#import "ScanView.h"

@interface ScanView ()

@property (nonatomic, assign) CGRect scanRect;
@property (strong, nonatomic) UIImageView *scanLineImage;

@end

@implementation ScanView

- (instancetype)initWithFrame:(CGRect)frame scanFrame:(CGRect)rect {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        self.scanRect = rect;
        
        [self initView];
    }
    return self;
}

- (void)initView {
    UIView *bgView = [[UIView alloc] initWithFrame:self.bounds];
    bgView.backgroundColor = [UIColor colorWithRed:102.0/255 green:102.0/255 blue:102.0/255 alpha:0.4];
    [self addSubview:bgView];
    
    UIImageView *scanFrameView = [[UIImageView alloc] initWithFrame:self.scanRect];
    [scanFrameView setImage:[UIImage imageNamed:@"qrCodeFrame"]];
    [self addSubview:scanFrameView];
    
    [self addSubview:self.scanLineImage];
}

- (void)startScanning {
    [self startScanLineAnimation];
}

- (void)stopScanning {
    [self stopScanLineAnimation];
}

- (void)startScanLineAnimation {
    [self stopScanLineAnimation];
    
    self.scanLineImage.frame = CGRectMake(CGRectGetMinX(self.scanRect)+5, CGRectGetMinY(self.scanRect)+5, CGRectGetWidth(self.scanRect)-10, 12);
    CGPoint fromPoint = CGPointMake(CGRectGetMidX(self.scanRect), CGRectGetMinY(self.scanRect)+5);
    CGPoint toPoint = CGPointMake(CGRectGetMidX(self.scanRect), CGRectGetMaxY(self.scanRect)-5);
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.fromValue = [NSValue valueWithCGPoint:fromPoint];
    animation.toValue = [NSValue valueWithCGPoint:toPoint];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.autoreverses = YES;
    animation.duration = 1.5f;
    animation.repeatCount = LONG_LONG_MAX;
    [self.scanLineImage.layer addAnimation:animation forKey:@"LineAnimation"];
}

- (void)stopScanLineAnimation {
    [self.scanLineImage.layer removeAnimationForKey:@"LineAnimation"];
    [self.scanLineImage.layer removeAllAnimations];
}

#pragma mark - Getter Method

- (UIImageView *)scanLineImage {
    if (!_scanLineImage) {
        _scanLineImage = [[UIImageView alloc] init];
        _scanLineImage.image = [UIImage imageNamed:@"qrScanLine"];
    }
    return _scanLineImage;
}

@end
