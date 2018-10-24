//
//  HLPasswordView.h
//  ArtPage
//
//  Created by 何龙 on 2018/10/8.
//  Copyright © 2018年 何龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HLInputView.h"
@interface HLPasswordView : UIView<UITextFieldDelegate, CustomKeyboardDelegate>

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIButton *btn;

@property (nonatomic, strong) UITextField *pwdTextField;

typedef void(^pwdBlock)(HLPasswordView *view);

@property (nonatomic, copy) pwdBlock block;

@property (nonatomic, copy) pwdBlock failBlock;

@property (nonatomic, strong) NSString *pwd;

@property (nonatomic, strong) HLInputView *inputView;

-(id)initWithFrame:(CGRect)frame
               pwd:(NSString *)pwd
         titleText:(NSString *)text;
@end
