//
//  LimitTextInput.h
//  TestDemo
//
//  Created by zhongk on 7/28/15.
//  Copyright (c) 2015 vane.greenisland. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LimitTextInput : UIView

@property (nonatomic, strong) id <UITextInput> textInput;

- (id)initWithFrame:(CGRect)frame withLimitCount:(NSInteger)count NS_DESIGNATED_INITIALIZER;

@end
