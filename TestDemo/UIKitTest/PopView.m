//
//  PopView.m
//  test
//
//  Created by daixu on 14-8-4.
//  Copyright (c) 2014年 daixu. All rights reserved.
//

#import "PopView.h"

@implementation PopView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initTableView];
        [self initgesture];
    }
    return self;
}

-(void)initTableView
{
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(80, 150, 160, 200)];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    [myTableView setBackgroundColor:[UIColor grayColor]];
    [self addSubview:myTableView];
}

- (void)initgesture
{
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBackgroundView:)];
    gesture.delegate = self;
    [self addGestureRecognizer:gesture];
}

- (void)tapBackgroundView:(UIGestureRecognizer*)ges
{
    [self removeFromSuperview];
}

//*************************//
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    CGPoint touchPoint = [gestureRecognizer locationInView:self];//辨识触摸位置
    if (CGRectContainsPoint(myTableView.frame, touchPoint)) {
        //如果触摸位置在指定范围，则不响应tapBackgroundView手势
        return NO;
    }
    return YES;
}
//*************************//

#pragma mark delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *index = @"xxx";
    UITableViewCell *cell = [myTableView dequeueReusableCellWithIdentifier:index];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:index];
    }
    cell.backgroundColor = [UIColor greenColor];
    [cell.textLabel setText:[NSString stringWithFormat:@"cell%ld",(long)indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ttt" message:@"ttt" delegate:self cancelButtonTitle:@"yes" otherButtonTitles:nil, nil];
    [alert show];
}

@end
