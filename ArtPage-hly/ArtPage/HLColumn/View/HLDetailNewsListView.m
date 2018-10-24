//
//  HLDetailNewsListView.m
//  ArtPage
//
//  Created by 何龙 on 2018/9/26.
//  Copyright © 2018年 何龙. All rights reserved.
//

#import "HLDetailNewsListView.h"
#import "GetDataBase.h"
@implementation HLDetailNewsListView
-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:1];
        NSDictionary *dic = @{@"ID":gainUserDefault(@"NewsListID")};
        arr = [[GetDataBase shareDataBase] wzGetRecorderDataForTwoWithTableName:@"NewsListModel" andDicitonary:dic];
        NSLog(@"arr = %@", arr);
        NSString *text = [[arr objectAtIndex:0] valueForKey:@"NAME_CN"];
        NSString *content = [[arr objectAtIndex:0] valueForKey:@"CONTENT_CN"];
        if([gainUserDefault(@"language") isEqualToString:@"English"])
        {
            text = [[arr objectAtIndex:0] valueForKey:@"NAME_EN"];
            content = [[arr objectAtIndex:0] valueForKey:@"CONTENT_EN"];
        }
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = text;
        _titleLabel.font = HLFont(18);
        _titleLabel.numberOfLines = 0;
        _titleLabel.textColor = [UIColor grayColor];
        [self addSubview:_titleLabel];
        [_titleLabel makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(25);
            make.top.equalTo(self.top);
            make.size.equalTo(CGSizeMake(SCREENWIDTH - 50, 80));
        }];
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.text= [[arr objectAtIndex:0] valueForKey:@"LASTUPDATEDATE"];
        _timeLabel.textColor = [UIColor grayColor];
        _timeLabel.font = HLFont(10.5);
        [self addSubview:_timeLabel];
        [_timeLabel makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(25);
            make.top.equalTo(self.titleLabel.bottom);
            make.size.equalTo(CGSizeMake(SCREENWIDTH - 50, 11));
        }];
        
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.textColor = [UIColor grayColor];
        _contentLabel.font = HLFont(12);
        _contentLabel.numberOfLines = 0;
        _contentLabel.attributedText = [self gainAttritube:content];
        [self addSubview:_contentLabel];
        /*
         1、自适应尺寸，根据宽度算高度
         2、自适应设置，以矩形区域自适应，以字体字型自适应
         3、文字属性，需要知道字体大小
         4、上下文
         MAXFLOAT 是一个大数,因为高度能高不能低
         */
        CGSize contentSize = [content boundingRectWithSize:CGSizeMake(SCREENWIDTH - 50, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                            attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0]} context:nil].size;
        //contentSize 去自适应_contentLabel
        CGSize size = [_contentLabel sizeThatFits:contentSize];
        
        [_contentLabel makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(25);
            make.top.equalTo(self.timeLabel.bottom).offset(20);
            make.size.equalTo(CGSizeMake(SCREENWIDTH - 50, size.height));
        }];
        //位置固定
        [self layoutIfNeeded];
    }
    return self;
}
-(NSMutableAttributedString *)gainAttritube:(NSString *)str
{
    //HTML文本转换
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[str dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithAttributedString:attrStr];
    [attributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, attrStr.length)];
    return attributedStr;
}

@end
