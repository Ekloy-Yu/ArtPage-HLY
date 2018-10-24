//
//  HLWebViewController.m
//  ArtPage
//
//  Created by 何龙 on 2018/10/11.
//  Copyright © 2018 何龙. All rights reserved.
//

#import "HLWebViewController.h"
#import "WKWebView+Extension.h"
#import "HLWebHeaderView.h"
#import "HLWebShareView.h"
//#import <WebKit/WebKit.h>
@interface HLWebViewController ()
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) HLWebHeaderView *headerView;
@end
static NSString *url;
@implementation HLWebViewController{
    float oldOffset;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    url = @"https://m.sogou.com";
    [self initHeaderView];
    [self initWebView:url];
    // ------ 监听 WKWebView 对象的 title 属性
    [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
    
}
-(void)initHeaderView
{
    self.headerView = [[HLWebHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 50) title:url];
    __weak typeof (self)weakSelf = self;
    self.headerView.backBlock = ^(HLWebHeaderView *view) {
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    self.headerView.refreshBlock = ^(HLWebHeaderView *view) {
//        [weakSelf.webView reload];
        [weakSelf shareView];
        
    };
    [self.view addSubview:self.headerView];
    
}
-(void)shareView
{
    HLWebShareView *shareView = [[HLWebShareView alloc] initWithFrame:CGRectMake(0, 50, SCREENWIDTH, SCREENHEIGHT)];
    [[UIApplication sharedApplication].keyWindow addSubview:shareView];
}
-(void)initWebView:(NSString *)address
{
    _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 50, SCREENWIDTH, SCREENHEIGHT - 64)];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:address]]];
    _webView.scrollView.delegate = self;
    //看这里，看这里，一行代码就实现了进度监听个进度条颜色自定义
    [_webView showProgressWithColor:[UIColor orangeColor]];
    [self.view addSubview:_webView];
}
- (void)dealloc {
    // ------ 移除观察者
    [self.webView removeObserver:self forKeyPath:@"title"];
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context {
    NSLog(@"%@", self.webView.title);
    if ([keyPath isEqualToString:@"title"]) {
        self.headerView.urlLabel.text = change[@"new"];
    }else {
        [super observeValueForKeyPath:keyPath
                             ofObject:object
                               change:change
                              context:context];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    NSLog(@"%lf", scrollView.contentOffset.y);
    
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if(scrollView.contentOffset.y > oldOffset)
    {
        NSLog(@"向上");
        [UIView animateWithDuration:0.5 animations:^{
            self.headerView.frame = CGRectMake(0, 0, SCREENWIDTH, 33);
            self.headerView.backgroundColor = HLColor(117, 215, 56);
            self.headerView.leftBtn.frame = CGRectMake(10, -27, 16, 18);
            self.headerView.rightBtn.frame = CGRectMake(SCREENWIDTH - 33, -27, 23, 23);
            self.headerView.urlLabel.frame = CGRectMake(40, 12, SCREENWIDTH - 80, 20);
            self.headerView.urlLabel.font = HLFont(14);
            self.webView.frame = CGRectMake(0, 33, SCREENWIDTH, SCREENHEIGHT - 33);
        } completion:^(BOOL finished) {
        }];
    }
    else
    {
        [UIView animateWithDuration:0.5 animations:^{
            
            self.headerView.frame = CGRectMake(0, 0, SCREENWIDTH, 50);
            self.headerView.backgroundColor = HLColor(216, 38, 38);
            self.headerView.leftBtn.frame = CGRectMake(10, 20, 16, 18);
            self.headerView.rightBtn.frame = CGRectMake(SCREENWIDTH - 33, 20, 23, 23);
            self.headerView.urlLabel.frame = CGRectMake(40, 20, SCREENWIDTH - 80, 20);
            self.headerView.urlLabel.font = HLFont(18);
            self.webView.frame = CGRectMake(0, 50, SCREENWIDTH, SCREENHEIGHT - 50);
        } completion:^(BOOL finished) {
//            self.headerView.leftBtn.hidden = NO;
//            self.headerView.rightBtn.hidden = NO;
        }];
        NSLog(@"向下");
    }
}

/** 当scrollView将要被牵引，被拖动的时候  */
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    NSLog(@"scrollView正要被拖拽！");
    NSLog(@"当前的y = %lf", scrollView.contentOffset.y);
    oldOffset = scrollView.contentOffset.y;
}

@end
