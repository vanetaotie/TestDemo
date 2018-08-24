//
//  SwipCollectionViewCell.h
//  TestDemo
//
//  Created by vane on 15/06/2018.
//  Copyright © 2018 vane.greenisland. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLCSwipeCollectionViewCell.h"

@interface SwipCollectionViewCell : ZLCSwipeCollectionViewCell

- (void)setCellData:(NSArray *)array indexPath:(NSIndexPath *)indexPath;

@end
