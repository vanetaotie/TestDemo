//
//  CutImageViewController.m
//  TestDemo
//
//  Created by vane on 29/09/2017.
//  Copyright © 2017 vane.greenisland. All rights reserved.
//

#import "CutImageViewController.h"
#import "CutImageView.h"

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
#define _750scale(scale) (((kWidth) * scale) / (750.0))     // 以@2x为比例的适配

@interface CutImageViewController ()

@property (nonatomic, strong) UIImage *originImage;

@end

@implementation CutImageViewController
{
    CutImageView *_cutView;
    CAShapeLayer *_fillLayer;
    int _moveCorner;    // 判断是第几个角(若无则为0)
    
    UIImageView *_backgroundView;
    UIButton *_cutOkBtn;
    UIButton *_cutCancelBtn;
}

- (instancetype)initWithOriginImage:(UIImage *)originImage {
    if ([super init]) {
        self.originImage = originImage;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)configUI {
    self.view.backgroundColor = [UIColor blackColor];
    
    _backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, kWidth, kHeight - 64 * 2)];
    _backgroundView.image = self.originImage;
    [self.view addSubview:_backgroundView];
    
    _cutOkBtn = [[UIButton alloc] initWithFrame:CGRectMake(kWidth - 64, kHeight - 64, 64, 64)];
    [_cutOkBtn setTitle:@"确定" forState:UIControlStateNormal];
    [_cutOkBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _cutOkBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [_cutOkBtn addTarget:self action:@selector(cutOkBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_cutOkBtn];
    
    _cutCancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, kHeight - 64, 64, 64)];
    [_cutCancelBtn setTitle:@"取消 " forState:UIControlStateNormal];
    [_cutCancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _cutCancelBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [_cutCancelBtn addTarget:self action:@selector(cutCancleBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_cutCancelBtn];
    
    //阴影背景
    _fillLayer = [CAShapeLayer layer];
    [self.view.layer addSublayer:_fillLayer];
    
    //裁剪框
    if (_cutView) {
        _cutView.hidden = NO;
    } else {
        _cutView = [[CutImageView alloc] initWithFrame:CGRectMake(0, 0, kWidth - 15, kWidth - 15)];
        _cutView.emptyView.userInteractionEnabled = NO;
        _cutView.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2);
        [self.view addSubview:_cutView];
    }
    
    [self changeShadowWithFrame];
}

// 确定裁剪
- (void)cutOkBtnClick
{
    UIImage *newImage = [self screenView:self.view];
    
    [self cutCancleBtnClick];
    
    if (self.cutSuccessBlock) {
        self.cutSuccessBlock(newImage);
    }
}

// 取消裁剪
- (void)cutCancleBtnClick
{
    //返回
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 镂空区域
- (void)changeShadowWithFrame
{
    //中间镂空的矩形框
    CGRect myRect = CGRectMake(_cutView.frame.origin.x + 8, _cutView.frame.origin.y + 8, _cutView.frame.size.width - 16, _cutView.frame.size.height - 16);
    //背景
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 64, kWidth, kHeight - 64 * 2) cornerRadius:0];
    //镂空
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithRect:myRect];
    [path appendPath:circlePath];
    [path setUsesEvenOddFillRule:YES];
    
    _fillLayer.path = path.CGPath;
    _fillLayer.fillRule = kCAFillRuleEvenOdd;//中间镂空 填充规则 空心遮罩
    _fillLayer.fillColor = [UIColor blackColor].CGColor;
    _fillLayer.opacity = 0.75;
    [self.view bringSubviewToFront:_cutView];
}

#pragma mark - 裁切图片
- (UIImage*)screenView:(UIView *)view{
    CGRect rect = CGRectMake(0, 0, kWidth, kHeight);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGRect newRect = CGRectMake(_cutView.frame.origin.x + 2 + 8, _cutView.frame.origin.y + 2 + 8, _cutView.frame.size.width - 4 - 16, _cutView.frame.size.height - 4 - 16);
    return [UIImage imageWithCGImage:CGImageCreateWithImageInRect(img.CGImage, newRect)];
}

#pragma mark - 截取框移动
// 触碰时的坐标,来判断是否是4个角
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self.view];
    _moveCorner = [self judgeIsFourCornerTouch:touchPoint];
}

// 移动
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self.view];
    CGFloat origenX = _cutView.frame.origin.x;
    CGFloat origenY = _cutView.frame.origin.y;
    CGFloat origenW = _cutView.frame.size.width;
    CGFloat origentH = _cutView.frame.size.height;
    
    //以前的point
    CGPoint preP = [touch previousLocationInView:self.view];
    //x轴偏移的量
    CGFloat offsetX = touchPoint.x - preP.x;
    //Y轴偏移的量
    CGFloat offsetY = touchPoint.y - preP.y;
    
    switch (_moveCorner) {
        case 1:
        {
            if (origenX - touchPoint.x > 0 && origenY - touchPoint.y > 0) {
                touchPoint.y = origenY + touchPoint.x - origenX;
            } else if (origenX - touchPoint.x < 0 && origenY - touchPoint.y < 0) {
                touchPoint.y = origenY + touchPoint.x - origenX;
            } else {
                return;
            }
            
            // 做限制判断
            if (touchPoint.x < 0) {
                touchPoint.x = 0;
                return;
            }
            if (touchPoint.y < 64) {
                touchPoint.y = 64;
                return;
            }
            
            if ((origenX - touchPoint.x + origenW) < 100) {
                return;
            }
            
            _cutView.frame = CGRectMake(touchPoint.x, touchPoint.y, origenX - touchPoint.x + origenW , origenY - touchPoint.y + origentH);
            [_cutView sizeFitFourCorner];
            [self changeShadowWithFrame];
        }
            break;
        case 2:
        {
            if (touchPoint.x - (origenX + origenW)> 0 && touchPoint.y - origenY < 0) {
                touchPoint.y = origenY - (touchPoint.x - origenX - origenW);
            } else if (touchPoint.x - (origenX + origenW) < 0 && touchPoint.y - origenY > 0) {
                touchPoint.y = origenY - (touchPoint.x - origenX - origenW);
            } else {
                return;
            }
            
            // 做限制判断
            if (touchPoint.x > kWidth) {
                touchPoint.x = kWidth;
                return;
            }
            if (touchPoint.y < 64) {
                touchPoint.y = 64;
                return;
            }
            
            if ((touchPoint.x - origenX) < 100) {
                return;
            }
            
            _cutView.frame = CGRectMake(origenX, touchPoint.y, touchPoint.x - origenX, origentH - (touchPoint.y - origenY));
            [_cutView sizeFitFourCorner];
            [self changeShadowWithFrame];
        }
            break;
        case 3:
        {
            if (touchPoint.x - origenX > 0 && touchPoint.y - (origenY + origentH) < 0) {
                touchPoint.y = origenY + origentH - (touchPoint.x - origenX);
            } else if (touchPoint.x - origenX < 0 && touchPoint.y - (origenY + origentH) > 0) {
                touchPoint.y = origenY + origentH - (touchPoint.x - origenX);
            } else {
                return;
            }
            
            // 做限制判断
            if (touchPoint.x < 0) {
                touchPoint.x = 0;
                return;
            }
            if (touchPoint.y > kHeight - 64) {
                touchPoint.y = kHeight - 64;
                return;
            }
            
            if (((origenX - touchPoint.x) + origenW) < 100) {
                return;
            }
            
            _cutView.frame = CGRectMake(touchPoint.x, origenY, (origenX - touchPoint.x) + origenW, touchPoint.y - origenY);
            [_cutView sizeFitFourCorner];
            [self changeShadowWithFrame];
        }
            break;
        case 4:
        {
            if (touchPoint.x - origenX > 0 && touchPoint.y - origenY > 0) {
                touchPoint.y = origenY + touchPoint.x - origenX;
            } else if (touchPoint.x - origenX < 0 && touchPoint.y - origenY < 0) {
                touchPoint.y = origenY + touchPoint.x - origenX;
            } else {
                return;
            }
            
            // 做限制判断
            if (touchPoint.x > kWidth) {
                touchPoint.x = kWidth;
                return;
            }
            if (touchPoint.y > kHeight - 64) {
                touchPoint.y = kHeight - 64;
                return;
            }
            
            if ((touchPoint.x - origenX) < 100) {
                return;
            }
            
            _cutView.frame = CGRectMake(origenX, origenY, touchPoint.x - origenX, touchPoint.y - origenY);
            [_cutView sizeFitFourCorner];
            [self changeShadowWithFrame];
        }
            break;
        case 0:
        case 5:
        {
            CGFloat finalX = origenX;
            CGFloat finalY = origenY;
            
            finalX = origenX + offsetX;
            finalY = origenY + offsetY;
            
            if (finalX < 0) {
                finalX = 0;
            }
            if (finalY < 64) {
                finalY = 64;
            }
            if (finalX > kWidth - _cutView.frame.size.width) {
                finalX = kWidth - _cutView.frame.size.width;
            }
            if (finalY > kHeight - 64 - _cutView.frame.size.width) {
                finalY = kHeight - 64 - _cutView.frame.size.width;
            }
            
            _cutView.frame = CGRectMake(finalX, finalY, _cutView.frame.size.width, _cutView.frame.size.height);
            [_cutView sizeFitFourCorner];
            [self changeShadowWithFrame];
        }
            break;
            
        default:
            break;
    }
}

// 结束触碰
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    _moveCorner = 0;
}

// 获得4个角的坐标
- (CGPoint)getFirstCorner
{
    return CGPointMake(_cutView.frame.origin.x, _cutView.frame.origin.y);
}

- (CGPoint)getSecondCorner
{
    return CGPointMake(CGRectGetMaxX(_cutView.frame), CGRectGetMinY(_cutView.frame));
}

- (CGPoint)getThirdCorner
{
    return CGPointMake(CGRectGetMinX(_cutView.frame), CGRectGetMaxY(_cutView.frame));
}

- (CGPoint)getFourthCorner
{
    return CGPointMake(CGRectGetMaxX(_cutView.frame), CGRectGetMaxY(_cutView.frame));
}

// 判断是否位于四个角的触摸
- (int)judgeIsFourCornerTouch:(CGPoint)point
{
    CGFloat x = point.x;
    CGFloat y = point.y;
    
    CGFloat touchZoneLength = 40;// 触控区域长度
    
    if (x > [self getFirstCorner].x - touchZoneLength && x < [self getFirstCorner].x + touchZoneLength && y > [self getFirstCorner].y - touchZoneLength && y < [self getFirstCorner].y + touchZoneLength) {
        return 1;//坐上角
    } else if (x > [self getSecondCorner].x - touchZoneLength && x < [self getSecondCorner].x + touchZoneLength && y > [self getSecondCorner].y - touchZoneLength && y < [self getSecondCorner].y + touchZoneLength) {
        return 2;//右上角
    } else if (x > [self getThirdCorner].x - touchZoneLength && x < [self getThirdCorner].x + touchZoneLength && y > [self getThirdCorner].y - touchZoneLength && y < [self getThirdCorner].y + touchZoneLength) {
        return 3;//左下角
    } else if (x > [self getFourthCorner].x - touchZoneLength && x < [self getFourthCorner].x + touchZoneLength && y > [self getFourthCorner].y - touchZoneLength && y < [self getFourthCorner].y + touchZoneLength) {
        return 4;//右下角
    } else if (x > [self getFirstCorner].x + touchZoneLength && y > [self getFirstCorner].y + touchZoneLength && x < [self getSecondCorner].x - touchZoneLength && y < [self getFourthCorner].y - touchZoneLength) {
        return 5;//区域内
    };
    return 0;//区域外
}

@end
