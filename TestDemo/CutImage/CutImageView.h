//
//  CutImageView.h
//  TestDemo
//
//  Created by vane on 29/09/2017.
//  Copyright © 2017 vane.greenisland. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CutImageView : UIView

@property (nonatomic, strong) UIImageView *leftTopImage;
@property (nonatomic, strong) UIImageView *rightTopImage;
@property (nonatomic, strong) UIImageView *leftBottomImage;
@property (nonatomic, strong) UIImageView *rightBottomImage;
@property (nonatomic, strong) UIView *emptyView;

- (void)sizeFitFourCorner;

@end
