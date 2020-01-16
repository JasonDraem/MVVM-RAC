//
//  LoginView.m
//  MVVM+RAC
//
//  Created by 许须耀 on 2019/11/14.
//  Copyright © 2019 许须耀. All rights reserved.
//

#import "LoginView.h"

#define KIMG(imgName)   [UIImage imageNamed:imgName]

@interface LoginView ()

@property (nonatomic, strong) UIImageView *rightTopImgView;
@property (nonatomic, strong) UIImageView *meImgView;
@property (nonatomic, strong) UIImageView *msgImgView;

@property (nonatomic, strong) UIView *accountView;
@property (nonatomic, strong) UIView *pwdView;

@property (nonatomic, strong) UIImageView *mobileIconImgView;
@property (nonatomic, strong) UIImageView *lockIconImgView;

@end

@implementation LoginView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        /* icons */
        self.rightTopImgView = [self imgViewWithImgName:@"righttop_icon"];
        self.meImgView = [self imgViewWithImgName:@"me_login_icon"];
        self.msgImgView = [self imgViewWithImgName:@"MutualEmotion"];
        /* super view */
        self.accountView = [self viewWithBgColor:[UIColor whiteColor]];
        self.pwdView = [self viewWithBgColor:[UIColor whiteColor]];
        /* textfield */
        self.mobileTextField = [self textfeildWithPlacholder:@"请输入手机号" fontSize:15];
        self.pwdTextField = [self textfeildWithPlacholder:@"请输入密码" fontSize:15];
        /* left icons */
        self.mobileIconImgView = [self imgViewWithImgName:@"me_login_mobile"];
        self.lockIconImgView = [self imgViewWithImgName:@"me_login_lock"];
        self.confirm = [self buttonWithImgName:@"me_next_sel_icon" target:self sel:@selector(targetWithSender:)];//me_next_sel_icon \ me_next_normal_icon
        [self.confirm setImage:[UIImage imageNamed:@"me_next_normal_icon"] forState:UIControlStateNormal];
        [self.confirm setImage:[UIImage imageNamed:@"me_next_sel_icon"] forState:UIControlStateDisabled];
        
        [self addSubview:self.rightTopImgView];
        [self addSubview:self.meImgView];
        [self addSubview:self.msgImgView];
        [self addSubview:self.accountView];
        [self addSubview:self.pwdView];
        
        [self.accountView addSubview:self.mobileIconImgView];
        [self.accountView addSubview:self.mobileTextField];
        [self.pwdView addSubview:self.lockIconImgView];
        [self.pwdView addSubview:self.pwdTextField];
        [self addSubview:self.confirm];
        
        self.rightTopImgView.sd_layout.
        topEqualToView(self).
        rightEqualToView(self).
        widthIs(KIMG(@"righttop_icon").size.width).
        heightIs(KIMG(@"righttop_icon").size.height);
        
        self.meImgView.sd_layout.centerXEqualToView(self).
        topSpaceToView(self, 112).
        widthIs(KIMG(@"me_login_icon").size.width).
        heightIs(KIMG(@"me_login_icon").size.height);
        
        self.msgImgView.sd_layout.centerXEqualToView(self).
        topSpaceToView(self.meImgView, 8).
        widthIs(KIMG(@"MutualEmotion").size.width).
        heightIs(KIMG(@"MutualEmotion").size.height);
        
        self.accountView.sd_layout.
        leftSpaceToView(self, 40).
        rightSpaceToView(self, 40).
        topSpaceToView(self.msgImgView, 58).
        heightIs(40);
        
        self.pwdView.sd_layout.
        leftSpaceToView(self, 40).
        rightSpaceToView(self, 40).
        topSpaceToView(self.accountView, 18).
        heightIs(40);
        
        self.mobileIconImgView.sd_layout.
        centerYEqualToView(self.accountView).
        leftSpaceToView(self.accountView, 20).
        widthIs(KIMG(@"me_login_mobile").size.width).
        heightIs(KIMG(@"me_login_mobile").size.height);
        
        self.lockIconImgView.sd_layout.
        centerYEqualToView(self.pwdView).
        leftSpaceToView(self.pwdView, 20).
        widthIs(KIMG(@"me_login_lock").size.width).
        heightIs(KIMG(@"me_login_lock").size.height);
        
        self.mobileTextField.sd_layout.
        centerYEqualToView(self.accountView).
        leftSpaceToView(self.mobileIconImgView, 15).
        rightSpaceToView(self.accountView, 20).
        heightIs(KIMG(@"me_login_mobile").size.height + 5);
        
        self.pwdTextField.sd_layout.
        centerYEqualToView(self.pwdView).
        leftSpaceToView(self.lockIconImgView, 15).
        rightSpaceToView(self.pwdView, 20).
        heightIs(KIMG(@"me_login_lock").size.height + 5);
        
        self.confirm.sd_layout.
        rightEqualToView(self.accountView).
        topSpaceToView(self.pwdView, 98).
        widthIs(KIMG(@"me_next_normal_icon").size.width).
        heightIs(KIMG(@"me_next_normal_icon").size.height);
        
        /* add border color and corners */
        [self clipBorderWithColor:[[UIColor lightGrayColor] colorWithAlphaComponent:.4] corners:20 view:self.accountView];
        [self clipBorderWithColor:[[UIColor lightGrayColor] colorWithAlphaComponent:.4] corners:20 view:self.pwdView];
    }
    return self;
}

#pragma mark - pravite 🔒
#pragma mark - create imgView
- (UIImageView *)imgViewWithImgName:(NSString *)imgName{
    UIImage *img = [UIImage imageNamed:imgName];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
    return imgView;
}
#pragma mark - create view
- (UIView *)viewWithBgColor:(UIColor *)color{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = color;
    return view;
}
#pragma mark - create textfield
- (UITextField *)textfeildWithPlacholder:(NSString *)placeholder
                                fontSize:(CGFloat)fontSize{
    UITextField *tf = [[UITextField alloc] init];
    tf.placeholder = placeholder;
    tf.font = [UIFont systemFontOfSize:fontSize];
    return tf;
}
#pragma mark - create button
- (UIButton *)buttonWithImgName:(NSString *)imgName
                         target:(id)target
                            sel:(SEL)sel{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[[UIImage imageNamed:imgName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (void)targetWithSender:(UIButton *)sender{
    [self endEditing:YES];
    if (self.delegate && [self.delegate respondsToSelector:@selector(signalWithSender:)]) {
        [self.delegate signalWithSender:sender];
    }
}
#pragma mark - add border and corners
- (void)clipBorderWithColor:(UIColor *)color
                    corners:(CGFloat)corners
                       view:(UIView *)view{
    view.layer.borderColor = color.CGColor;
    view.layer.borderWidth = .5;
    view.layer.cornerRadius = corners;
    view.layer.masksToBounds = YES;
}

@end
