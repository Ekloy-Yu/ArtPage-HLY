//
//  HLBottomView.m
//  ArtPage
//
//  Created by 何龙 on 2018/10/8.
//  Copyright © 2018年 何龙. All rights reserved.
//

#import "HLBottomView.h"

@implementation HLBottomView

-(id)initWithFrame:(CGRect)frame
        titleLabel:(NSString *)titleText
      contentLabel:(NSString *)contentText
             width:(CGFloat)width
{
    if(self = [super initWithFrame:frame])
    {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = titleText;
        _titleLabel.font = HLFont(18);
        _titleLabel.textColor = [UIColor grayColor];
        [self addSubview:_titleLabel];
        [_titleLabel makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(30);
            make.top.equalTo(0);
            make.size.equalTo(CGSizeMake(width - 60, 20));
        }];
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.text = contentText;
        _contentLabel.font = HLFont(12);
        _contentLabel.numberOfLines = 0;
        _contentLabel.textColor = [UIColor grayColor];
        [self addSubview:_contentLabel];
        [_contentLabel makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(30);
            make.top.equalTo(self.titleLabel.bottom).offset(10);
            make.size.equalTo(CGSizeMake(width - 60, 70));
        }];
        _saveBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_saveBtn setImage:[UIImage imageNamed:@"btn_返回"] forState:(UIControlStateNormal)];
        [_saveBtn addTarget:self action:@selector(backBtnSelected) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:_saveBtn];
        [_saveBtn makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.centerX).offset(-50);
            make.bottom.equalTo(self.bottom);
            make.size.equalTo(CGSizeMake(22, 35));
        }];
        _backBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_backBtn setImage:[UIImage imageNamed:@"btn_保存至相册"] forState:(UIControlStateNormal)];
        [_backBtn addTarget:self action:@selector(saveBtnSelected) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:_backBtn];
        [_backBtn makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.centerX).offset(50);
            make.bottom.equalTo(self.bottom);
            make.size.equalTo(CGSizeMake(22, 35));
        }];
    }
    return self;
}
-(void)saveBtnSelected
{
    if(_saveBlock)
    {
        _saveBlock(self);
    }
}
-(void)backBtnSelected
{
    if(_block)
    {
        _block(self);
    }
}
@end
