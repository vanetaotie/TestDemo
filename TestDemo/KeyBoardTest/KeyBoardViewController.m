//
//  KeyBoardViewController.m
//  TestDemo
//
//  Created by vane on 15-3-17.
//  Copyright (c) 2015年 vane.greenisland. All rights reserved.
//

#import "KeyBoardViewController.h"

@interface KeyBoardViewController ()

@end

@implementation KeyBoardViewController
{
    UITextField *_textField;
    UITextView *_textView;
    
    RandomKeyBoardView *_keyboard1;
    
    RandomKeyBoardView *_keyboard2;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [[self navigationController] setTitle:@"KeyBoardVC"];
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    [[self navigationItem] setLeftBarButtonItem:cancelItem];
    
    _keyboard1 = [[RandomKeyBoardView alloc] init];
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(50, 100, 220, 30)];
    [_textField setPlaceholder:@"请输入..."];
    [_textField setBorderStyle:UITextBorderStyleRoundedRect];
    [_textField setFont:[UIFont systemFontOfSize:15]];
    [_textField setDelegate:self];
    [self.view addSubview:_textField];
    
    [_keyboard1 setTextInput:_textField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(randomTextFieldChanged:) name:UITextFieldTextDidChangeNotification object:_textField];
    
    //-------------------------------------
    
    _keyboard2 = [[RandomKeyBoardView alloc] init];
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(50, 200, 220, 80)];
    [_textView setBackgroundColor:[UIColor grayColor]];
    [_textView setFont:[UIFont systemFontOfSize:15]];
    [_textView setDelegate:self];
    [self.view addSubview:_textView];
    
    [_keyboard2 setTextInput:_textView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(randomTextViewChanged:) name:UITextViewTextDidChangeNotification object:_textView];
}

- (void)back
{
    [[self navigationController] dismissViewControllerAnimated:YES completion:nil];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_textField resignFirstResponder];
    [_textView resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Notify
- (void)randomTextFieldChanged:(NSNotification *)notify
{
    UITextField *textField = [notify object];
    if ([textField isEqual:_textField]) {
        NSLog(@"notify:%@",textField.text);
    }
}

- (void)randomTextViewChanged:(NSNotification *)notify
{
    UITextView *textView = [notify object];
    if ([textView isEqual:_textView]) {
        NSLog(@"notify:%@",textView.text);
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField isEqual:_textField]) {
        [textField resignFirstResponder];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([textField isEqual:_textField]) {
        [_keyboard1 resetKeyBoardCharacter];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([textField isEqual:_textField]) {
        NSString * str = [textField.text stringByReplacingCharactersInRange:range withString:string];
        NSLog(@"delegate:%@",str);
    }
    return YES;
}

#pragma mark - UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView isEqual:_textView]) {
        [_keyboard2 resetKeyBoardCharacter];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([textView isEqual:_textView]) {
        NSString * str = [textView.text stringByReplacingCharactersInRange:range withString:text];
        NSLog(@"delegate:%@",str);
    }
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
