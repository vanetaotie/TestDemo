//
//  GraphicsTestView.m
//  TestDemo
//
//  Created by zhongk on 6/2/15.
//  Copyright (c) 2015 vane.greenisland. All rights reserved.
//

#import "GraphicsTestView.h"

@implementation GraphicsTestView

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetRGBFillColor(context, 1, 0, 0, 1.0);
    
    [self drawStar:context];
}

//绘制五角星
- (void)drawStar:(CGContextRef)context
{
    //确定中心点
    CGPoint centerPoint = CGPointMake(160, 230);
    //确定半径
    CGFloat radius = 100.0;
    //五角星到顶点
    CGPoint p1 = CGPointMake(centerPoint.x, centerPoint.y - radius);
    CGContextMoveToPoint(context, p1.x, p1.y);
    //五角星每个点之间点夹角，采用弧度计算。没两个点进行连线就可以画出五角星
    //点与点之间点夹角为2*M_PI/5.0，
    CGFloat angle = 4*M_PI/5.0;
    for (int i=1; i<=5; i++) {
        CGFloat x = centerPoint.x - sinf(i*angle)*radius;
        CGFloat y = centerPoint.y - cosf(i*angle)*radius;
        CGContextAddLineToPoint(context, x, y);
    }
    CGContextEOFillPath(context);
//    CGContextDrawPath(context, kCGPathFillStroke);
}

@end
