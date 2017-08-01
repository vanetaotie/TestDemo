//
//  DLApiObject.h
//  TestDemo
//
//  Created by zhongk on 01/08/2017.
//  Copyright © 2017 vane.greenisland. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DLApiObject : NSObject

/** 应用唯一标识，由第三方应用提交移动门后台应用审核通过后获得 */
@property (nonatomic, copy) NSString *appID;

/** 应用作用授权域，默认snsapi_userinfo，暂不需要设置 */
@property (nonatomic, copy) NSString *scope;

/** 用于保持请求和回调状态，防止scrf攻击，建议第三方应用带上该参数进行校验 */
@property (nonatomic, copy) NSString *state;

@end
