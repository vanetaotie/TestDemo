//
//  WebViewController.h
//  TestDemo
//
//  Created by zhongk on 11/14/16.
//  Copyright © 2016 vane.greenisland. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController

- (void)cleanWebViewCache:(NSString *)testA withText:(NSString *)testB;

+ (void)testMethod:(NSString *)testA withText:(NSString *)testB;

@end
