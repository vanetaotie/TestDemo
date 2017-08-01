//
//  DLApi.h
//  TestDemo
//
//  Created by zhongk on 01/08/2017.
//  Copyright © 2017 vane.greenisland. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DLApiObject.h"

/*! @brief 移动门户SDK Delegate
 *
 * 接收来至移动门户客户端的事件消息，接收后唤起第三方App来处理。
 * 移动门户SDK会在handleOpenURL中根据消息回调DLApiDelegate的方法。
 */
@protocol DLApiDelegate <NSObject>

/*! @brief 收到一个来自移动门户客户端的应答消息
 *
 * 收到的处理结果为OAuth开放授权返回的authCode以及错误信息。
 */
- (void)respAuthCode:(NSString *)authCode errorString:(NSString *)errorStr;

@end

@interface DLApi : NSObject

/*! @brief 注册第三方App到移动门户客户端。
 *
 * @param appID 移动门户开放平台注册的appID，同时也是UrlScheme
 * @return 成功返回YES，失败返回NO。
 */
+ (BOOL)registerApp:(NSString *)appID;

/*! @brief 发送OAuth请求消息到移动门户客户端。
 *
 * 发送消息后，会唤起移动门户客户端；第三方应用程序等待易信返回响应消息。
 * @param req 请求事件消息的对象。
 * @return 成功返回YES，失败返回NO。
 */
+ (BOOL)sendOAuthReq:(DLApiObject *)req;

/*! @brief 第三方App被移动门户客户端通过URL唤起时的调用
 *
 * 需要在 application:openURL:sourceApplication:annotation:或者application:handleOpenURL中调用。
 * @param url 启动第三方App的URL
 * @param delegate  DLApiDelegate对象，用来接收移动门户客户端触发的消息。
 * @return 成功返回YES，失败返回NO。
 */
+ (BOOL)handleOpenURL:(NSURL *)url
             delegate:(id<DLApiDelegate>)delegate;

@end
