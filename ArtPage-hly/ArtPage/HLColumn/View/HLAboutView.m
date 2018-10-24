//
//  HLAboutView.m
//  ArtPage
//
//  Created by 何龙 on 2018/9/26.
//  Copyright © 2018年 何龙. All rights reserved.
//

#import "HLAboutView.h"
#import "GetDataBase.h"
@implementation HLAboutView
-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        //从数据库中获取关于的信息
        NSMutableArray *objectArr = [[[GetDataBase shareDataBase] wzGainTableRecoderID:@"GetAboutModel"] objectAtIndex:0];
        NSString *title1 = nil;
        NSString *title2 = nil;
        NSString *title3 = nil;
        NSString *title4 = nil;
        NSString *title5 = nil;
        NSString *lastTitle = nil;
        if(![gainUserDefault(@"language") isEqualToString:@"English"])
        {
            title1 = [objectArr valueForKey:@"ARTIST_NAME_CN"];
            title2 = [objectArr valueForKey:@"ARTIST_ADDRESS_CN"];
            title3 = [objectArr valueForKey:@"GENDER_CN"];
            title4 = [objectArr valueForKey:@"TOOL_CN"];
            title5 = [objectArr valueForKey:@"ARTIST_EXPERTISE_CN"];
            lastTitle = [objectArr valueForKey:@"ARTIST_RESUME_CN"];
        }
        else
        {
            title1 = [objectArr valueForKey:@"ARTIST_NAME_EN"];
            title2 = [objectArr valueForKey:@"ARTIST_ADDRESS_EN"];
            title3 = [objectArr valueForKey:@"GENDER_EN"];
            title4 = [objectArr valueForKey:@"TOOL_EN"];
            title5 = [objectArr valueForKey:@"ARTIST_EXPERTISE_EN"];
            lastTitle = [objectArr valueForKey:@"ARTIST_RESUME_EN"];
        }
        //titleImage
        NSString *imageName = [objectArr valueForKey:@"ARTIST_IMAGE"];
        UIImage *image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/Library/Caches/%@", NSHomeDirectory(), imageName]];
        _titleImageView = [[UIImageView alloc] init];
        _titleImageView.backgroundColor = [UIColor whiteColor];
        [self.titleImageView setImage:image];
        [self addSubview:_titleImageView];
        [_titleImageView makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(20);
            make.top.equalTo(30);
            make.size.equalTo(CGSizeMake(115, 150));
        }];
        //commonLabel
        NSArray *titleArr1 = @[@"基本信息",@"工作经历"];
        NSArray *titleArr2 = @[@"真实姓名", @"所在区域", @"性别", @"创作工具", @"擅长领域", @"商业委托"];
        if([gainUserDefault(@"language") isEqualToString:@"English"])
        {
            titleArr1 = @[@"basic information", @"work experience"];
            titleArr2 = @[@"real name", @"area", @"sex", @"authoring tools", @"the field of expertise", @"entrust"];
        }
        NSArray *titleArr3 = @[title1, title2, title3, title4, title5, @"接受"];
        for(int i = 0; i < 2; i++)
        {
            _commonTitleLabel = [[UILabel alloc] init];
            _commonTitleLabel.font = HLFont(18);
            _commonTitleLabel.text = titleArr1[i];
            _commonTitleLabel.textColor = [UIColor grayColor];
            [self addSubview:_commonTitleLabel];
            [_commonTitleLabel makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(20);
                make.top.equalTo(self.titleImageView.bottom).offset(10 + i * 230);
                make.size.equalTo(CGSizeMake(SCREENWIDTH, 20));
            }];
            UILabel *lineLabel = [[UILabel alloc] init];
            lineLabel.backgroundColor = [UIColor grayColor];
            [self addSubview:lineLabel];
            [lineLabel makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(0);
                make.bottom.equalTo(self.commonTitleLabel.bottom).offset(5);
                make.size.equalTo(CGSizeMake(SCREENWIDTH, 1));
            }];
        }
        for(int j = 0; j < 6; j++)
        {
            UILabel *label = [[UILabel alloc] init];
            label.text = titleArr2[j];
            label.font = HLFont(13);
            label.textColor = [UIColor grayColor];
            [self addSubview:label];
            [label makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(20);
                make.top.equalTo(self.titleImageView.bottom).offset(50 + j * 30);
                make.size.equalTo(CGSizeMake(70, 20));
            }];
            _commonListLabel = [[UILabel alloc] init];
            _commonListLabel.font = HLFont(13);
            _commonListLabel.text = titleArr3[j];
            _commonListLabel.textColor = [UIColor grayColor];
            [self addSubview:_commonListLabel];
            [_commonListLabel makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(100);
                make.top.equalTo(self.titleImageView.bottom).offset(50 + j * 30);
                make.size.equalTo(CGSizeMake(SCREENWIDTH - 100, 20));
            }];
        }
        UILabel *contentLabel = [[UILabel alloc] init];
        contentLabel.numberOfLines = 0;
        contentLabel.text = lastTitle;
        contentLabel.textColor = [UIColor grayColor];
        [self addSubview:contentLabel];
        [contentLabel makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(20);
            make.top.equalTo(self.commonTitleLabel.bottom).offset(20);
            make.size.equalTo(CGSizeMake(SCREENWIDTH - 40, 150));
        }];
    }
    return self;
}

@end
