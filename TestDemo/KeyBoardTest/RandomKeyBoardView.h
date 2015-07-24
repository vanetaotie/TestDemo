//
//  RandomKeyBoardView.h
//  TestDemo
//
//  Created by vane on 15-3-17.
//  Copyright (c) 2015年 vane.greenisland. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RandomKeyBoardView : UIView <UIInputViewAudioFeedback>

@property (nonatomic, strong) id <UITextInput> textInput;

//重新随机排序键盘字符
- (void)resetKeyBoardCharacter;

@end
