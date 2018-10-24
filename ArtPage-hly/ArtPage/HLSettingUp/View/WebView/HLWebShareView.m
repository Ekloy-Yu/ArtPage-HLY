//
//  HLWebShareView.m
//  ArtPage
//
//  Created by 何龙 on 2018/10/13.
//  Copyright © 2018 何龙. All rights reserved.
//

#import "HLWebShareView.h"
#import "UIButton+UIButton_Category.h"
@implementation HLWebShareView
-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        UILabel *backLabel = [[UILabel alloc] init];
        backLabel.backgroundColor = HLColor(241, 241, 244);
        [self addSubview:backLabel];
        [backLabel makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(0);
            make.right.equalTo(0);
            make.top.equalTo(self.centerY).offset(0);
            make.bottom.equalTo(self.bottom);
        }];
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = @"分享到";
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [UIColor grayColor];
        titleLabel.userInteractionEnabled = YES;
        titleLabel.font = HLFont(13);
        [self addSubview:titleLabel];
        [titleLabel makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(0);
            make.top.equalTo(self.centerY).offset(10);
            make.size.equalTo(CGSizeMake(SCREENWIDTH, 30));
        }];
        [self initScrollView];
        NSArray *arr = @[@"收藏",
                         @"发送至电脑",
                         @"复制链接",
                         @"举报"];
        for(int i = 0; i < 4; i++)
        {
            UIButton *btn2 = [UIButton buttonWithType:(UIButtonTypeCustom)];
            btn2.frame = CGRectMake(0, 0, 70, 100);
            [btn2 setBackgroundColor:[UIColor whiteColor] image:[NSString stringWithFormat:@"%d", i + 1] text:arr[i]];
            [self addSubview:btn2];
            [btn2 makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(10 + 80 * i);
                make.top.equalTo(self.scrollView.bottom).offset(10);
                make.size.equalTo(CGSizeMake(70, 100));
            }];
        }
    }
    return self;
}
-(void)initScrollView
{
    UIScrollView *scroll = [[UIScrollView alloc] init];
    scroll.pagingEnabled = YES;
    scroll.showsHorizontalScrollIndicator = NO;
    
    scroll.contentSize = CGSizeMake(SCREENWIDTH  + 120, 130);
    [self addSubview:scroll];
    [scroll makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.top.equalTo(self.centerY).offset(30);
        make.size.equalTo(CGSizeMake(SCREENWIDTH, 130));
    }];
    _scrollView = scroll;
    [self initBtns];
}
-(void)initBtns
{
    NSArray *imageArr = @[@"1",
                          @"2",
                          @"3",
                          @"4",
                          @"5",
                          @"6"];
    NSArray *titleArr = @[@"好友",
                          @"QQ空间",
                          @"微信",
                          @"朋友圈",
                          @"音乐",
                          @"位置"];
    for(int i = 0; i < 6; i++)
    {
        UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        btn.frame = CGRectMake(0, 0, 70, 100);
        [btn setBackgroundColor:[UIColor redColor] image:imageArr[i] text:titleArr[i]];
        [_scrollView addSubview:btn];
        [btn makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.scrollView.left).offset(10 + 80 * i);
            make.top.equalTo(self.scrollView.top).offset(10);
            make.size.equalTo(CGSizeMake(70, 100));
        }];
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self removeFromSuperview];
}
@end
