//
//  HLAboutViewController.m
//  ArtPage
//
//  Created by 何龙 on 2018/9/26.
//  Copyright © 2018年 何龙. All rights reserved.
//

#import "HLAboutViewController.h"
#import "HLAboutView.h"
@interface HLAboutViewController ()
@property (nonatomic, strong) UIScrollView *scorllView;
@property (nonatomic, strong) HLAboutView *aboutView;
@end

@implementation HLAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWithFooterView:NO andHeaderView:YES andText:@"关于"];
    [self initHLaboutView];
}
-(UIScrollView *)scorllView
{
    if(!_scorllView)
    {
        _scorllView = [[UIScrollView alloc] init];
        [self.view addSubview:_scorllView];
        [_scorllView makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(0);
            make.top.equalTo(self.titleHeaderView.bottom);
            make.size.equalTo(CGSizeMake(SCREENWIDTH, SCREENHEIGHT - 64 - 70));
        }];
        _scorllView.contentSize = CGSizeMake(SCREENWIDTH, SCREENHEIGHT);
    }
    return _scorllView;
}
-(void)initHLaboutView
{
    _aboutView = [[HLAboutView alloc] init];
    [self.scorllView addSubview:_aboutView];
    [_aboutView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.top.equalTo(0);
        make.size.equalTo(CGSizeMake(SCREENWIDTH, 400));
    }];
}

@end
