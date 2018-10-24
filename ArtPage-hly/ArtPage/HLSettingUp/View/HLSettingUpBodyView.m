//
//  HLSettingUpBodyView.m
//  ArtPage
//
//  Created by 何龙 on 2018/9/22.
//  Copyright © 2018年 何龙. All rights reserved.
//

#import "HLSettingUpBodyView.h"

@implementation HLSettingUpBodyView

-(id)initWithFrame:(CGRect)frame andContentArr:(NSArray *)arr
{
    if(self = [super initWithFrame:frame])
    {
        NSArray *titleArr = [NSArray arrayWithObjects:@"当前用户", @"个性域名", @"账户类型", @"账户有效期", @"上一次同步时间", nil];
        //设置label
        for(int i = 0; i < 5; i++)
        {
            _titleLabel = [[UILabel alloc] init];
            _titleLabel.text = titleArr[i];
            _titleLabel.textColor = [UIColor grayColor];
            [self addSubview:_titleLabel];
            [_titleLabel makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(20);
                make.top.equalTo(10 + i * 35);
                make.size.equalTo(CGSizeMake(SCREENWIDTH / 2 - 30, 30));
            }];
            _contentLabel = [[UILabel alloc] init];
            _contentLabel.text = arr[i];
            _contentLabel.textColor = [UIColor grayColor];
            [self addSubview:_contentLabel];
            [_contentLabel makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(SCREENWIDTH / 2);
                make.top.equalTo(10 + i * 35);
                make.size.equalTo(CGSizeMake(SCREENWIDTH / 2 - 30, 30));
            }];
        }
        UILabel *lineLabel = [[UILabel alloc] init];
        lineLabel.backgroundColor = [UIColor grayColor];
        [self addSubview:lineLabel];
        [lineLabel makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(0);
            make.top.equalTo(self.contentLabel.bottom).offset(20);
            make.size.equalTo(CGSizeMake(SCREENWIDTH, 1));
        }];
        UILabel *lineLabel2 = [[UILabel alloc] init];
        lineLabel2.backgroundColor = [UIColor grayColor];
        [self addSubview:lineLabel2];
        [lineLabel2 makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(0);
            make.top.equalTo(self.top).offset(0);
            make.size.equalTo(CGSizeMake(SCREENWIDTH, 1));
        }];
    }
    return self;
}

@end
