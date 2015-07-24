//
//  PlayerView.h
//  TestDemo
//
//  Created by vane on 15/2/27.
//  Copyright (c) 2015年 vane.greenisland. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@class PlayerView;
@protocol PlayerViewDelegate <NSObject>

- (void)didTapPlayView:(PlayerView *)playerView;

@end

@interface PlayerView : UIView

@property (nonatomic, strong) UIButton *playBtn;
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, weak) id <PlayerViewDelegate> delegate;

- (void)togglePlayStatus:(id)sender;
- (void)play;
- (void)pause;

@end
