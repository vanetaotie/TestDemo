//
//  MainViewController.h
//  TestDemo
//
//  Created by vane on 15/2/2.
//  Copyright (c) 2015年 vane.greenisland. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>

typedef enum {
    ktesttypeA,
    ktesttypeB = 11,
    ktesttypeC,
    ktesttypeD = 3,
    ktesttypeE,
    ktesttypeF
}TestType;

@interface MainViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, SKStoreProductViewControllerDelegate>

@property (nonatomic, assign) TestType testtype;

@end
