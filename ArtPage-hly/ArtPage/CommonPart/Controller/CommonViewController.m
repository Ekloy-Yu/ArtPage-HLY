//
//  CommonViewController.m
//  ArtPage
//
//  Created by 何龙 on 2018/9/19.
//  Copyright © 2018年 何龙. All rights reserved.
//

#import "CommonViewController.h"

@interface CommonViewController ()

@end

@implementation CommonViewController
// 支持设备自动旋转
- (BOOL)shouldAutorotate
{
    return NO;
}

// 支持竖屏显示
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = HLColor(30, 30, 30);
}
//一个button按钮的底部
-(HLOneFooterView *)oneFooterView
{
    if(!_oneFooterView)
    {
        _oneFooterView = [[HLOneFooterView alloc] init];
        _oneFooterView.alpha = 0.7;
        [self.view addSubview:_oneFooterView];
        [_oneFooterView makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.equalTo(0);
            make.size.equalTo(CGSizeMake(SCREENWIDTH, 70));
        }];
    }
    return _oneFooterView;
}
//两个button按钮的底部
-(HLTwoFooterView *)twoFooterView
{
    if(!_twoFooterView)
    {
        _twoFooterView = [[HLTwoFooterView alloc] init];
        _oneFooterView.alpha = 0.7;
        [self.view addSubview:_twoFooterView];
        [_twoFooterView makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(0);
            make.bottom.equalTo(self.view.bottom).offset(0);
            make.size.equalTo(CGSizeMake(SCREENWIDTH, 74));
        }];
    }
    return _twoFooterView;
}
//title文字的头部
-(HLTitleHeaderView *)titleHeaderView
{
    if(!_titleHeaderView)
    {
        _titleHeaderView = [[HLTitleHeaderView alloc] init];
        _titleHeaderView.alpha = 0.7;
        [self.view addSubview:_titleHeaderView];
        [_titleHeaderView makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(0);
            make.top.equalTo(self.view.top).offset(0);
            make.size.equalTo(CGSizeMake(SCREENWIDTH, 64));
        }];
    }
    return _titleHeaderView;
}
//ImageHeader
-(HLImageHeaderView *)imageHeaderView
{
    if(!_imageHeaderView)
    {
        _imageHeaderView = [[HLImageHeaderView alloc] init];
        [self.view addSubview:_imageHeaderView];
        [_imageHeaderView makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(20);
            make.top.equalTo(self.view.top).offset(0);
            make.size.equalTo(CGSizeMake(SCREENWIDTH, 120));
        }];
//        UILabel *lineLabel = [[UILabel alloc] init];
//        lineLabel.backgroundColor = [UIColor grayColor];
//        [self.view addSubview:lineLabel];
//        [lineLabel makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(0);
//            make.top.equalTo(self.imageHeaderView.bottom);
//            make.size.equalTo(CGSizeMake(SCREENWIDTH, 1));
//        }];
    }
    return _imageHeaderView;
}
-(void)initWithFooterView:(BOOL)i andHeaderView:(BOOL)j andText:(NSString *)text
{
    if(i == YES)
    {
        self.titleHeaderView.titleLabel.text = text;
        self.twoFooterView.hidden = NO;
        
    }
    else
    {
        self.oneFooterView.hidden = NO;
        __weak typeof (self)weakSelf = self;
        self.oneFooterView.Block = ^(HLOneFooterView *oneFooterView) {
            if([gainUserDefault(@"登录状态") isEqualToString:@"已登录"])
            {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }
            else
            {
                [weakSelf dismissViewControllerAnimated:YES completion:nil];
            }
        };
        if(j == YES)
        {
            self.titleHeaderView.titleLabel.text = text;
        }
        else
        {
            self.imageHeaderView.hidden = NO;
        }
    }
}


@end
