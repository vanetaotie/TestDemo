//
//  UIControl+JSA.h
//  TestDemo
//
//  Created by vane on 24/08/2018.
//  Copyright © 2018 vane.greenisland. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (JSA)

@property (nonatomic, assign) NSTimeInterval jsa_acceptEventInterval;

@property (nonatomic, assign) BOOL jsa_ignoreEvent;

@end
