//
//  HLTwoFooterView.m
//  ArtPage
//
//  Created by 何龙 on 2018/9/19.
//  Copyright © 2018年 何龙. All rights reserved.
//

#import "HLTwoFooterView.h"

@implementation HLTwoFooterView

-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        _leftBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_leftBtn setImage:[UIImage imageNamed:@"btn_栏目"] forState:UIControlStateNormal];
        [_leftBtn addTarget:self action:@selector(leftBtnSelected) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:_leftBtn];
        [_leftBtn makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.centerX).offset(-70);
            make.bottom.equalTo(self.bottom).offset(-10);
            make.size.equalTo(CGSizeMake(22, 37));
        }];
        _rightBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_rightBtn addTarget:self action:@selector(rightBtnSelected) forControlEvents:(UIControlEventTouchUpInside)];
        [_rightBtn setImage:[UIImage imageNamed:@"btn_设置"] forState:UIControlStateNormal];
        [self addSubview:_rightBtn];
        [_rightBtn makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.centerX).offset(70);
            make.bottom.equalTo(self.bottom).offset(-10);
            make.size.equalTo(CGSizeMake(22, 37));
        }];
    }
    return self;
}
-(void)leftBtnSelected
{
    if(_columnBlock)
    {
        _columnBlock(self);
    }
}
-(void)rightBtnSelected
{
    if(_setBlock)
    {
        _setBlock(self);
    }
}
@end
