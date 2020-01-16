//
//  LoginView.h
//  MVVM+RAC
//
//  Created by 许须耀 on 2019/11/14.
//  Copyright © 2019 许须耀. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LoginViewDelegate <NSObject>

@optional

- (void)signalWithSender:(UIButton *)sender;

@end

@interface LoginView : UIView
/* 账号 */
@property (nonatomic, strong) UITextField *mobileTextField;
/* 密码 */
@property (nonatomic, strong) UITextField *pwdTextField;
/* 确定 */
@property (nonatomic, strong) UIButton *confirm;
/* 声明代理 LoginViewDelegate */
@property (nonatomic, weak) id<LoginViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
