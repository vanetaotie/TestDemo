//
//  CutImageView.m
//  TestDemo
//
//  Created by vane on 29/09/2017.
//  Copyright © 2017 vane.greenisland. All rights reserved.
//

#import "CutImageView.h"

@implementation CutImageView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self config];
    }
    return self;
}

- (void)config {
    self.backgroundColor = [UIColor clearColor];
    
    _emptyView = [[UIView alloc] initWithFrame:CGRectMake(8, 8, self.frame.size.width - 16, self.frame.size.height - 16)];
    _emptyView.backgroundColor = [UIColor clearColor];
    _emptyView.layer.borderColor = [UIColor whiteColor].CGColor;
    _emptyView.layer.borderWidth = 1;
    [self addSubview:_emptyView];
    
    // 4个角
    _leftTopImage = [[UIImageView alloc] initWithFrame:CGRectMake(-1.5 + 8, -1.5 + 8, 15, 15)];
    _leftTopImage.image = [self getCutImageResourceWithImageName:@"cutLeftTop"];
    [self addSubview:_leftTopImage];
    
    _rightTopImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - 13.5 - 8, -1.5 + 8, 15, 15)];
    _rightTopImage.image = [self getCutImageResourceWithImageName:@"cutRightTop"];
    [self addSubview:_rightTopImage];
    
    _leftBottomImage = [[UIImageView alloc] initWithFrame:CGRectMake(-1.5 + 8, self.frame.size.height - 13.5 - 8, 15, 15)];
    _leftBottomImage.image = [self getCutImageResourceWithImageName:@"cutLeftBottom"];
    [self addSubview:_leftBottomImage];
    
    _rightBottomImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - 13.5 - 8, self.frame.size.height - 13.5 - 8, 15, 15)];
    _rightBottomImage.image = [self getCutImageResourceWithImageName:@"cutRightBottom"];
    [self addSubview:_rightBottomImage];
}

- (void)sizeFitFourCorner
{
    _leftTopImage.frame = CGRectMake(-1.5 + 8, -1.5 + 8 , 15, 15);
    _rightTopImage.frame = CGRectMake(self.frame.size.width - 13.5 - 8, -1.5 + 8, 15, 15);
    _leftBottomImage.frame = CGRectMake(-1.5 + 8, self.frame.size.height - 13.5 - 8, 15, 15);
    _rightBottomImage.frame = CGRectMake(self.frame.size.width - 13.5 - 8, self.frame.size.height - 13.5 - 8, 15, 15);
    _emptyView.frame = CGRectMake(8, 8, self.frame.size.width - 16, self.frame.size.height - 16);
}

- (UIImage *)getCutImageResourceWithImageName:(NSString *)imageName {
    NSString *realImageName = nil;
    if ([UIScreen mainScreen].scale == 3.0) {
        realImageName = [NSString stringWithFormat:@"%@@3x.png",imageName];
    }else{
        realImageName = [NSString stringWithFormat:@"%@@2x.png",imageName];
    }
    NSString *resourcePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"CutImage.bundle"];
    NSString *imagePath = [resourcePath stringByAppendingPathComponent:realImageName];
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    return image;
}

@end
