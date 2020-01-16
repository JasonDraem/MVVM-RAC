//
//  AFSessionUtil+HomeRequest.m
//  MVVM+RAC
//
//  Created by 许须耀 on 2019/12/4.
//  Copyright © 2019 许须耀. All rights reserved.
//

#import "AFSessionUtil+HomeRequest.h"

@implementation AFSessionUtil (HomeRequest)

+ (void)home_requestWithTitle:(NSString *)title response:(ResponseObj)response{
    NSMutableString *url = [NSMutableString string];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    [[AFSessionUtil shareInstance] POST:url params:dic progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull obj, id _Nullable error) {
        
    } failure:^(NSURLSessionDataTask * _Nullable obj, NSError * _Nonnull error) {
        
    }];
}

@end
