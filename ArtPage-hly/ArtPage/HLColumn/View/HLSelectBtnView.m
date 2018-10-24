//
//  HLSelectBtnView.m
//  ArtPage
//
//  Created by 何龙 on 2018/9/22.
//  Copyright © 2018年 何龙. All rights reserved.
//

#import "HLSelectBtnView.h"

@implementation HLSelectBtnView

-(id)initWithFrame:(CGRect)frame andImageNameArr:(NSArray *)arr
{
    if(self = [super initWithFrame:frame])
    {
        _btn0 = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [self createBtn:_btn0 andIndex:0 andImageName:arr[0]];
        
        _btn1 = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [self createBtn:_btn1 andIndex:1 andImageName:arr[1]];
        
        _btn2 = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [self createBtn:_btn2 andIndex:2 andImageName:arr[2]];
        
        _btn3 = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [self createBtn:_btn3 andIndex:3 andImageName:arr[3]];
        
        _btn4 = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [self createBtn:_btn4 andIndex:4 andImageName:arr[4]];
        
        _btn5 = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [self createBtn:_btn5 andIndex:5 andImageName:arr[5]];
        [_btn5 setImage:[UIImage imageNamed:@"btn_切换中文"] forState:(UIControlStateSelected)];
        
        [self btnHidden];
    }
    return self;
}
#pragma mark - btnHidden
-(void)btnHidden
{
    if([gainUserDefault(@"公开作品栏目设定") isEqualToString:@"YES"])
    {
        _btn0.hidden = YES;
    }
    else
    {
        _btn0.hidden = NO;
    }
    if([gainUserDefault(@"非公开作品栏目设定") isEqualToString:@"YES"])
    {
        _btn1.hidden = YES;
    }
    else
    {
        _btn1.hidden = NO;
    }
    if([gainUserDefault(@"关于栏目设定") isEqualToString:@"YES"])
    {
        _btn2.hidden = YES;
    }
    else
    {
        _btn2.hidden = NO;
    }
    if([gainUserDefault(@"日志栏目设定") isEqualToString:@"YES"])
    {
        _btn3.hidden = YES;
    }
    else
    {
        _btn3.hidden = NO;
    }
    if([gainUserDefault(@"language") isEqualToString:@"English"])
    {
        _btn5.selected = YES;
    }
}
#pragma mark - btnTarget
-(void)commonBtnSelected:(UIButton *)btn
{
    if(btn == _btn0)
    {
        if(_block0)
        {
            _block0(self);
        }
    }
    else if (btn == _btn1)
    {
        if(_block1)
        {
            _block1(self);
        }
    }
    else if (btn == _btn2)
    {
        if(_block2)
        {
            _block2(self);
        }
    }
    else if (btn == _btn3)
    {
        if(_block3)
        {
            _block3(self);
        }
    }
    else if (btn == _btn4)
    {
        if(_block4)
        {
            _block4(self);
        }
    }
    else
    {
        if(_btn5.selected)
        {
            _btn5.selected = NO;
            NSString *language = @"nil";
            NSLog(@"切换为中文");
            KUserDefault(language, @"language");
        }
        else
        {
            _btn5.selected = YES;
            NSLog(@"切换为英文");
            NSString *language = @"English";
            KUserDefault(language, @"language");
        }
    }
    
}
#pragma mark - btn
-(void)createBtn:(UIButton *)btn andIndex:(int)i andImageName:(NSString *)name
{
    btn.layer.borderWidth = 1.0;
    [btn.layer setBorderColor:HLColor(140, 140, 140).CGColor];
    [btn setImage:[UIImage imageNamed:name] forState:(UIControlStateNormal)];
    [btn addTarget:self action:@selector(commonBtnSelected:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self addSubview:btn];
    [btn makeConstraints:^(MASConstraintMaker *make) {
        if(i < 3)
        {
            make.left.equalTo(39 + i * ((SCREENWIDTH - 77 - 6) / 3 + 3));
            make.bottom.equalTo(self.bottom).offset(-87);
        }
        else
        {
            make.left.equalTo(39 + (i - 3) * ((SCREENWIDTH - 77 - 6) / 3 + 3));
            make.bottom.equalTo(self.bottom).offset(0);
        }
        make.size.equalTo(CGSizeMake((SCREENWIDTH - 78 - 6) / 3, 80));
    }];
}
@end
