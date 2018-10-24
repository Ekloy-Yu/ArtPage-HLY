//
//  HLAlertView.m
//  ArtPage
//
//  Created by 何龙 on 2018/10/20.
//  Copyright © 2018 何龙. All rights reserved.
//

#import "HLAlertView.h"

@implementation HLAlertView{
    UIActivityIndicatorView *_activityView;
    CALayer *_arrowLayer;
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor whiteColor];
        //圆点的动画
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleGray)];
        
        [self addSubview:_activityView];
        //设置小菊花的frame
        _activityView.frame= CGRectMake(0, 0, 100, 100);
        //设置小菊花颜色
        _activityView.color = [UIColor redColor];
        //设置背景颜色
        _activityView.backgroundColor = [UIColor redColor];
        _activityView.alpha = 0.8;
        //刚进入这个界面会显示控件，并且停止旋转也会显示，只是没有在转动而已，没有设置或者设置为YES的时候，刚进入页面不会显示
        _activityView.hidesWhenStopped = NO;
        self.hidden = YES;
    }
    return self;
}
-(void)start
{
    [_activityView startAnimating];
}
-(void)end
{
    [_activityView stopAnimating];
}
@end
