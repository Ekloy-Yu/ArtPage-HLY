//
//  HLSetUpColumnViewController.m
//  ArtPage
//
//  Created by 何龙 on 2018/9/26.
//  Copyright © 2018年 何龙. All rights reserved.
//

#import "HLSetUpColumnViewController.h"
#import "HLSetUpColumnView.h"
@interface HLSetUpColumnViewController ()
@property (nonatomic, strong) HLSetUpColumnView *setUpColumnView;
@end

@implementation HLSetUpColumnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWithFooterView:NO andHeaderView:NO andText:nil];
    [self initSetUpColumnView];
}
-(void)initSetUpColumnView
{
    _setUpColumnView = [[HLSetUpColumnView alloc] init];
    [self.view addSubview:_setUpColumnView];
    [_setUpColumnView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.top.equalTo(self.imageHeaderView.bottom);
        make.size.equalTo(CGSizeMake(SCREENWIDTH, SCREENHEIGHT - 64 - 120));
    }];
}


@end
