//
//  HLAboutArtPageView.m
//  ArtPage
//
//  Created by 何龙 on 2018/9/23.
//  Copyright © 2018年 何龙. All rights reserved.
//

#import "HLAboutArtPageView.h"

@implementation HLAboutArtPageView
-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        NSArray *textArr = [NSArray arrayWithObjects:@"当前版本号 1.0", @"介绍\nArtPage,让作品展示与商业合作更加简单。\niPhone版ArtPage,可”一键式同步“用户在Web端的数据，以便使用者在离线状态也能够浏览作品与履历。", @"意见反馈\n邮箱: vip@artp.cc\nQQ:2757388400", @"网址:http://www.artp.cc", nil];
        float orignY = 20;
        for(int i = 0; i < 4; i++)
        {
            _commonLabel = [[UILabel alloc] init];
            CGSize titleSize = [textArr[i] sizeWithFont:[UIFont systemFontOfSize:18] constrainedToSize:CGSizeMake(SCREENWIDTH - 40, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
            _commonLabel.numberOfLines = 0;
            
            _commonLabel.textColor = [UIColor grayColor];
            [self addSubview:_commonLabel];
            [_commonLabel makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(20);
                make.top.equalTo(orignY);
                make.size.equalTo(CGSizeMake(SCREENWIDTH - 40, titleSize.height + 30));
            }];
            _commonLabel.attributedText = [self setLabelGapWithStr:textArr[i] andGap:10];
            [_commonLabel sizeToFit];
            orignY+=titleSize.height + 50;
            
            //分割线
            UILabel *lineLabel = [[UILabel alloc] init];
            lineLabel.backgroundColor = [UIColor grayColor];
            [self addSubview:lineLabel];
            [lineLabel makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(0);
                make.top.equalTo(self.commonLabel.top).offset(-10);
                make.size.equalTo(CGSizeMake(SCREENWIDTH, 1));
            }];
        }
        UILabel *lineLabel = [[UILabel alloc] init];
        lineLabel.backgroundColor = [UIColor grayColor];
        [self addSubview:lineLabel];
        [lineLabel makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(0);
            make.top.equalTo(self.commonLabel.bottom).offset(10);
            make.size.equalTo(CGSizeMake(SCREENWIDTH, 1));
        }];
    }
    return self;
}
-(NSMutableAttributedString *)setLabelGapWithStr:(id)labelStr andGap:(float)gamNum
{
    //设置行间距
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelStr];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:gamNum];//调整行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelStr length])];
    return attributedString;
}
@end
