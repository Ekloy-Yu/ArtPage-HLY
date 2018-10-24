//
//  HLTitleHeaderView.m
//  ArtPage
//
//  Created by 何龙 on 2018/9/19.
//  Copyright © 2018年 何龙. All rights reserved.
//

#import "HLTitleHeaderView.h"

@implementation HLTitleHeaderView

-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"USERNAME";
        _titleLabel.textColor = [UIColor grayColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = HLFont(24);
        [self addSubview:_titleLabel];
        [_titleLabel makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.center);
            make.size.equalTo(CGSizeMake(SCREENWIDTH, 24));
        }];
    }
    return self;
}

@end
