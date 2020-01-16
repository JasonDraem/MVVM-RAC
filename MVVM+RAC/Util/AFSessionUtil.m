//
//  AFSessionUtil.m
//  MVVM+RAC
//
//  Created by 许须耀 on 2019/12/2.
//  Copyright © 2019 许须耀. All rights reserved.
//

#import "AFSessionUtil.h"

@implementation AFSessionUtil

+ (instancetype)shareInstance{
    static AFSessionUtil *sessionUtil = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sessionUtil = [[AFSessionUtil alloc] init];
    });
    return sessionUtil;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.requestSerializer = [AFHTTPRequestSerializer serializer];
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", @"multipart/form-data", @"application/xhtml+xml", @"image/jpeg", @"application/xml", @"application/json;charset=utf-8",@"text/html;charset=utf-8",nil];
    }
    return self;
}

- (void)session_setHttpHeaderKeyValues:(NSDictionary *)keyValues{
    if (keyValues && keyValues.count > 0) {
        [keyValues enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [self.requestSerializer setValue:obj forKey:key];
        }];
    }
}

/**
 *  发送get请求
 */
- (NSURLSessionDataTask *)GET:(NSString *)url
                       params:(id)params
          httpHeaderKeyValues:(NSDictionary *)header
                     progress:(void (^)(NSProgress *downloadProgress))downloadProgressBlock
                      success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
                      failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure {
    /**
     *  可以接受的类型
     */
    self.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    /**
     *  请求超时的时间
     */
    self.requestSerializer.timeoutInterval = 30;
    
    /**
     *  Header 请求头
     */
    if (header) {
        [self session_setHttpHeaderKeyValues:header];
    }
    
    NSURLSessionDataTask *task = [self GET:url parameters:params progress:downloadProgressBlock success:success failure:failure];
    return task;
}

- (NSURLSessionDataTask *)GET:(NSString *)url
                       params:(id)params
                     progress:(void (^)(NSProgress *downloadProgress))downloadProgressBlock
                      success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
                      failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure {
    return [self GET:url params:params httpHeaderKeyValues:@{} progress:downloadProgressBlock success:success failure:failure];
}
/**
*  发送post请求
*/
- (NSURLSessionDataTask *)POST:(NSString *)url
                        params:(id)params
           httpHeaderKeyValues:(NSDictionary *)header
                      progress:(void (^)(NSProgress *downloadProgress))downloadProgressBlock
                       success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
                       failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure {
    /**
     *  可以接受的类型
     */
    self.responseSerializer = [AFHTTPResponseSerializer serializer];
    /**
     *  请求超时的时间
     */
    self.requestSerializer.timeoutInterval = 30;
    /**
     *  Header 请求头
     */
    if (header) {
        [self session_setHttpHeaderKeyValues:header];
    }
    NSURLSessionDataTask *task = [self POST:url params:params httpHeaderKeyValues:header progress:downloadProgressBlock success:success failure:failure];
    return task;
}

- (NSURLSessionDataTask *)POST:(NSString *)url
                        params:(id)params
                      progress:(void (^)(NSProgress *downloadProgress))downloadProgressBlock
                       success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
                       failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure {
    return [self POST:url params:params httpHeaderKeyValues:@{} progress:downloadProgressBlock success:success failure:failure];
}

/**
 *  上传文件
 */
- (NSURLSessionDataTask *)upload:(NSString *)url
                      params:(id)params
             httpHeaderKeyValues:(NSDictionary *)header
       constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))formDataBlock
                         success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
                         failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure {
    /**
     *  可以接受的类型
     */
    self.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    /**
     *  请求超时的时间
     */
    self.requestSerializer.timeoutInterval = 30;
    
    /**
     *  Header 请求头
     */
    if (header) {
        [self session_setHttpHeaderKeyValues:header];
    }
    
    NSURLSessionDataTask *task = [self POST:url parameters:params constructingBodyWithBlock:formDataBlock progress:nil success:success failure:failure];
    
    return task;
}

- (NSURLSessionDataTask *)upload:(NSString *)url
                      params:(id)params
       constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))formDataBlock
                         success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
                         failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure {
    return [self upload:url params:params httpHeaderKeyValues:@{} constructingBodyWithBlock:formDataBlock success:success failure:failure];
}

/**
 *  下载
 */
- (NSURLSessionDownloadTask *)download:(NSString *)url
                            params:(id)params
                   httpHeaderKeyValues:(NSDictionary *)header
                              progress:(void (^)(NSProgress *downloadProgress))downloadProgressBlock
                           destination:(NSURL * (^)(NSURL *targetPath, NSURLResponse *response))destination
                     completionHandler:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandler {
    /**
     *  Header 请求头
     */
    if (header) {
        [self session_setHttpHeaderKeyValues:header];
    }
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLSessionDownloadTask *task = [self downloadTaskWithRequest:request progress:downloadProgressBlock destination:destination completionHandler:completionHandler];
    [task resume];
    return task;
}

- (NSURLSessionDownloadTask *)download:(NSString *)url
                            params:(id)params
                              progress:(void (^)(NSProgress *downloadProgress))downloadProgressBlock
                           destination:(NSURL * (^)(NSURL *targetPath, NSURLResponse *response))destination
                     completionHandler:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandler {
    return [self download:url params:params httpHeaderKeyValues:@{} progress:downloadProgressBlock destination:destination completionHandler:completionHandler];
}
/* json格式请求发送post请求 */
- (void)postWithUrl:(NSString *)url token:(NSString *)token dict:(NSMutableDictionary *)dic response:(void (^)(NSURLResponse * _Nonnull, NSURL * _Nonnull, NSError * _Nonnull))responseObj{
    NSError *parseError = nil;
    NSData *jsonData = nil;
    NSString *jsonString = nil;
    if (dic && dic.count > 0){
        jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    AFSecurityPolicy *securityPolicy = [self customSecurityPolicy];
    self.securityPolicy = securityPolicy;
    NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:url parameters:nil error:nil];
    req.timeoutInterval = 30.0;
    [req setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [req setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Accept"];
    if (dic && dic.count > 0){
        [req setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    }
    [self dataTaskWithRequest:req uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
    } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
    } completionHandler:responseObj];
}

//检测本地证书
- (AFSecurityPolicy *)customSecurityPolicy{
    //先导入证书，找到证书的路径
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"twomantechcom" ofType:@"cer"];
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    //AFSSLPinningModeCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    //allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    //如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    
    //validatesDomainName 是否需要验证域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = NO;
    NSSet *set = [[NSSet alloc] initWithObjects:certData, nil];
    securityPolicy.pinnedCertificates = set;
    
    return securityPolicy;
}

@end
