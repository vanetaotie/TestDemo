//
//  PlayerView.m
//  TestDemo
//
//  Created by vane on 15/2/27.
//  Copyright (c) 2015年 vane.greenisland. All rights reserved.
//

#import "PlayerView.h"

@implementation PlayerView
{
    BOOL _isPlaying;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        
        self.playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.playBtn.frame = CGRectMake(self.frame.size.width/2 - 36, self.frame.size.height - 68, 75, 60);
        NSString *imagePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"playerviewlib.bundle/images/play.png"];
        [self.playBtn setBackgroundImage:[UIImage imageWithContentsOfFile:imagePath] forState:UIControlStateNormal];
        [self.playBtn addTarget:self action:@selector(togglePlayStatus:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.playBtn];
    }
    return self;
}

+ (Class)layerClass {
    return [AVPlayerLayer class];
}

- (AVPlayer *)player {
    return [(AVPlayerLayer *)[self layer] player];
}

- (void)setPlayer:(AVPlayer *)player {
    [(AVPlayerLayer *)[self layer] setPlayer:player];
}

- (void)togglePlayStatus:(id)sender
{
    if (!_isPlaying) {
        [self play];
    } else {
        [self pause];
    }
}

- (void)play
{
    [self.player play];
    
    NSString *imagePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"playerviewlib.bundle/images/pause.png"];
    [self.playBtn setBackgroundImage:[UIImage imageWithContentsOfFile:imagePath] forState:UIControlStateNormal];
    _isPlaying = YES;
}

- (void)pause
{
    [self.player pause];
    
    NSString *imagePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"playerviewlib.bundle/images/play.png"];
    [self.playBtn setBackgroundImage:[UIImage imageWithContentsOfFile:imagePath] forState:UIControlStateNormal];
    _isPlaying = NO;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if (touch.tapCount == 1) {
        if ([self.delegate respondsToSelector:@selector(didTapPlayView:)]) {
            [self.delegate didTapPlayView:self];
        }
    }
}

@end
