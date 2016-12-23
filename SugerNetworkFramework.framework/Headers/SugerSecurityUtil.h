//
//  SugerSecurityUtil.h
//  AFNetworking Example
//
//  Created by jessica on 16/9/29.
//
//

#import <Foundation/Foundation.h>
#define defaultIv             @"01234567"
#define defaultKeyValue       @"884b2fbc1397c37a4f6fe951aa19679d"//32位
@interface SugerSecurityUtil : NSObject{
    
}
@property(nonatomic,copy)NSString *defaultKey;//统一设置默认加密盐
@property(nonatomic,copy)NSString *gIv;//统一设置默认向量

#pragma mark AES加密
/**
 *  加密
 *
 *  @param plainText 将要被加密文字
 *  @param key       加密盐
 *  @param Iv        向量
 *
 *  @return 加过密的文字
 */
+(NSData *)encrypt:(NSString*)plainText withKey:(NSString*)key withIv:(NSString*)Iv;

/**
 *  加密
 *
 *  @param plainText 将要被加密文字
 *  @param key       加密盐
 *
 *  @return 加过密的文字
 */
+(NSData *)encrypt:(NSString*)plainText withKey:(NSString*)key;

/**
 *  解密
 *
 *  @param encryptText 加过密的文字
 *  @param key         加密盐
 *  @param Iv          向量
 *
 *  @return 被加密文字
 */
+(NSString*)decrypt:( NSData *)encryptText withKey:(NSString*)key withIv:(NSString*)Iv;

/**
 *  解密
 *
 *  @param encryptText 加过密的文字
 *  @param key         加密盐
 *
 *  @return 向量
 */
+(NSString*)decrypt:( NSData *)encryptText withKey:(NSString*)key;

/**
 *  用defaultIv和defaultKeyValue宏定义的常量加密
 *
 *  @param plainText 将要被加密文字
 *
 *  @return 加过密的文字
 */
+(NSData *)encrypt:(NSString *)plainText;

/**
 *  用defaultIv和defaultKeyValue宏定义的常量解密
 *
 *  @param encryptText 加过密的文字
 *
 *  @return 解密过的文字
 */
+(NSString*)decrypt:( NSData *)encryptText;

#pragma mark Base64加密
/**
 *  将str base64加密返回str,ios7及以上支持
 *
 *  @param input 待加密的文字
 *
 *  @return 加密后文字
 */
+ (NSString*)encodeBase64String:(NSString *)input;

/**
 *  将str解密成str返回,ios7及以上支持
 *
 *  @param 待解密文字
 *
 *  @return 解密后文字
 */
+ (NSString*)decodeBase64String:(NSString *)input;

/**
 *  将data base64加密返回str,ios7及以上支持
 *
 *  @param data 待加密的data
 *
 *  @return 加密后文字
 */
+ (NSString*)encodeBase64Data:(NSData *)data;

/**
 *  将data base64解密返回str,ios7及以上支持
 *
 *  @param data 待解密的data
 *
 *  @return 解密后的文字
 */
+ (NSString*)decodeBase64Data:(NSData *)data;

#pragma mark MD5加密
/**
 *  MD5加密
 *
 *  @param string 待加密的文字
 *
 *  @return 加密后的文字
 */
+ (NSString*)encryptMD5String:(NSString*)string;

#pragma mark RSA加密
/**
 *  加密参数data
 *
 *  @param data 要加密的数据
 *  @param path 加密公钥的路径（*.der文件）
 *
 *  @return 加密后的data
 */
+(NSData*)rsaEncryptData:(NSData*)data publicKeyFilePath:(NSString*)path;

/**
 *  解密参数data
 *
 *  @param data     待解密的data
 *  @param path     解密私钥的路径（*.p12文件）
 *  @param password 私钥的密码
 *
 *  @return 解密后的文字
 */
+(NSData*)rsaDecryptData:(NSData*)data privateKeyFilePath:(NSString*)path password:(NSString*)password;

#pragma mark SM3加密
/**
 *  SM3加密
 *
 *  @param key 待加密的文字
 *
 *  @return 加密后的文字
 */
+(NSString*) sm3Algorithm:(NSString*)key;


@end
