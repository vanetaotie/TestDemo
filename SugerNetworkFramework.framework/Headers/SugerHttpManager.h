//
//  SugerHttpManager.h
//  sugersdk
//
//  Created by jessica on 16/9/27.
//
//
/*******
 
 version = 201612191030
 
 ***********/

#import "AFNetworking.h"

/**
 *  钥匙串名字
 */
FOUNDATION_EXTERN NSString * const  key_chain;

FOUNDATION_EXTERN NSString * const  key_lockstate;

/**
 *  网络请求，请求成功后携带返回的信息的block
 *
 *  @param successCode 返回成功的code 200
 *  @param successMsg  返回成功的提示信息
 *  @param result      返回JSON类型的字符串
 */
typedef void (^RequestSuccess)(NSString *successCode,NSString *successMsg, id result);

/**
 *  网络请求，请求失败后携带返回的信息的block
 *
 *  @param errorCode 返回失败的code，包括服务器异常、网络异常
 *  @param errorMsg  返回错误的提示信息
 *  @param error     返回失败的错误内容
 */
typedef void (^RequestFailure)(NSString *errorCode, NSString *errorMsg, NSError *error);

/**
 *  SugerHttpManager是处理网络请求的，是继承AFHTTPSessionManager的，包括头信息的添加，参数的加密解密等功能，可以通过sharedClient获取一个单例，设置全局的访问熟悉，也可以new对象，分别配置访问相关属性。
 */
@interface SugerHttpManager : AFHTTPSessionManager

/**
 *  设置是否对传入的参数加密,加密一般用在注册登录，默认NO,不加密
 */
@property(nonatomic,assign)BOOL needEncrypt;

/**
 *  是否用证书，默认NO,不用
 */
@property(nonatomic,assign)BOOL useCerfiticate;

/**
 *  全局请求超时时间,默认60秒
 */
@property(nonatomic,assign)NSTimeInterval  globalTimeInterval;

/**
 *  局部请求超时时间,默认60秒
 */
@property(nonatomic,assign) NSTimeInterval timeInterval;

/**
 *  全局加密盐，默认为空
 */
@property(nonatomic,strong)NSString *globalEncryptSalt;

/**
 *  局部加密盐，默认为空
 */
@property(nonatomic,strong)NSString *encryptSalt;

/**
 *  设置是否全局加密，加密一般用在注册登录,默认NO,不加密
 */
@property(nonatomic,assign)BOOL designGlobalEncrypt;

/**
 *  key为请求的path,value为用于header中的appServerCode
 */
@property (nonatomic, strong)NSMutableDictionary *configHeadFromXMLDic;

/**
 *  设置编码格式，可选@"utf-8"，@"gbk"。默认为@"utf-8"
 */
@property(nonatomic,copy,setter=setEncodeFormat:)NSString * encodeFormat;

/**
 *  YES:直接返回服务器返回的值
    NO:对服务器返回的值做解析处理后返回，为默认值
 */
@property(nonatomic,assign)BOOL enableGetRequestResultDirectly;

/**
 *  获取SugerHttpManager的一个单例，用于设置全局性设置
 *
 *  @return 一个单例
 */
+ (instancetype)sharedClient;

/**
 *  销毁SugerHttpManager的单例
 */
+(void)destoryInstance;

/**
 *  此方法专门为调用sharedClient实例后，设置BaseURL的方法，而且此时不能调用initWithBaseURL方法设置BaseURL，例子如下：
 *   SugerHttpManager *manager = [SugerHttpManager sharedClient];
     [manager setSugerBaseURL:[NSURL URLWithString:urlString]];
     此方法可以多个请求共享一个session
 *  @param url 为含有http协议的baseUrl
 */
-(void)setSugerBaseURL:(NSURL *)url;

/**
 *  此方法专门为获取一个SugerHttpManager实例的方法，init方法传入baseUrl，例子如下：
    SugerHttpManager *manager = [[SugerHttpManager alloc]initWithSugerBaseURL:[NSURL URLWithString:urlString]];
 *  此方法不同的SugerHttpManager实例产生不同的session
 *  @param url 为含有http协议的baseUrl
 *
 *  @return 一个实例
 */
-(instancetype)initWithSugerBaseURL:(NSURL *)url;

/**
 *  如果是@"GET"或@"HEAD"或@"DELETE"请求，此参数会被拼在URL中，如果不是会被放在body中传给服务器
 *
 *  @param parameters 请求携带的参数
 */
-(void)setBody:(NSDictionary*)parameters;

/**
 *  如果是@"GET"或@"HEAD"或@"DELETE"请求
 *  如果baseUrl是要请求的完整的URL，在url中追加请求信息,如果与URL中参数重复则覆盖，不重复则追加。
 *
 *  @param parameters 请求携带的参数
 */
-(void)appendRequestParametersInURL:(NSDictionary*)parameters;

/**
 *  设置头信息
 *
 *  @param header 设置头信息的key值
 *  @param value  设置头信息的value值
 */
-(void)setDefaultHeader:(NSString*)header value:(NSString*)value;

//返回所有的请求头设置
-(NSDictionary*)getDefaultHeader;

/**
 *  设置网络请求方式，包含@"POST"、@"GET"、@"HEAD"、@"PUT"、@"PATCH"、@"DELETE"请求，默认是GET请求
 *
 *  @param requestMode 请求类型
 */
-(void)setHTTPMethod:(NSString*)requestMode;

/**
 *  设置是否加密,默认不加密
 *
 *  @param isNeed 是否加密
 */
-(void)isNeedEncrypt:(BOOL)isNeed;

/**
 *  设置网络请求超时时长
 *
 *  @param timeoutInterval 超时时长，单位为秒
 */
-(void)setTimeoutInterval:(NSTimeInterval)timeoutInterval;

/**
 *  设置全局网络请求超时时长
 *
 *  @param timeoutInterval 超时时长，单位为秒
 */
+(void)setGlobalTimeInterval:(NSTimeInterval)timeoutInterval;

/**
 *  发出请求的核心方法
 *
 *  @param uri                请求的path,与baseUrl组成完整的url
 *  @param parametersOriginal 携带的参数
 *  @param success            请求成功返回，调用success block
 *  @param failure            请求失败返回，调用failure block
 *
 *  @return 一个task，获取该task，可以进行暂停，取消操作
 */
-(NSURLSessionTask*) httpRequest:(NSString*)uri
                      parameters:(NSDictionary*)parameters
                         success:(RequestSuccess) success
                         failure:(RequestFailure ) failure;

/**
 *  取消一个请求
 *
 *  @param sessionTask 发起请求时获取的task
 */
-(void)cancelAllHTTPOperationsWithMethod:(NSURLSessionTask*)sessionTask;

/**
 *  给特定请求加特定的cer证书
 *
 *  @param path cer文件的url
 */
-(void)setCertificateWithPath:(NSString *)path;

/**
 *  根据特定的访问的uri，从xml文件中查询出特定的头部信息，和用parameters生成hashcode
 *
 *  @param path       uri
 *  @param parameters 请求携带的参数
 */
-(void)addHeaderWithPath:(NSString*)path andParameters:(NSDictionary*)parameters andBodyParameters:(NSDictionary*)bodyParameters;

/**
 *  用于单独下载的头信息
 *
 *  @param appCode       为服务器要求客户端传入的appCode头信息的值
 *  @param appServerCode 为服务器要求客户端传入的appServerCode头信息的值
 */
- (void)addDownloadHeaderwithappCode:(NSString *)appCode appServerCode:(NSString *)appServerCode;

/**
 *  添加新的客户端可以接收的数据类型，重复添加会被去重
 *
 *  @param types 添加的字符串的集合
 */
-(void)addAcceptableContentTypes:(NSSet<NSString*>*)types;

@end
