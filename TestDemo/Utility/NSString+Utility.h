//
//  NSString+Utility.h
//  TestDemo
//
//  Created by vane on 2019/5/31.
//  Copyright © 2019 vane.greenisland. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Utility)

//md5加密
- (NSString *)zy_md5String;

//base64编码
- (NSString *)zy_base64EncodeString;

//base64解码
- (NSString *)zy_base64DecodeString;

@end

NS_ASSUME_NONNULL_END
