//
//  HLImageHeaderView.m
//  ArtPage
//
//  Created by 何龙 on 2018/9/19.
//  Copyright © 2018年 何龙. All rights reserved.
//

#import "HLImageHeaderView.h"

@implementation HLImageHeaderView

-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        _imageView = [[UIImageView alloc] init];
        _imageView.image = [UIImage imageNamed:@"share"];
        [self addSubview:_imageView];
        [_imageView makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.left);
            make.top.equalTo(self.top).offset(0);
            make.size.equalTo(CGSizeMake(120, 120));
        }];
    }
    return self;
}
@end
