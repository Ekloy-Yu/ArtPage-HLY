//
//  HLLoginView.h
//  ArtPage
//
//  Created by 何龙 on 2018/9/20.
//  Copyright © 2018年 何龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HLLoginView : UIView<UITextFieldDelegate>

typedef void (^LoginBlock)(HLLoginView *loginView);

@property (nonatomic, copy) LoginBlock block;
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) UITextField *userTextField;
@property (nonatomic, strong) UITextField *pwdTextField;
@property (nonatomic, strong) UIButton *applyBtn;
@property (nonatomic, strong) UIButton *forGetPwdBtn;
@end
