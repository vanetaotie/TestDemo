//
//  PopView.h
//  test
//
//  Created by daixu on 14-8-4.
//  Copyright (c) 2014年 daixu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopView : UIView<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
{
    UITableView *myTableView;
}
@end
