//
//  LoginController.m
//  MVVM+RAC
//
//  Created by 许须耀 on 2019/11/13.
//  Copyright © 2019 许须耀. All rights reserved.
//

#import "LoginController.h"
#import "LoginView.h"
#import "LoginViewModel.h"

@interface LoginController ()<LoginViewDelegate>

@property (nonatomic, strong) LoginView *loginView;
@property (nonatomic, strong) LoginViewModel *loginViewModel;
// me_next_sel_icon \ me_next_normal_icon

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.loginView = [[LoginView alloc] initWithFrame:self.view.bounds];
    self.loginView.delegate = self;
    [self.view addSubview:self.loginView];
    
    [self initCommand];
    [self initSubscribe];
}

- (void)initCommand{
    self.loginViewModel = [[LoginViewModel alloc] init];
    RAC(self.loginViewModel, account) = self.loginView.mobileTextField.rac_textSignal;
    RAC(self.loginViewModel, pwd) = self.loginView.pwdTextField.rac_textSignal;
}

- (void)initSubscribe{
    //VM内部处理按钮的可用状态 直接将结果告诉V
    [[self.loginViewModel.loginEnableCommand.executionSignals switchToLatest] subscribeNext:^(id  _Nullable x) {
        self.loginView.confirm.enabled = [x boolValue];
    }];
    //监听当前命令是否正在执行executing
    //监听命令是否执行完毕,默认会来一次，可以直接跳过，skip表示跳过第一次信号。
    //x:YES 当前cmd正在触发执行
    //x:NO 当前cmd不处于执行状态/或已处理完成
    [[self.loginViewModel.loginCommand.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
        if ([x boolValue]) {
            [self.view makeToast:@"loading..." duration:1.0 position:CSToastPositionCenter];
        }else{
            //[self.view makeToast:@"finished" duration:1.0 position:CSToastPositionCenter];
        }
    }];
    //监听数据回调
    [[self.loginViewModel.loginCommand.executionSignals switchToLatest] subscribeNext:^(id  _Nullable x) {
        LoginViewModel *loginViewModel = x;
        if (!loginViewModel) {
            return;
        }
        if (loginViewModel.error) {//error
            [self.view makeToast:[NSString stringWithFormat:@"%@",self.loginViewModel.error.userInfo[@"des"]]];
        }else{//success
            [self.view makeToast:@"success"];
            BaseTabbarController *tabbar = [[BaseTabbarController alloc] init];
            self.view.window.rootViewController = tabbar;
        }
    }];
}

#pragma mark - LoginViewDelegate
- (void)signalWithSender:(UIButton *)sender{
    [self.loginViewModel.loginCommand execute:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}


@end
