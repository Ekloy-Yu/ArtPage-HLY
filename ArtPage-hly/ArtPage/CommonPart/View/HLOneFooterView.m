//
//  HLOneFooterView.m
//  ArtPage
//
//  Created by 何龙 on 2018/9/19.
//  Copyright © 2018年 何龙. All rights reserved.
//

#import "HLOneFooterView.h"

@implementation HLOneFooterView

-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.alpha = 0.7;
        _footerBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_footerBtn setImage:[UIImage imageNamed:@"btn_关闭"] forState:(UIControlStateNormal)];
        [_footerBtn addTarget:self action:@selector(btnSelected) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:_footerBtn];
        [_footerBtn makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.center);
            make.size.equalTo(CGSizeMake(22, 37));
        }];
    }
    return self;
}
-(void)btnSelected
{
    if(_Block)
    {
        _Block(self);
    }
}
@end
