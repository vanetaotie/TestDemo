//
//  PlayerViewController.h
//  TestDemo
//
//  Created by vane on 15/2/28.
//  Copyright (c) 2015年 vane.greenisland. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayerView.h"

@interface PlayerViewController : UIViewController <PlayerViewDelegate>

@property (nonatomic, strong) UILabel *timeLabel;

- (id)initWithUrl:(NSURL *)url;

- (void)showInViewController:(UIViewController *)vc;

@end
