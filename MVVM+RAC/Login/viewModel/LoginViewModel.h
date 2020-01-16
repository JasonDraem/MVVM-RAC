//
//  LoginViewModel.h
//  MVVM+RAC
//
//  Created by 许须耀 on 2019/11/13.
//  Copyright © 2019 许须耀. All rights reserved.
//

#import "BaseViewModel.h"
#import "UserModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginViewModel : BaseViewModel

@property (copy, nonatomic) NSString *account;
@property (copy, nonatomic) NSString *pwd;
@property (strong, nonatomic) NSError *error;

@property (strong, nonatomic) UserModel *user;
@property (strong, nonatomic) RACCommand *loginEnableCommand;
@property (strong, nonatomic) RACCommand *loginCommand;


@end

NS_ASSUME_NONNULL_END
