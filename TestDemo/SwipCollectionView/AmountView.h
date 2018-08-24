//
//  AmountView.h
//  TestDemo
//
//  Created by vane on 20/06/2018.
//  Copyright © 2018 vane.greenisland. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^AmountBlock)(NSInteger amount);

@interface AmountView : UIView

@property (assign, nonatomic) NSInteger amount;

@property (copy, nonatomic) AmountBlock amountBlock;

@end
