//
//  DLAlertView.h
//  TestDemo
//
//  Created by zhongk on 5/18/15.
//  Copyright (c) 2015 vane.greenisland. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DLAlertView;

typedef NS_ENUM(NSUInteger, DLAlertViewType) {
    kDLAlertViewTypeText,
    kDLAlertViewTypeImage,
    kDLAlertViewTypeVideo,
    kDLAlertViewTypeLink,
};

/**
 *  @author vane
 *
 *  call-back block
 *
 *  @param isConfirm YES =“confirm” | NO = “cancel”
 *  @param view      DLAlertView
 */
typedef void(^DLAlertViewCompletionHandler) (BOOL isConfirm, DLAlertView *view);

@interface DLAlertView : UIView

/**
 *  @author vane
 *
 *  Designated Initializer | Notice forbidding using 'init:'
 *
 *  @param block   call-back block
 *  @param type    type of alertView : DLAlertViewType
 *  @param title   the title of alertView
 *  @param image   image of alertView
 *  @param content content of alertView
 *
 *  @return
 */
- (id)initWithBlock:(DLAlertViewCompletionHandler)complition
            andType:(DLAlertViewType)type
              title:(NSString *)title
              image:(UIImage *)image
            content:(NSString *)content NS_DESIGNATED_INITIALIZER;

/**
 *  @author vane
 *
 *  show Alert
 */
- (void)show;

@end
