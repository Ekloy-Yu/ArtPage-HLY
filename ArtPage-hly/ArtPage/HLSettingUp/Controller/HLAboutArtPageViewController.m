//
//  HLAboutArtPageViewController.m
//  ArtPage
//
//  Created by 何龙 on 2018/9/23.
//  Copyright © 2018年 何龙. All rights reserved.
//

#import "HLAboutArtPageViewController.h"
#import "HLAboutArtPageView.h"
@interface HLAboutArtPageViewController ()
@property (nonatomic, strong) HLAboutArtPageView *aboutArtPageView;
@end

@implementation HLAboutArtPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWithFooterView:NO andHeaderView:NO andText:nil];
    [self initAboutArtPageView];
    // Do any additional setup after loading the view.
}

-(void)initAboutArtPageView
{
    _aboutArtPageView = [[HLAboutArtPageView alloc] init];
    [self.view addSubview:_aboutArtPageView];
    [_aboutArtPageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.top.equalTo(self.imageHeaderView.bottom);
        make.size.equalTo(CGSizeMake(SCREENWIDTH, SCREENHEIGHT - 200));
    }];
}


@end
