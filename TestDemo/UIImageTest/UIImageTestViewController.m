//
//  UIImageTestViewController.m
//  TestDemo
//
//  Created by yoho on 2017/8/21.
//  Copyright © 2017年 vane.greenisland. All rights reserved.
//

#import "UIImageTestViewController.h"

@interface UIImageTestViewController ()

@end

@implementation UIImageTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *originView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 120, 120)];
    [self.view addSubview:originView];
}

//图片裁切
- (UIImage *)clipImagewithImage:(UIImage *)originImage
{
    //注意坐标系问题
    CGImageRef cg = originImage.CGImage;
    size_t width = CGImageGetWidth(cg);
    size_t height = CGImageGetHeight(cg);
    size_t length = 960.0f/1920.0f*width;
    CGRect rect = CGRectMake(265.0f/1920.0f*width, 60.0f/1080.0f*height, length, length);
    //按照给定的矩形区域进行剪裁
    CGImageRef newCG = CGImageCreateWithImageInRect(cg, rect);
    //将CGImageRef转换成UIImage
    UIImage *image = [UIImage imageWithCGImage:newCG];
    
    return image;
}

//图片裁切
- (UIImage *)getSubImage:(UIImage *)originImage {
    CGFloat kDeviceScale = [UIScreen mainScreen].scale;
    
    CGRect squareFrame = CGRectMake(122, 27.5, 320, 320);
    CGFloat x = squareFrame.origin.x;
    CGFloat y = squareFrame.origin.y;
    CGFloat w = squareFrame.size.width;
    CGFloat h = squareFrame.size.width;
    
    //乘以图片的分辨率，保证截到一张完整的图（分辨率：kDeviceScale）
    CGRect myImageRect = CGRectMake(x*kDeviceScale,y*kDeviceScale, w*kDeviceScale, h*kDeviceScale);
    CGImageRef imageRef = originImage.CGImage;
    CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, myImageRect);
    CGSize size;
    size.width = myImageRect.size.width;
    size.height = myImageRect.size.height;
    //UIGraphicsBeginImageContext(size);
    //设置图片的分辨率，保证图片的清晰度(kDeviceScale)
    UIGraphicsBeginImageContextWithOptions(size,NO,kDeviceScale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, myImageRect, subImageRef);
    UIImage *smallImage = [UIImage imageWithCGImage:subImageRef];
    CGImageRelease(subImageRef);
    UIGraphicsEndImageContext();
    return smallImage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
