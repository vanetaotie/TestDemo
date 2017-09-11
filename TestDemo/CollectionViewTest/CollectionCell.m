//
//  CollectionCell.m
//  CollectionViewManager
//
//  Created by vane on 14-6-25.
//  Copyright (c) 2014年 vane.greenisland. All rights reserved.
//

#define appImageViewFrame CGRectMake(0,0,50,50)
#define appTitleLableFrame CGRectMake(0,50,50,20)
#define deleteAppButtonFrame CGRectMake(-5,-5,25,25)

#import "CollectionCell.h"

@interface CollectionCell ()

@property (nonatomic, strong) UIButton *checkButton;

@end

@implementation CollectionCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
        [self initGesture];
    }
    return self;
}

- (void)initUI
{
    _appImageView = [[UIImageView alloc] initWithFrame:appImageViewFrame];
    _appTitleLabel = [[UILabel alloc] initWithFrame:appTitleLableFrame];
    [_appTitleLabel setFont:[UIFont systemFontOfSize:12]];
    [_appTitleLabel setTextColor:[UIColor blackColor]];
    [_appTitleLabel setTextAlignment:NSTextAlignmentCenter];
    _deleteAppButton = [[UIButton alloc] initWithFrame:deleteAppButtonFrame];
    [_deleteAppButton setImage:[UIImage imageNamed:@"list_remove"] forState:UIControlStateNormal];
    [_deleteAppButton setHidden:YES];
    [_deleteAppButton addTarget:self action:@selector(deleteAppCell:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_appImageView];
    [self addSubview:_appTitleLabel];
    [self addSubview:_deleteAppButton];
}

- (UIButton *)checkButton
{
    if (!_checkButton) {
        _checkButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _checkButton.frame = CGRectMake(40,-5,25,25);
        _checkButton.hidden = YES;
//        [_checkButton setBackgroundImage:[UIImage imageNamed:@"icon_checked_no"] forState:UIControlStateNormal];
//        [_checkButton setBackgroundImage:[UIImage imageNamed:@"icon_checked_yes"] forState:UIControlStateSelected];

        [_checkButton setImage:[UIImage imageNamed:@"icon_checked_no"] forState:UIControlStateNormal];
        [_checkButton setImage:[UIImage imageNamed:@"icon_checked_no"] forState: UIControlStateHighlighted];
        [_checkButton setImage:[UIImage imageNamed:@"icon_checked_yes"] forState:UIControlStateSelected];
        [_checkButton setImage:[UIImage imageNamed:@"icon_checked_yes"] forState:UIControlStateSelected | UIControlStateHighlighted];

        [_checkButton addTarget:self action:@selector(handleSelect:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_checkButton];
    }
    return _checkButton;
}

- (void)handleSelect:(UIButton *)button
{
    button.selected = !button.selected;
    self.selectBlock(self, button.selected);
}

- (void)initGesture
{
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressCell:)];
    [longPressGesture setMinimumPressDuration:0.4f];
    [self addGestureRecognizer:longPressGesture];
}

//- (void)setCellData:(NSDictionary *)cellData
//{
//    UIImage *appImage = (UIImage *)cellData[@"appImage"];
//    NSString *appTitle = (NSString *)cellData[@"appTitle"];
//    
//    [_appImageView setImage:appImage];
//    [_appTitleLabel setText:appTitle];
//    _canDelete = [(NSNumber *)cellData[@"canDelete"] boolValue];
//}

- (void)setCellData:(NSDictionary *)cellData withMode:(BOOL)isEditing
{
    UIImage *appImage = (UIImage *)cellData[@"appImage"];
    NSString *appTitle = (NSString *)cellData[@"appTitle"];
    
    [_appImageView setImage:appImage];
    [_appTitleLabel setText:appTitle];
    _canDelete = [(NSNumber *)cellData[@"canDelete"] boolValue];
    
    if (isEditing && _canDelete) {
        [_deleteAppButton setHidden:NO];
    } else {
        [_deleteAppButton setHidden:YES];
    }
}

//- (void)setIsDeleteButtonVisible:(BOOL)isDeleteButtonVisible
//{
//    if (_canDelete) {
//        [_deleteAppButton setHidden:!isDeleteButtonVisible];
//    }
//}

- (void)longPressCell:(UILongPressGestureRecognizer *)sender
{
    [_delegate longPress:self];
}

- (void)deleteAppCell:(UIButton *)sender
{
    [_delegate deleteApp:self];
}

//- (void)setIndexPathID:(NSUInteger)index
//{
//    [_deleteAppButton setTag:index];
//}

@end
