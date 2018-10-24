//
//  HLSettingUpViewController.m
//  ArtPage
//
//  Created by 何龙 on 2018/9/22.
//  Copyright © 2018年 何龙. All rights reserved.
//

#import "HLSettingUpViewController.h"
#import "HLSelectBtn2View.h"
#import "HLSettingUpBodyView.h"
#import "HLAboutArtPageViewController.h"
#import "HLDownloadViewController.h"
#import "HLSetUpColumnViewController.h"
#import "ViewController.h"
#import "HLWebViewController.h"
@interface HLSettingUpViewController ()
@property (nonatomic, strong) HLSelectBtn2View *btnView;
@property (nonatomic, strong) HLSettingUpBodyView *bodyView;
@end

@implementation HLSettingUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWithFooterView:NO andHeaderView:NO andText:nil];
    [self jumpVC];
    self.bodyView.hidden = NO;
}
#pragma mark - 懒加载----------
-(HLSelectBtn2View *)btnView
{
    if(!_btnView)
    {
        NSArray *imageArr = [NSArray arrayWithObjects:@"btn_同步数据", @"btn_变更账户", @"btn_栏目设定", @"btn_访问网页版", @"", @"btn_关于ArtPage", nil];
        _btnView = [[HLSelectBtn2View alloc] initWithFrame:CGRectZero andImageNameArr:imageArr];
        [self.view addSubview:_btnView];
        [_btnView makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(0);
            make.bottom.equalTo(self.oneFooterView.top).offset(-30);
            make.size.equalTo(CGSizeMake(SCREENWIDTH, 170));
        }];
    }
    return _btnView;
}
-(HLSettingUpBodyView *)bodyView
{
    if(!_bodyView)
    {
        NSString *userName =gainUserDefault(@"userName");
        NSString *url = [userName stringByAppendingString:@".artp.cc"];
        NSString *endDate =gainUserDefault(@"endDate");
        NSString *lastDate = gainUserDefault(@"lastDate");
        NSArray *arr = [NSArray arrayWithObjects:userName, url, @"正式版", endDate, lastDate, nil];
        _bodyView = [[HLSettingUpBodyView alloc] initWithFrame:CGRectZero andContentArr:arr];
        [self.view addSubview:_bodyView];
        [_bodyView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.imageHeaderView.bottom);
            make.left.equalTo(0);
            make.size.equalTo(CGSizeMake(SCREENWIDTH, 250));
        }];
    }
    return _bodyView;
}
-(void)jumpVC
{
    __weak typeof (self)weakSelf = self;
    self.btnView.block0 = ^(HLSelectBtn2View *hlSelectBtnView) {
        NSLog(@"正在跳转至同步数据页面");
        
        [weakSelf.navigationController pushViewController:[[HLDownloadViewController alloc] init] animated:YES];
    };
    self.btnView.block1 = ^(HLSelectBtn2View *hlSelectBtnView) {
        NSString *login = @"已登录";
        KUserDefault(login, @"登录状态");
        NSLog(@"正在进入变更账户页面");
        [weakSelf.navigationController pushViewController:[[ViewController alloc] init] animated:YES];
    };
    self.btnView.block2 = ^(HLSelectBtn2View *hlSelectBtnView) {
        NSLog(@"正在跳转栏目设定页面");
        [weakSelf.navigationController pushViewController:[[HLSetUpColumnViewController alloc] init] animated:YES];
    };
    self.btnView.block3 = ^(HLSelectBtn2View *hlSelectBtnView) {
        NSLog(@"正在准备访问网页版");
        [weakSelf.navigationController pushViewController:[[HLWebViewController alloc] init] animated:YES];
    };
    self.btnView.block5 = ^(HLSelectBtn2View *hlSelectBtnView) {
        NSLog(@"正在跳转至关于artPage页面");
        [weakSelf.navigationController pushViewController:[[HLAboutArtPageViewController alloc] init] animated:YES];
        
    };
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
