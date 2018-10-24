//
//  HLNavigationViewController.m
//  滴滴项目
//
//  Created by 何龙 on 2018/8/21.
//  Copyright © 2018年 何龙. All rights reserved.
//

#import "HLNavigationViewController.h"

@interface HLNavigationViewController ()

@end

@implementation HLNavigationViewController
- (BOOL)shouldAutorotate
{
    return [self.viewControllers.lastObject shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [self.viewControllers.lastObject supportedInterfaceOrientations];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏颜色
    self.navigationBar.hidden = YES;
}

//重写push方法
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:YES];
//    [UIView transitionWithView:self.view duration:0.5 options:UIViewAnimationOptionTransitionFlipFromRight animations:nil completion:nil];
}

//重写pop方法
-(UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    [super popViewControllerAnimated:YES];
//     [UIView transitionWithView:self.view duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft animations:nil completion:nil];
    return self;
}


@end
