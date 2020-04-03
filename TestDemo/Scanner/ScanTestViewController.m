//
//  ScanTestViewController.m
//  TestDemo
//
//  Created by vane on 2020/3/30.
//  Copyright © 2020 vane.greenisland. All rights reserved.
//

#import "ScanTestViewController.h"
#import "ScanTool.h"
#import "ScanView.h"

@interface ScanTestViewController () <ScanToolDelegate>

@property (strong, nonatomic) ScanView *scanView;
@property (strong, nonatomic) ScanTool *scanTool;
@property (nonatomic, assign) CGRect scanRect;

@end

@implementation ScanTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.scanRect = CGRectMake(self.view.frame.size.width/2-100, 74, 200, 200);
    
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

- (void)startScaning {
    [self.scanTool showPreviewLayer];
    [self.scanView startScanning];
    [self.scanTool setDelegate:self];
}

- (void)stopScaning {
    [self.scanTool stopPreviewLayer];
    [self.scanView stopScanning];
    [self.scanTool setDelegate:nil];
}

#pragma mark - ScanToolDelegate

- (void)didRecieveScanResult:(NSString *)resultString {
    NSLog(@"resultString:%@",resultString);
    
//    [self startScaning];
}

#pragma mark - Getter Method

- (ScanView *)scanView {
    if (!_scanView) {
        _scanView = [[ScanView alloc] initWithFrame:self.view.bounds scanFrame:self.scanRect];
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
