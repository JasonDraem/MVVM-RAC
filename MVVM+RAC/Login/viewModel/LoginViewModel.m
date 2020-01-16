//
//  LoginViewModel.m
//  MVVM+RAC
//
//  Created by 许须耀 on 2019/11/13.
//  Copyright © 2019 许须耀. All rights reserved.
//

#import "LoginViewModel.h"

@implementation LoginViewModel

- (instancetype)init{
    self = [super init];
    if (self) {
        [self initCommond];
        [self initSubscribe];
    }
    return self;
}

- (void)initCommond{
    self.loginEnableCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [self racForSubmitEnable];
    }];
    self.loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [self racForLogin];
    }];
}
- (void)initSubscribe{
    [RACObserve(self, account) subscribeNext:^(id  _Nullable x) {
        [self checkSubmitEnable];
    }];
    [RACObserve(self, pwd) subscribeNext:^(id  _Nullable x) {
        [self checkSubmitEnable];
    }];
}

- (void)checkSubmitEnable {
    [self.loginEnableCommand execute:nil];
}

- (RACSignal *)racForSubmitEnable{
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        BOOL status = self.account.length ==3 && self.pwd.length == 3;
        [subscriber sendNext:@(status)];
        [subscriber sendCompleted];
        return nil;
    }];
}

- (RACSignal *)racForLogin{
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        UserModel *user = [[UserModel alloc] init];
        if ([self.account isEqualToString:@"123"] && [self.pwd isEqualToString:@"123"]) {
            user.userId = [NSString stringWithFormat:@"%@%@", self.account, self.pwd];
            user.username = user.userId;
            self.error = nil;
        }else{
            self.error = [NSError errorWithDomain:@"-1" code:-1 userInfo:@{@"des":@"账号密码错误"}];
            [subscriber sendError:self.error];
        }
        self.user = user;
        //结果发送给监听方
        [subscriber sendNext:self];
        [subscriber sendCompleted];
        return nil;
    }];
}


@end
