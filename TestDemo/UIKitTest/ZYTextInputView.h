//
//  ZYTextInputView.h
//  TestDemo
//
//  Created by vane on 2019/2/18.
//  Copyright © 2019 vane.greenisland. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^ZYCommentContentBlock)(NSString *text);

@interface ZYTextInputView : UIView

@property (nonatomic, strong) NSString *placeholder;
@property (nonatomic, copy) ZYCommentContentBlock contentBlock;

- (void)hideTextInputView;

@end

NS_ASSUME_NONNULL_END
