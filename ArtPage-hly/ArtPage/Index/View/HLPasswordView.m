//
//  HLPasswordView.m
//  ArtPage
//
//  Created by 何龙 on 2018/10/8.
//  Copyright © 2018年 何龙. All rights reserved.
//

#import "HLPasswordView.h"
@implementation HLPasswordView

-(id)initWithFrame:(CGRect)frame
               pwd:(NSString *)pwd
         titleText:(NSString *)text
{
    if(self = [super initWithFrame:frame])
    {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        UILabel *backgroudLabel = [[UILabel alloc] init];
        backgroudLabel.backgroundColor = HLColor(186, 186, 186);
        backgroudLabel.layer.cornerRadius = 20;
        backgroudLabel.layer.masksToBounds = YES;
        backgroudLabel.userInteractionEnabled = NO;
        [self addSubview:backgroudLabel];
        [backgroudLabel makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(0);
            make.centerY.equalTo(self.centerY).offset(20);
            make.size.equalTo(CGSizeMake(SCREENWIDTH, 150));
        }];
        _pwd = pwd;
        //titleLabel
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.text = text;
        self.titleLabel.font = HLFont(18);
        self.titleLabel.textColor = HLColor(141, 142, 143);
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
        [_titleLabel makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(0);
            make.centerY.equalTo(self.centerY).offset(-30);
            make.size.equalTo(CGSizeMake(SCREENWIDTH, 20));
        }];
        
        _inputView = [[HLInputView alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT - 180, SCREENWIDTH, 180)];
        _inputView.delegate = self;
        __weak typeof (self)weakSelf = self;
        _inputView.deleteBlock = ^(HLInputView *view) {
            weakSelf.pwdTextField.text = nil;
        };
        _inputView.doneBlock = ^(HLInputView *view) {
            [weakSelf.pwdTextField resignFirstResponder];
        };
//        [self addSubview:_inputView];
        //textField;
        _pwdTextField = [[UITextField alloc] init];
        _pwdTextField.font = HLFont(14);
        _pwdTextField.inputView = _inputView;
        
        [self TextField:_pwdTextField andText:@"输入分组密码"];
        [_pwdTextField makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(49);
            make.centerY.equalTo(self.centerY);
            make.size.equalTo(CGSizeMake(SCREENWIDTH - 98, 22));
        }];
        UILabel *lineLabel = [[UILabel alloc] init];
        lineLabel.backgroundColor = [UIColor grayColor];
        [self addSubview:lineLabel];
        [lineLabel makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(45);
            make.top.equalTo(self.pwdTextField.bottom);
            make.size.equalTo(CGSizeMake(SCREENWIDTH - 90, 1));
        }];
        //btn
        _btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
//        [_btn setImage:[UIImage imageNamed:@"btn_进入分组"] forState:(UIControlStateNormal)];
        
        [_btn setTitle:@"进入分组" forState:(UIControlStateNormal)];
        _btn.titleLabel.textColor = [UIColor blackColor];
        _btn.layer.masksToBounds = YES;
        _btn.layer.cornerRadius = 10;
        _btn.backgroundColor = [UIColor orangeColor];
        [_btn addTarget:self action:@selector(btnSelected) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:_btn];
        [_btn makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(45);
            make.top.equalTo(lineLabel.bottom).offset(20);
            make.size.equalTo(CGSizeMake(SCREENWIDTH - 90, 47));
        }];
    }
    return self;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    [UIView animateWithDuration:0.3 animations:^{
//        self.frame = CGRectMake(0, -SCREENHEIGHT, 0, SCREENHEIGHT);
//    }];
    
    [_pwdTextField resignFirstResponder];
    [self removeFromSuperview];
}
-(void)btnSelected
{
    [_pwdTextField resignFirstResponder];
    if([_pwdTextField.text isEqualToString:_pwd])
    {
        if(_block)
        {
            _block(self);
        }
    }
    else
    {
        NSLog(@"密码不正确");
        [self removeFromSuperview];
        if(_failBlock)
        {
            _failBlock(self);
        }
    }
}
-(void)TextField:(UITextField *)textField andText:(NSString *)text
{
    textField.delegate = self;
    textField.textColor = [UIColor whiteColor];
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:text attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
    textField.attributedPlaceholder = attrString;
    [self addSubview:textField];
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
}
-(BOOL)textFieldShouldClear:(UITextField *)textField
{
    textField.text = nil;
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)keyboardItemDidClicked:(NSString *)item{
    self.pwdTextField.text = [self.pwdTextField.text stringByAppendingString:item];
}
@end
