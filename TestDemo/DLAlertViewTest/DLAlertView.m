//
//  DLAlertView.m
//  TestDemo
//
//  Created by zhongk on 5/18/15.
//  Copyright (c) 2015 vane.greenisland. All rights reserved.
//

#import "DLAlertView.h"


#define STR_DLALERTVIEW_CONFIRM     @"发送"       //confirm text
#define STR_DLALERTVIEW_CANCEL      @"取消"       //cancel text
#define STR_DLALERTVIEW_IMAGE       @"1张图片"    //image text
#define STR_DLALERTVIEW_VIDEO       @"视频"       //image text

//confirm text color
#define TEXTCOLOR_DLALERTVIEW_CONFIRM  [UIColor colorWithRed:(float)74/255.0f green:(float)192/255.0f blue:(float)86/255.0f alpha:1.0]

static const CGFloat kAlertViewWidth = 270;

@implementation DLAlertView
{
    UIView *_coverView;
    UIView *_alertView;
    UIButton *_confirmBtn;
    UIButton *_cancelBtn;
    
    DLAlertViewCompletionHandler _complitionHandler;
    DLAlertViewType _currentType;
    NSString *_currentTitle;
    UIImage *_currentImage;
    NSString *_currentContent;
}

//Designated Initializer
- (id)initWithBlock:(DLAlertViewCompletionHandler)complition
            andType:(DLAlertViewType)type
              title:(NSString *)title
              image:(UIImage *)image
            content:(NSString *)content
{
    self = [super init];
    if (self) {
        _complitionHandler = complition;
        _currentType = type;
        _currentTitle = title;
        _currentImage = image;
        _currentContent = content;
        
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    [self setFrame:[UIScreen mainScreen].bounds];
    
    _coverView = [[UIView alloc] initWithFrame:self.frame];
    [_coverView setBackgroundColor:[UIColor blackColor]];
    [_coverView setAlpha:0.5];
    [self addSubview:_coverView];
    
    CGFloat kAlertViewHeight = 130;
    
    _alertView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kAlertViewWidth, kAlertViewHeight)];

    switch (_currentType) {
        case kDLAlertViewTypeText:
        {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
            [label setFont:[UIFont systemFontOfSize:13]];
            [label setNumberOfLines:0];
            CGRect rect = [_currentContent boundingRectWithSize:CGSizeMake(kAlertViewWidth-20, 50) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil];
            [label setText:_currentContent];
            [label setFrame:CGRectMake(10, 20, rect.size.width, rect.size.height)];
            [_alertView addSubview:label];
            
            if (rect.size.height < 16) {
                kAlertViewHeight = 100;
                [_alertView setFrame:CGRectMake(0, 0, kAlertViewWidth, kAlertViewHeight)];
            } else if (rect.size.height > 16 && rect.size.height < 32) {
                kAlertViewHeight = 115;
                [_alertView setFrame:CGRectMake(0, 0, kAlertViewWidth, kAlertViewHeight)];
            }
        }
            break;
        case kDLAlertViewTypeImage:
        {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kAlertViewWidth/2-30, 10, 60, 20)];
            [label setFont:[UIFont boldSystemFontOfSize:15]];
            [label setText:STR_DLALERTVIEW_IMAGE];
            [_alertView addSubview:label];
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 40, kAlertViewWidth-40, 120)];
            [imageView setImage:_currentImage];
            [imageView.layer setBorderColor:[[UIColor grayColor] CGColor]];
            [imageView.layer setBorderWidth:0.5];
            [imageView setContentScaleFactor:[[UIScreen mainScreen] scale]];
            [imageView setContentMode:UIViewContentModeScaleAspectFill];
            [imageView setClipsToBounds:YES];
            [_alertView addSubview:imageView];
            
            kAlertViewHeight = 220;
            [_alertView setFrame:CGRectMake(0, 0, kAlertViewWidth, kAlertViewHeight)];
        }
            break;
        case kDLAlertViewTypeVideo:
        {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, kAlertViewWidth-40, 20)];
            [label setFont:[UIFont boldSystemFontOfSize:15]];
            [label setText:_currentTitle];
            [label setText:STR_DLALERTVIEW_VIDEO];
            [_alertView addSubview:label];
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 50, 40, 40)];
            [imageView setImage:_currentImage];
            [_alertView addSubview:imageView];
            
            kAlertViewHeight = 150;
            [_alertView setFrame:CGRectMake(0, 0, kAlertViewWidth, kAlertViewHeight)];
        }
            break;
        case kDLAlertViewTypeLink:
        {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, kAlertViewWidth-40, 20)];
            [label setFont:[UIFont boldSystemFontOfSize:15]];
            [label setText:_currentTitle];
            [_alertView addSubview:label];
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 50, 40, 40)];
            [imageView setImage:_currentImage];
            [_alertView addSubview:imageView];
            
            UILabel *conLabel = [[UILabel alloc] initWithFrame:CGRectZero];
            [conLabel setFont:[UIFont systemFontOfSize:13]];
            [conLabel setNumberOfLines:0];
            CGRect rect = [_currentContent boundingRectWithSize:CGSizeMake(kAlertViewWidth-100, 35) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil];
            [conLabel setText:_currentContent];
            [conLabel setFrame:CGRectMake(85, 50, rect.size.width, rect.size.height)];
            [_alertView addSubview:conLabel];
            
            kAlertViewHeight = 150;
            [_alertView setFrame:CGRectMake(0, 0, kAlertViewWidth, kAlertViewHeight)];
        }
            break;
        default:
            break;
    }
    
    [_alertView setCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2)];
    [_alertView.layer setCornerRadius:5.0];
    [_alertView.layer setMasksToBounds:YES];
    [_alertView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:_alertView];
    
    _confirmBtn = [[UIButton alloc] initWithFrame:CGRectMake(kAlertViewWidth/2, kAlertViewHeight-44, kAlertViewWidth/2, 44)];
    [_confirmBtn setBackgroundColor:[UIColor whiteColor]];
    [_confirmBtn.layer setShadowColor:[[UIColor grayColor] CGColor]];
    [_confirmBtn.layer setShadowRadius:0.5];
    [_confirmBtn.layer setShadowOpacity:1.0];
    [_confirmBtn.layer setShadowOffset:CGSizeZero];
    [_confirmBtn.layer setMasksToBounds:NO];
    [_confirmBtn setTitle:STR_DLALERTVIEW_CONFIRM forState:UIControlStateNormal];
    [_confirmBtn setTitleColor:TEXTCOLOR_DLALERTVIEW_CONFIRM forState:UIControlStateNormal];
    [_confirmBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:_confirmBtn.titleLabel.font.pointSize]];
    [_confirmBtn addTarget:self action:@selector(confirm:) forControlEvents:UIControlEventTouchUpInside];
    [_alertView addSubview:_confirmBtn];
    
    _cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, kAlertViewHeight-44, kAlertViewWidth/2, 44)];
    [_cancelBtn setBackgroundColor:[UIColor whiteColor]];
    [_cancelBtn.layer setShadowColor:[[UIColor grayColor] CGColor]];
    [_cancelBtn.layer setShadowRadius:0.5];
    [_cancelBtn.layer setShadowOpacity:1.0];
    [_cancelBtn.layer setShadowOffset:CGSizeZero];
    [_cancelBtn.layer setMasksToBounds:NO];
    [_cancelBtn setTitle:STR_DLALERTVIEW_CANCEL forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_cancelBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:_cancelBtn.titleLabel.font.pointSize]];
    [_cancelBtn addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    [_alertView addSubview:_cancelBtn];
}

- (void)show
{
    [[UIApplication sharedApplication].keyWindow.subviews[0] addSubview:self];
}

- (void)confirm:(id)sender
{
    if (_complitionHandler) {
        _complitionHandler(YES, self);
    }
    _complitionHandler = nil;
    
    [self removeFromSuperview];
}

- (void)cancel:(id)sender
{
    if (_complitionHandler) {
        _complitionHandler(NO, self);
    }
    _complitionHandler = nil;

    [self removeFromSuperview];
}

@end
