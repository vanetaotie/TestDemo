//
//  ZYPasswordView.m
//  TestDemo
//
//  Created by vane on 2019/10/9.
//  Copyright © 2019 vane.greenisland. All rights reserved.
//

#import "ZYPasswordView.h"

#define kDotCount 6  //密码位数

@interface ZYPasswordView ()

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) NSMutableArray *dotArray;

@end

@implementation ZYPasswordView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self.textField becomeFirstResponder];
        [self initPwdTextField];
    }
    return self;
}

- (void)initPwdTextField
{
    CGFloat width = self.frame.size.width / kDotCount;
    
    //生成分割线
    for (int i = 0; i < kDotCount - 1; i++) {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.textField.frame) + (i + 1) * width, 0, 1, self.frame.size.height)];
        lineView.backgroundColor = [UIColor grayColor];
        [self addSubview:lineView];
    }
    
    self.dotArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < kDotCount; i++) {
        UILabel *dotView = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.textField.frame) + i * width, 0, width, self.frame.size.height)];
        dotView.text = @"*";
        dotView.textAlignment = NSTextAlignmentCenter;
        dotView.font = [UIFont systemFontOfSize:20.0];
        dotView.hidden = YES;
        [self addSubview:dotView];
        [self.dotArray addObject:dotView];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
        return NO;
    } else if(string.length == 0) {
        //判断是不是删除键
        return YES;
    }
    else if(textField.text.length >= kDotCount) {
        NSLog(@"输入的字符个数大于6，忽略输入");
        return NO;
    } else {
        return YES;
    }
}

- (void)clearUpPassword
{
    self.textField.text = @"";
    [self textFieldDidChange:self.textField];
}

- (void)textFieldDidChange:(UITextField *)textField
{
    NSLog(@"%@", textField.text);
    for (UIView *dotView in self.dotArray) {
        dotView.hidden = YES;
    }
    for (int i = 0; i < textField.text.length; i++) {
        ((UIView *)[self.dotArray objectAtIndex:i]).hidden = NO;
    }
    if (textField.text.length == kDotCount) {
        NSLog(@"输入完毕");
    }
}

- (UITextField *)textField
{
    if (!_textField) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _textField.backgroundColor = [UIColor whiteColor];
        //输入的文字颜色为白色
        _textField.textColor = [UIColor whiteColor];
        //输入框光标的颜色为白色
        _textField.tintColor = [UIColor whiteColor];
        _textField.delegate = self;
        _textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _textField.keyboardType = UIKeyboardTypeNumberPad;
        _textField.layer.borderColor = [[UIColor grayColor] CGColor];
        _textField.layer.borderWidth = 1;
        [_textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [self addSubview:_textField];
    }
    return _textField;
}

@end
