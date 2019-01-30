//
//  FlowViewCell.h
//  TestDemo
//
//  Created by vane on 2019/1/29.
//  Copyright © 2019 vane.greenisland. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FlowViewCell : UICollectionViewCell

- (void)setCellData:(id)data indexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
