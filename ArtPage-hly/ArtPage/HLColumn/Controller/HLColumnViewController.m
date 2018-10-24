//
//  HLColumnViewController.m
//  ArtPage
//
//  Created by 何龙 on 2018/9/22.
//  Copyright © 2018年 何龙. All rights reserved.
//

#import "HLColumnViewController.h"
#import "HLSelectBtnView.h"
#import "HLindexViewController.h"
#import "HLAboutViewController.h"
#import "HLNewsListViewController.h"
#import "HLShareViewController.h"
@interface HLColumnViewController ()
@property (nonatomic, strong) HLSelectBtnView *btnView;
@end

@implementation HLColumnViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSString *shareAddress = @"http://www.artp.cc/Pages/User/login.aspx";
    KUserDefault(shareAddress, @"shareAddress");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWithFooterView:NO andHeaderView:NO andText:nil];
    [self jumpVC];
}
#pragma mark - 懒加载----------
-(HLSelectBtnView *)btnView
{
    if(!_btnView)
    {
        NSArray *imageArr = [NSArray arrayWithObjects:@"btn_公开作品", @"btn_非公开作品", @"btn_关于", @"btn_日志", @"btn_推送主页链接", @"btn_切换英文", nil];
        _btnView = [[HLSelectBtnView alloc] initWithFrame:CGRectZero andImageNameArr:imageArr];
//        _btnView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_btnView];
        [_btnView makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(0);
            make.bottom.equalTo(self.oneFooterView.top);
            make.size.equalTo(CGSizeMake(SCREENWIDTH, 170));
        }];
    }
    return _btnView;
}
-(void)jumpVC
{
    __weak typeof (self)weakSelf = self;
    self.btnView.block0 = ^(HLSelectBtnView *hlSelectBtnView) {
        NSLog(@"选中了公开作品");
        NSString *isShow = @"1";
        KUserDefault(isShow, @"isShow");
//        NSLog(@"gainshow = %@", gainUserDefault(@"isShow"));
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    self.btnView.block1 = ^(HLSelectBtnView *hlSelectBtnView) {
        NSLog(@"选中了非公开作品");
        NSString *isShow = @"2";
        KUserDefault(isShow, @"isShow");
//        NSLog(@"gainshow = %@", gainUserDefault(@"isShow"));
        [weakSelf.navigationController popViewControllerAnimated:YES];
        
    };
    self.btnView.block2 = ^(HLSelectBtnView *hlSelectBtnView) {
        NSLog(@"选中了关于界面");
        [weakSelf.navigationController pushViewController:[[HLAboutViewController alloc] init] animated:YES];
    };
    self.btnView.block3 = ^(HLSelectBtnView *hlSelectBtnView) {
        NSLog(@"选中了日志界面");
        NSString *isShow = @"日志";
        KUserDefault(isShow, @"isShow");
        [weakSelf.navigationController pushViewController:[[HLNewsListViewController alloc] init] animated:YES];
    };
    self.btnView.block4 = ^(HLSelectBtnView *hlSelectBtnView) {
        NSLog(@"选择了推送主页链接界面");
        [weakSelf.navigationController pushViewController:[[HLShareViewController alloc] init] animated:YES];
    };
}


@end
