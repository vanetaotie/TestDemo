//
//  CutImageViewController.h
//  TestDemo
//
//  Created by vane on 29/09/2017.
//  Copyright © 2017 vane.greenisland. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CutImageSuccessBlock)(UIImage *cutImage);

@interface CutImageViewController : UIViewController

@property (nonatomic, strong) CutImageSuccessBlock cutSuccessBlock;

- (instancetype)initWithOriginImage:(UIImage *)originImage;

@end
