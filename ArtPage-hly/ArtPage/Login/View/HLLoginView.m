//
//  HLLoginView.m
//  ArtPage
//
//  Created by 何龙 on 2018/9/20.
//  Copyright © 2018年 何龙. All rights reserved.
//

#import "HLLoginView.h"

@implementation HLLoginView
-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        //titleImageView
        _headImageView = [[UIImageView alloc] init];
        _headImageView.image = [UIImage imageNamed:@"share"];
        [self addSubview:_headImageView];
        [_headImageView makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.centerX);
            make.top.equalTo(60);
            make.size.equalTo(CGSizeMake(180, 180));
        }];
        //userTextField
        _userTextField = [[UITextField alloc] init];
        [self TextField:_userTextField andText:@"用户名" andTop:0];
        
        //pwdTextField
        _pwdTextField = [[UITextField alloc] init];
        [self TextField:_pwdTextField andText:@"密码" andTop:1];
        
        //LoginBtn
        _loginBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_loginBtn setImage:[UIImage imageNamed:@"btn_登录"] forState:(UIControlStateNormal)];
        [_loginBtn addTarget:self action:@selector(btnSelected) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:_loginBtn];
        [_loginBtn makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.centerX);
            make.top.equalTo(self.pwdTextField.bottom).offset(30);
            make.size.equalTo(CGSizeMake(230, 47));
        }];
        
        //btn
        _applyBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [self createBtn:_applyBtn andTitle:@"申请试用" andCenter:0];
        
        _forGetPwdBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [self createBtn:_forGetPwdBtn andTitle:@"忘记密码" andCenter:1];
        
        UILabel *lineLabel = [[UILabel alloc] init];
        lineLabel.backgroundColor = [UIColor grayColor];
        [self addSubview:lineLabel];
        [lineLabel makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.centerX);
            make.top.equalTo(self.loginBtn.bottom).offset(35);
            make.size.equalTo(CGSizeMake(1, 20));
        }];
    }
    return self;
}
#pragma btn
-(void)btnSelected
{
    if(_block)
    {
        _block(self);
    }
}
-(void)TextField:(UITextField *)textField andText:(NSString *)text andTop:(int)t
{
    textField.delegate = self;
    textField.textColor = [UIColor whiteColor];
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:text attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
    textField.attributedPlaceholder = attrString;
    [self addSubview:textField];
    [textField makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.centerX);
        make.top.equalTo(self.headImageView.bottom).offset(50 + t * 50);
        make.size.equalTo(CGSizeMake(220, 30));
    }];
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor grayColor];
    [self addSubview:label];
    [label makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.centerX);
        make.top.equalTo(textField.bottom).offset(3);
        make.size.equalTo(CGSizeMake(230, 1));
    }];
}
-(void)createBtn:(UIButton *)btn andTitle:(NSString *)title andCenter:(int)i
{
    [btn setTitle:title forState:(UIControlStateNormal)];
    [btn setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
    [self addSubview:btn];
    [btn makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.centerX).offset(-60 + i * 120);
        make.top.equalTo(self.loginBtn.bottom).offset(30);
        make.size.equalTo(CGSizeMake(80, 30));
    }];
}
#pragma mark - textField代理方法
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
@end
