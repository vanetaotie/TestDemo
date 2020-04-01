//
//  ScanTestViewController.m
//  TestDemo
//
//  Created by vane on 2020/3/30.
//  Copyright © 2020 vane.greenisland. All rights reserved.
//

#import "ScanTestViewController.h"
#import "ScanTool.h"

@interface ScanTestViewController () <ScanToolDelegate>

@property (strong, nonatomic) UIView *scanView;
@property (strong, nonatomic) UIImageView *scanLineImage;
@property (strong, nonatomic) ScanTool *scanTool;
@property (nonatomic, assign) CGRect scanRect;

@end

@implementation ScanTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.scanRect = CGRectMake(80, 125, 200, 200);
    
    [self.view addSubview:self.scanView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startScaning) name:UIApplicationWillEnterForegroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopScaning) name:UIApplicationDidEnterBackgroundNotification object:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self startScaning];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self stopScaning];
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

- (void)startScaning {
    [self.scanTool showPreviewLayer];
    [self startScanLineAnimation];
    [self.scanTool setDelegate:self];
}

- (void)stopScaning {
    [self.scanTool stopPreviewLayer];
    [self stopScanLineAnimation];
    [self.scanTool setDelegate:nil];
}

#pragma mark - ScanToolDelegate

- (void)didRecieveScanResult:(NSString *)resultString {
    NSLog(@"resultString:%@",resultString);
    
//    [self startScaning];
}

#pragma mark - Getter Method

- (UIImageView *)scanLineImage {
    if (!_scanLineImage) {
        _scanLineImage = [[UIImageView alloc] init];
        _scanLineImage.image = [UIImage imageNamed:@"qrScanLine"];
    }
    return _scanLineImage;
}

- (UIView *)scanView {
    if (!_scanView) {
        _scanView = [[UIView alloc] initWithFrame:self.view.bounds];
        _scanView.backgroundColor = [UIColor blackColor];
        
        UIView *bgView = [[UIView alloc] initWithFrame:self.view.bounds];
        bgView.backgroundColor = [UIColor colorWithRed:102.0/255 green:102.0/255 blue:102.0/255 alpha:0.4];
        [_scanView addSubview:bgView];
        
        UIImageView *scanFrameView = [[UIImageView alloc] initWithFrame:self.scanRect];
        [scanFrameView setImage:[UIImage imageNamed:@"qrCodeFrame"]];
        [_scanView addSubview:scanFrameView];
        
        [_scanView addSubview:self.scanLineImage];
    }
    return _scanView;
}

- (ScanTool *)scanTool {
    if (!_scanTool) {
        _scanTool = [[ScanTool alloc] initWithPreview:self.scanView cropFrame:self.scanRect];
    }
    return _scanTool;
}

@end
