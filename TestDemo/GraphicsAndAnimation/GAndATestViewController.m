//
//  GAndATestViewController.m
//  TestDemo
//
//  Created by zhongk on 6/2/15.
//  Copyright (c) 2015 vane.greenisland. All rights reserved.
//

#import "GAndATestViewController.h"
#import "GraphicsTestView.h"
#import "AnimationTestView.h"

@implementation GAndATestViewController

- (void)viewDidLoad
{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self addGraphicsView];
}

- (void)addGraphicsView
{
    GraphicsTestView *gview = [[GraphicsTestView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:gview];
}

- (void)addAnimationView
{
    
}

@end
