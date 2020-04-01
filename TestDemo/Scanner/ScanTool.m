//
//  ScanTool.m
//  TestDemo
//
//  Created by vane on 2020/3/30.
//  Copyright © 2020 vane.greenisland. All rights reserved.
//

#import "ScanTool.h"

@interface ScanTool ()<AVCaptureMetadataOutputObjectsDelegate>

@property (strong, nonatomic) AVCaptureVideoPreviewLayer *previewLayer;
@property (strong, nonatomic) AVCaptureDevice *device;
@property (strong, nonatomic) AVCaptureDeviceInput *avInput;
@property (strong, nonatomic) AVCaptureMetadataOutput *outPut;
@property (strong, nonatomic) AVCaptureSession *session;
@property (weak, nonatomic) UIView *preview;
@property (nonatomic, assign) CGRect cropRect;

@end

@implementation ScanTool

- (instancetype)initWithPreview:(UIView *)preview cropFrame:(CGRect)cropRect {
    if (self = [super init]) {
        self.preview = preview;
        self.cropRect = cropRect;
    }
    return self;
}

- (void)showPreviewLayer {
    [self stopPreviewLayer];
    
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    NSError *error = nil;
    
    self.avInput = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:&error];
    if (error) {
        NSLog(@"启动相机失败");
        return;
    }
    
    self.outPut = [[AVCaptureMetadataOutput alloc] init];
    [self.outPut setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    self.session = [[AVCaptureSession alloc] init];
    [self.session setSessionPreset:AVCaptureSessionPresetHigh];
    
    if ([self.session canAddInput:self.avInput]) {
        [self.session addInput:self.avInput];
    } else {
        NSLog(@"启动相机失败");
        return;
    }
    
    if ([self.session canAddOutput:self.outPut]) {
        [self.session addOutput:self.outPut];
    } else {
        NSLog(@"启动相机失败");
        return;
    }
    
    self.outPut.metadataObjectTypes = @[AVMetadataObjectTypeQRCode,
                                        AVMetadataObjectTypeEAN8Code,
                                        AVMetadataObjectTypeEAN13Code,
                                        AVMetadataObjectTypeCode128Code];
    CGRect cropRect = self.cropRect;
    self.outPut.rectOfInterest = CGRectMake(cropRect.origin.y/kScreenHeight, cropRect.origin.x/kScreenWidth, cropRect.size.height/kScreenHeight, cropRect.size.width/kScreenWidth);
    
    self.previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    self.previewLayer.frame = self.preview.bounds;
    [self.preview.layer insertSublayer:self.previewLayer atIndex:0];
    [self.session startRunning];
}

- (void)stopPreviewLayer {
    [self.session stopRunning];
    [self.previewLayer removeFromSuperlayer];
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate

- (void)captureOutput:(AVCaptureOutput *)output didOutputMetadataObjects:(NSArray<__kindof AVMetadataObject *> *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    [self.session stopRunning];
    NSLog(@"stop session");
    
    NSString *stringValue = nil;
    if ([metadataObjects count] > 0){
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
        if (stringValue &&[_delegate respondsToSelector:@selector(didRecieveScanResult:)]) {
            [_delegate didRecieveScanResult:stringValue];
        }
    }
}


@end
