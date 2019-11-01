//
//  ZYTextInputView.m
//  TestDemo
//
//  Created by vane on 2019/2/18.
//  Copyright © 2019 vane.greenisland. All rights reserved.
//

#import "ZYTextInputView.h"

@interface ZYTextInputView () <UITextViewDelegate>

@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UITextView *textView;//输入框
@property (nonatomic, assign) CGRect rect;
@property (nonatomic, strong) UILabel *placeHolderLabel;

@end

@implementation ZYTextInputView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, CGRectGetHeight([UIScreen mainScreen].bounds)-50, CGRectGetWidth([UIScreen mainScreen].bounds), 50);
        _rect = self.frame;
        [self initNotification];
        [self AddtextFieldComments];
    }
    return self;
}

#pragma mark - 初始化键盘监听

- (void)initNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - 初始化视图

- (void)AddtextFieldComments  {
    
    [self addSubview:self.bottomView];
    [self.bottomView addSubview:self.backgroundView];
    [self.backgroundView addSubview:self.textView];
    [self.backgroundView addSubview:self.placeHolderLabel];
    
    [self setupPlaceHolder];
}

- (void)setupPlaceHolder {

    if (self.placeholder.length == 0) {
        self.placeholder = @"参与评论";
    }
    
    self.placeHolderLabel.text = self.placeholder;
    
    if (self.textView.text.length == 0) {
        self.placeHolderLabel.hidden = NO;
    } else {
        self.placeHolderLabel.hidden = YES;
    }
}

#pragma mark - 事件监听

- (void)hideTextInputView {
    
    [self.textView resignFirstResponder];
}

- (void)textViewDidChange:(UITextView *)textView {

    NSLog(@"%@",textView.text);
    
    [self setupPlaceHolder];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        NSLog(@"发送");
        
        [self setupPlaceHolder];
        self.contentBlock(textView.text);
        
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

#pragma mark - 键盘监听

- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    self.frame = CGRectMake(0, CGRectGetHeight([UIScreen mainScreen].bounds) - keyboardRect.size.height - 50, CGRectGetWidth(_bottomView.frame), CGRectGetHeight(_bottomView.frame));
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    self.frame = _rect;
}

#pragma mark - Getter & Setter

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:self.bounds];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), 0.5)];
        lineView.backgroundColor = [UIColor colorWithWhite:0.6 alpha:0.3];
        [_bottomView addSubview:lineView];
    }
    return _bottomView;
}

- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(15, 7, CGRectGetWidth(self.bounds) - 30, 36)];
        _backgroundView.layer.cornerRadius = 6;
        _backgroundView.layer.borderWidth = 1;
        _backgroundView.layer.borderColor = [UIColor colorWithWhite:0.6 alpha:0.3].CGColor;
    }
    return _backgroundView;
}

- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(8, 5, CGRectGetWidth(self.backgroundView.bounds) - 16, 26)];
        _textView.delegate = self;
        _textView.font = [UIFont systemFontOfSize:12];
        _textView.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _textView.autocorrectionType = UITextAutocorrectionTypeNo;
        _textView.returnKeyType = UIReturnKeySend;
    }
    return _textView;
}

- (UILabel *)placeHolderLabel {
    if (!_placeHolderLabel) {
        _placeHolderLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, CGRectGetWidth(self.backgroundView.bounds) - 20, 17)];
        _placeHolderLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _placeHolderLabel.numberOfLines = 0;
        _placeHolderLabel.font = [UIFont systemFontOfSize:12];
        _placeHolderLabel.backgroundColor = [UIColor clearColor];
        _placeHolderLabel.textColor = [UIColor colorWithWhite:0.6 alpha:0.3];
    }
    return _placeHolderLabel;
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    
    [self setupPlaceHolder];
}

@end
