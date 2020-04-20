//
//  BlockKit.h
//  TestDemo
//
//  Created by vane on 2020/4/8.
//  Copyright © 2020 vane.greenisland. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#ifndef BlockKit_h
#define BlockKit_h

typedef void (^VoidBlock)(void);
typedef void (^StringBlock)(NSString *info, NSError *error);
typedef void (^BoolBlock)(BOOL flag, NSError *error);
typedef void (^ObjectBlock)(id object, NSError *error);
typedef void (^ArrayBlock)(NSArray *objects, NSError *error);
typedef void (^DictionaryBlock)(NSDictionary *infoDict, NSError *error);
typedef void (^IntegerBlock)(NSInteger index, NSError *error);
typedef void (^ErrorBlock)(NSError *error);
typedef void (^ImageBlock)(UIImage *image, NSURL *imageUrl);

#endif /* BlockKit_h */
