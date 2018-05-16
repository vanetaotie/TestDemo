//
//  HorizontalViewController.h
//  TestDemo
//
//  Created by yoho on 2018/4/26.
//  Copyright © 2018年 vane.greenisland. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HorizontalModel : NSObject

@property (nonatomic, assign) BOOL isFirst;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *topString;

@end

@interface HorizontalViewController : UIViewController

@end

@interface HorizontalCell : UICollectionViewCell

- (void)setCellData:(HorizontalModel *)model;

@end

@interface HorizontalTopCell : UITableViewCell

@end
