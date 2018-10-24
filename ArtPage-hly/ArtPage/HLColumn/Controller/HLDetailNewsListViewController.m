//
//  HLDetailNewsListViewController.m
//  ArtPage
//
//  Created by 何龙 on 2018/9/26.
//  Copyright © 2018年 何龙. All rights reserved.
//

#import "HLDetailNewsListViewController.h"
#import "HLDetailNewsListView.h"
@interface HLDetailNewsListViewController ()
@property (nonatomic, strong) HLDetailNewsListView *detailListView;
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation HLDetailNewsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWithFooterView:NO andHeaderView:YES andText:@"日志详情"];
    [self initDetailListView];
}
-(UIScrollView *)scrollView
{
    if(!_scrollView)
    {
        _scrollView = [[UIScrollView alloc] init];
        [self.view addSubview:_scrollView];
        [_scrollView makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(0);
            make.top.equalTo(self.titleHeaderView.bottom);
            make.size.equalTo(CGSizeMake(SCREENWIDTH, SCREENHEIGHT - 64 - 70));
        }];
    }
    return _scrollView;
}
-(void)initDetailListView
{
    _detailListView = [[HLDetailNewsListView alloc] init];
    [self.scrollView addSubview:_detailListView];
    float height = self.detailListView.contentLabel.frame.origin.y + self.detailListView.contentLabel.frame.size.height;
    [_detailListView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.top.equalTo(0);
        make.size.equalTo(CGSizeMake(SCREENWIDTH, height));
    }];
    self.scrollView.contentSize = CGSizeMake(SCREENWIDTH, height);
}



@end
