//
//  UserModel.h
//  MVVM+RAC
//
//  Created by 许须耀 on 2019/11/13.
//  Copyright © 2019 许须耀. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserModel : NSObject

@property (copy, nonatomic) NSString *username;
@property (copy, nonatomic) NSString *userId;
@property (copy, nonatomic) NSString *password;

//- (RACSignal *)loginSignal;//登录
//- (RACSignal *)logoutSignal;//退出

@end

NS_ASSUME_NONNULL_END
