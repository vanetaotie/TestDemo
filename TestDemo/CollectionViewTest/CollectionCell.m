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
