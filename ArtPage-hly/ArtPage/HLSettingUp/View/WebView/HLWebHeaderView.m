//
//  HLWebHeaderView.m
//  ArtPage
//
//  Created by 何龙 on 2018/10/11.
//  Copyright © 2018 何龙. All rights reserved.
//

#import "HLWebHeaderView.h"

@implementation HLWebHeaderView

-(id)initWithFrame:(CGRect)frame
             title:(NSString *)text
{
    if(self = [super initWithFrame:frame])
    {
        self.backgroundColor = HLColor(216, 38, 38);
        self.alpha = 0.88;
        UIButton *backBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [backBtn setImage:[UIImage imageNamed:@"箭头"] forState:(UIControlStateNormal)];
        [backBtn addTarget:self action:@selector(back) forControlEvents:(UIControlEventTouchUpInside)];
        backBtn.frame = CGRectMake(10, 20, 16, 18);
        [self addSubview:backBtn];
        self.leftBtn = backBtn;
        
        UIButton *refreshBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [refreshBtn setImage:[UIImage imageNamed:@"详情按钮"] forState:(UIControlStateNormal)];
        [refreshBtn addTarget:self action:@selector(refresh) forControlEvents:(UIControlEventTouchUpInside)];
        refreshBtn.frame = CGRectMake(SCREENWIDTH - 33, 20, 23, 23);
        [self addSubview:refreshBtn];
        self.rightBtn = refreshBtn;
        
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, 20, SCREENWIDTH - 80, 20)];
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"正在请求ArtPage官网";
        label.adjustsFontSizeToFitWidth = YES;
        label.minimumScaleFactor = 5;
        label.font = HLFont(18);
        [self addSubview:label];
        _urlLabel = label;
        
    }
    return self;
}
-(void)back
{
    if(_backBlock)
    {
        _backBlock(self);
    }
}
-(void)refresh
{
   
    if(_refreshBlock)
    {
        _refreshBlock(self);
    }
}
@end
