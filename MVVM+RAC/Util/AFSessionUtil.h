//
//  AFSessionUtil.h
//  MVVM+RAC
//
//  Created by 许须耀 on 2019/12/2.
//  Copyright © 2019 许须耀. All rights reserved.
//

#import "AFHTTPSessionManager.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ResponseObj)(id obj, NSError *error);

@interface AFSessionUtil : AFHTTPSessionManager
/* + (instancetype)shareInstance */
+ (instancetype)shareInstance;

/**
 *  发送get请求
 *
 *  @param url                      请求路径
 *  @param params               请求参数
 *  @param header                   请求头Header
 *  @param downloadProgressBlock    网络请求进度
 *  @param success                  请求成功后的回调,参数为id类型
 *  @param failure                  请求失败后的回调
 */
- (NSURLSessionDataTask *)GET:(NSString *)url
                       params:(id)params
          httpHeaderKeyValues:(NSDictionary *)header
                     progress:(void (^)(NSProgress *downloadProgress))downloadProgressBlock
                      success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
                      failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure;

- (NSURLSessionDataTask *)GET:(NSString *)url
                       params:(id)params
                     progress:(void (^)(NSProgress *downloadProgress))downloadProgressBlock
                      success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
                      failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure;

/**
 *  发送post请求
 *
 *  @param url          请求路径
 *  @param params   请求参数
 *  @param header       请求头Header
 *  @param success      请求成功后的回调,参数为id类型
 *  @param failure      请求失败后的回调
 */
- (NSURLSessionDataTask *)POST:(NSString *)url
                        params:(id)params
           httpHeaderKeyValues:(NSDictionary *)header
                      progress:(void (^)(NSProgress *downloadProgress))downloadProgressBlock
                       success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
                       failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure;

- (NSURLSessionDataTask *)POST:(NSString *)url
                        params:(id)params
                      progress:(void (^)(NSProgress *downloadProgress))downloadProgressBlock
                       success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
                       failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure;

/**
 *  上传文件
 *
 *  @param url              请求路径
 *  @param params       请求参数
 *  @param header           请求头Header
 *  @param formDataBlock    上传文件的信息
 *  @param success          请求成功后的回调,参数为id类型
 *  @param failure          请求失败后的回调
 */
- (NSURLSessionDataTask *)upload:(NSString *)url
                          params:(id)params
             httpHeaderKeyValues:(NSDictionary *)header
       constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))formDataBlock
                         success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
                         failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure;

- (NSURLSessionDataTask *)upload:(NSString *)url
                          params:(id)params
       constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))formDataBlock
                         success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
                         failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure;

/**
 *  下载
 *
 *  @param url                      请求路径
 *  @param params               请求参数
 *  @param header                   请求头Header
 *  @param downloadProgressBlock    下载进度
 *  @param destination              请求成功后的回调,参数为id类型
 *  @param completionHandler        请求失败后的回调
 */
- (NSURLSessionDownloadTask *)download:(NSString *)url
                                params:(id)params
                   httpHeaderKeyValues:(NSDictionary *)header
                              progress:(void (^)(NSProgress *downloadProgress))downloadProgressBlock
                           destination:(NSURL * (^)(NSURL *targetPath, NSURLResponse *response))destination
                     completionHandler:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandler;

- (NSURLSessionDownloadTask *)download:(NSString *)url
                                params:(id)params
                              progress:(void (^)(NSProgress *downloadProgress))downloadProgressBlock
                           destination:(NSURL * (^)(NSURL *targetPath, NSURLResponse *response))destination
                     completionHandler:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandler;

/**
 json格式请求

 @param url <#url description#>
 @param token <#token description#>
 @param dic <#dic description#>
 @param responseObj <#responseObj description#>
 */
- (void)postWithUrl:(NSString *)url
              token:(NSString *)token
               dict:(NSMutableDictionary *)dic
           response:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))responseObj;

@end

NS_ASSUME_NONNULL_END
