//
//  HLSetUpColumnView.m
//  ArtPage
//
//  Created by 何龙 on 2018/9/26.
//  Copyright © 2018年 何龙. All rights reserved.
//

#import "HLSetUpColumnView.h"

@implementation HLSetUpColumnView
-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor grayColor];
        _titleLabel.numberOfLines = 0;
        _titleLabel.text = @"栏目设定|在这里,您可以暂时停用导航中的某些栏目,以应对不同的展示需求.停用后栏目内容不会被删除。";
        _titleLabel.font = HLFont(18);
        [self addSubview:_titleLabel];
        [_titleLabel makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(20);
            make.top.equalTo(0);
            make.size.equalTo(CGSizeMake(SCREENWIDTH - 40, 100));
        }];
        for(int i = 0; i < 2; i++)
        {
            UILabel *lineLabel = [[UILabel alloc] init];
            lineLabel.backgroundColor = [UIColor grayColor];
            [self addSubview:lineLabel];
            [lineLabel makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(0);
                make.top.equalTo(0 + i * 100);
                make.size.equalTo(CGSizeMake(SCREENHEIGHT, 1));
            }];
        }
        NSArray *textArr = @[@"公开作品", @"非公开作品", @"日志", @"关于"];
        for(int i = 0; i < 4; i++)
        {
            _commonImageView = [[UIImageView alloc] init];
            _commonImageView.image = [UIImage imageNamed:textArr[i]];
            [self addSubview:_commonImageView];
            [_commonImageView makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(20);
                make.top.equalTo(self.titleLabel.bottom).offset(i * 53 + 18);
                make.size.equalTo(CGSizeMake(25, 25));
            }];
            _commonLabel = [[UILabel alloc] init];
            _commonLabel.text = textArr[i];
            _commonLabel.textColor = [UIColor grayColor];
            _commonLabel.font = HLFont(18);
            [self addSubview:_commonLabel];
            [_commonLabel makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.commonImageView.right).offset(8);
                make.top.equalTo(self.titleLabel.bottom).offset(i * 53 + 20.5);
                make.size.equalTo(CGSizeMake(100, 18));
            }];
            UILabel *lineLabel = [[UILabel alloc] init];
            lineLabel.backgroundColor = [UIColor grayColor];
            [self addSubview:lineLabel];
            [lineLabel makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(0);
                make.top.equalTo(self.commonLabel.bottom).offset(20);
                make.size.equalTo(CGSizeMake(SCREENHEIGHT, 1));
            }];
            //添加btn
            UIButton *commonBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
            [commonBtn setImage:[UIImage imageNamed:@"btn.selected"] forState:(UIControlStateNormal)];
            [commonBtn setImage:[UIImage imageNamed:@"btn.nomal"] forState:(UIControlStateSelected)];
            commonBtn.tag = i;
            [commonBtn addTarget:self action:@selector(btnSelected:) forControlEvents:(UIControlEventTouchUpInside)];
            [self addSubview:commonBtn];
            [commonBtn makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(-20);
                make.centerY.equalTo(self.commonLabel.centerY);
                make.size.equalTo(CGSizeMake(40, 25));
            }];
            if(i == 0)
            {
                if([gainUserDefault(@"公开作品栏目设定") isEqualToString:@"YES"])
                {
                    commonBtn.selected = YES;
                }
            }
            else if(i == 1)
            {
                if([gainUserDefault(@"非公开作品栏目设定") isEqualToString:@"YES"])
                {
                    commonBtn.selected = YES;
                }
            }
            else if(i == 2)
            {
                if([gainUserDefault(@"日志栏目设定") isEqualToString:@"YES"])
                {
                    commonBtn.selected = YES;
                }
            }
            else
            {
                if([gainUserDefault(@"关于栏目设定") isEqualToString:@"YES"])
                {
                    commonBtn.selected = YES;
                }
            }
        }
    }
    return self;
}
#pragma arguments btnSelected
-(void)btnSelected:(UIButton *)btn
{
    NSString *str1 = @"YES";
    NSString *str2 = @"NO";
    switch (btn.tag) {
        case 0:
            if(btn.selected)
            {
                btn.selected = NO;
                NSLog(@"公开作品显示");
                KUserDefault(str2, @"公开作品栏目设定");
            }
            else
            {
                btn.selected = YES;
                NSLog(@"公开作品隐藏");
                KUserDefault(str1, @"公开作品栏目设定");
            }
            break;
        case 1:
            if(btn.selected)
            {
                btn.selected = NO;
                NSLog(@"非公开作品显示");
                KUserDefault(str2, @"非公开作品栏目设定");
            }
            else
            {
                btn.selected = YES;
                NSLog(@"非公开作品隐藏");
                KUserDefault(str1, @"非公开作品栏目设定");
            }
            break;
        case 2:
            if(btn.selected)
            {
                btn.selected = NO;
                NSLog(@"日志显示");
                KUserDefault(str2, @"日志栏目设定");
            }
            else
            {
                btn.selected = YES;
                NSLog(@"日志隐藏");
                KUserDefault(str1, @"日志栏目设定");
            }
            break;
        case 3:
            if(btn.selected)
            {
                btn.selected = NO;
                NSLog(@"关于显示");
                KUserDefault(str2, @"关于栏目设定");
            }
            else
            {
                btn.selected = YES;
                NSLog(@"关于隐藏");
                KUserDefault(str1, @"关于栏目设定");
            }
            break;
            
        default:
            break;
    }
}
@end
