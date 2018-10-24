//
//  HLDownLoadContentView.m
//  ArtPage
//
//  Created by 何龙 on 2018/9/20.
//  Copyright © 2018年 何龙. All rights reserved.
//

#import "HLDownLoadContentView.h"

@implementation HLDownLoadContentView
-(NSMutableAttributedString *)setLabelGapWithStr:(id)labelStr andGap:(float)gamNum
{
    //设置行间距
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelStr];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:gamNum];//调整行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelStr length])];
    return attributedString;
}
-(id)initWithFrame:(CGRect)frame andStr:(NSString *)str
{
    if (self = [super initWithFrame:frame])
    {
        CGSize titleSize = [str sizeWithFont:[UIFont systemFontOfSize:18] constrainedToSize:CGSizeMake(SCREENWIDTH - 40, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 54, SCREENWIDTH - 40, titleSize.height)];
        _contentLabel.backgroundColor = [UIColor clearColor];
        _contentLabel.font = [UIFont systemFontOfSize:18];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.numberOfLines = 0;
        _contentLabel.textColor = [UIColor grayColor];
        _contentLabel.attributedText = [self setLabelGapWithStr:str andGap:15];
        [self addSubview:_contentLabel];
        [_contentLabel sizeToFit];
    
        UILabel *lineLabel = [[UILabel alloc] init];
        lineLabel.backgroundColor = [UIColor grayColor];
        [self addSubview:lineLabel];
        [lineLabel makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(0);
            make.top.equalTo(self.contentLabel.bottom).offset(10);
            make.size.equalTo(CGSizeMake(SCREENWIDTH, 1));
        }];
    }
    
    return self;
}

@end
