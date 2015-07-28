//
//  LimitTextInput.m
//  TestDemo
//
//  Created by zhongk on 7/28/15.
//  Copyright (c) 2015 vane.greenisland. All rights reserved.
//

#import "LimitTextInput.h"

@implementation LimitTextInput
{
    UILabel *_tipLabel;
    NSInteger _limitCount;
}

@synthesize textInput = _textInput;

#pragma mark - life cycle
- (id)initWithFrame:(CGRect)frame withLimitCount:(NSInteger)count
{
    self = [super initWithFrame:frame];
    if (self) {
        _limitCount = count;
        [self initUIWithFrame:frame];
    }
    return self;
}

- (void)initUIWithFrame:(CGRect)frame
{
    [self setBounds:frame];
    [self setBackgroundColor:[UIColor greenColor]];
    
    _tipLabel = [[UILabel alloc] initWithFrame:frame];
    _tipLabel.text = [NSString stringWithFormat:@"0/%lu",(long)_limitCount];
    _tipLabel.textAlignment = NSTextAlignmentCenter;
    
    [_tipLabel sizeToFit];
    [self addSubview:_tipLabel];
    
    if (_limitCount <= 0) {
        [_tipLabel setHidden:YES];
    }
}

#pragma mark - notify
-(void)textFieldViewDidChange:(NSNotification*)notification
{
    UITextField *textField = [notification object];
    NSString *string = textField.text;
    NSLog(@"TextField---------%@",string);
    [self setCurrentInputCount:[string length]];
}

-(void)textViewDidChange:(NSNotification *)notificaiton
{
    UITextView *textView = [notificaiton object];
    NSString *string = textView.text;
    NSLog(@"TextView---------%@",string);
    [self setCurrentInputCount:[string length]];
}

#pragma mark - getters and setters
- (void)setTextInput:(id<UITextInput>)textInput
{
    if ([textInput isKindOfClass:[UITextField class]]) {
        [(UITextField *)textInput setInputView:self];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldViewDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
    } else if ([textInput isKindOfClass:[UITextView class]]){
        [(UITextView *)textInput setInputView:self];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidChange:) name:UITextViewTextDidChangeNotification object:nil];
    }
    _textInput = textInput;
}

- (id<UITextInput>)textInput
{
    return _textInput;
}

#pragma mark - private method
- (void)setCurrentInputCount:(NSUInteger)count
{
    _tipLabel.text = [NSString stringWithFormat:@"%lu/%lu",(unsigned long)count,(long)_limitCount];
    
    [_tipLabel sizeToFit];
}

@end
