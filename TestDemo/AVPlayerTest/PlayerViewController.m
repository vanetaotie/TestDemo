//
//  PlayerViewController.m
//  TestDemo
//
//  Created by vane on 15/2/28.
//  Copyright (c) 2015年 vane.greenisland. All rights reserved.
//

#import "PlayerViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface PlayerViewController ()

@end

@implementation PlayerViewController
{
    UIView *_backgroundView;
    CGFloat _totalTime;
    AVPlayer *_player;
    AVPlayerItem *_playerItem;
    PlayerView *_playerView;
    id _playbackTimeObserver;
}

- (id)init
{
    return [self initWithUrl:nil];
}

//Designated Initializer
- (id)initWithUrl:(NSURL *)url
{
    if ([super init]) {
        [self.view setBackgroundColor:[UIColor clearColor]];

        _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 0)];
        [_backgroundView setBackgroundColor:[UIColor blackColor]];
        [self.view addSubview:_backgroundView];
        
        _playerView = [[PlayerView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        _playerView.delegate = self;
        _playerItem = [AVPlayerItem playerItemWithURL:url];
        
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, [[UIScreen mainScreen] bounds].size.height - 45, 50, 15)];
        self.timeLabel.backgroundColor = [UIColor clearColor];
        self.timeLabel.font = [UIFont systemFontOfSize:14];
        self.timeLabel.textColor = [UIColor whiteColor];
        
        [_backgroundView addSubview:_playerView];
        [_backgroundView addSubview:self.timeLabel];
        
        [_playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];// 监听status属性
        [_playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];// 监听loadedTimeRanges属性
        _player = [AVPlayer playerWithPlayerItem:_playerItem];
        _playerView.player = _player;
        
        [UIView animateWithDuration:0.2 animations:^{
            [_backgroundView setFrame:[[UIScreen mainScreen] bounds]];
        } completion:^(BOOL finished) {
            [[self navigationController] setNavigationBarHidden:YES animated:NO];
        }];
    }
    return self;
}

- (void)showInViewController:(UIViewController *)vc
{
    [vc addChildViewController:self];
    [vc.view addSubview:self.view];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // 添加视频播放结束通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(moviePlayDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:_playerItem];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [_playerView play];
}

#pragma mark - KVO Method
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    AVPlayerItem *avPlayerItem = (AVPlayerItem *)object;
    if ([keyPath isEqualToString:@"status"]) {
        if ([avPlayerItem status] == AVPlayerStatusReadyToPlay) {
            NSLog(@"AVPlayerStatusReadyToPlay");

            CMTime duration = _playerItem.duration;// 获取视频总长度
            _totalTime = avPlayerItem.duration.value / avPlayerItem.duration.timescale;// 转换成秒
            NSLog(@"movie total duration:%f",CMTimeGetSeconds(duration));
            [self monitoringPlayback:_playerItem];// 监听播放状态
        } else if ([avPlayerItem status] == AVPlayerStatusFailed) {
            NSLog(@"AVPlayerStatusFailed");
        }
    } else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        NSTimeInterval timeInterval = [self availableDuration];// 计算缓冲进度
        NSLog(@"Time Interval:%f",timeInterval);
        CMTime duration = _playerItem.duration;
        CGFloat totalDuration = CMTimeGetSeconds(duration);
        NSLog(@"totalDuration:%f",totalDuration);
    }
}

- (void)monitoringPlayback:(AVPlayerItem *)avplayerItem {
    __block __weak PlayerViewController *weakSelf = self;
    __block CGFloat totalSecond = _totalTime;
    _playbackTimeObserver = [_playerView.player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:NULL usingBlock:^(CMTime time) {
        CGFloat currentSecond = avplayerItem.currentTime.value/avplayerItem.currentTime.timescale;// 计算当前在第几秒
        CGFloat remainSecond = totalSecond - currentSecond;
        NSString *timeString = [weakSelf convertTime:remainSecond];
        [weakSelf.timeLabel setText:timeString];
    }];
}

#pragma mark - Other Method
- (NSString *)convertTime:(CGFloat)second{
    NSDate *d = [NSDate dateWithTimeIntervalSince1970:second];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    if (second/3600 >= 1) {
        [formatter setDateFormat:@"HH:mm:ss"];
    } else {
        [formatter setDateFormat:@"mm:ss"];
    }
    NSString *showtimeNew = [formatter stringFromDate:d];
    return showtimeNew;
}

- (NSTimeInterval)availableDuration {
    NSArray *loadedTimeRanges = [[_playerView.player currentItem] loadedTimeRanges];
    CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];// 获取缓冲区域
    float startSeconds = CMTimeGetSeconds(timeRange.start);
    float durationSeconds = CMTimeGetSeconds(timeRange.duration);
    NSTimeInterval result = startSeconds + durationSeconds;// 计算缓冲总进度
    return result;
}

- (void)moviePlayDidEnd:(NSNotification *)notification {
    NSLog(@"Play end");
    [_playerView.player seekToTime:kCMTimeZero completionHandler:^(BOOL finished) {
        [_playerView togglePlayStatus:nil];
    }];
}

#pragma mark - PlayerViewDelegate
- (void)didTapPlayView:(PlayerView *)playerView
{
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
    
    [UIView animateWithDuration:0.2 animations:^{
        [_backgroundView setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 0)];
        _backgroundView.alpha = 0;
    }completion:^(BOOL finished){
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
    }];
}

- (void)dealloc {
    [_playerItem removeObserver:self forKeyPath:@"status" context:nil];
    [_playerItem removeObserver:self forKeyPath:@"loadedTimeRanges" context:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:_playerItem];
    [_playerView.player removeTimeObserver:_playbackTimeObserver];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
