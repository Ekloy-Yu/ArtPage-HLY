//
//  HLShareViewController.m
//  ArtPage
//
//  Created by 何龙 on 2018/10/8.
//  Copyright © 2018年 何龙. All rights reserved.
//

#import "HLShareViewController.h"
#import "HLSelectBtn2View.h"
@interface HLShareViewController ()
@property (nonatomic, strong) HLSelectBtn2View *btnView;
@end

@implementation HLShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWithFooterView:NO andHeaderView:NO andText:nil];
    self.btnView.hidden = NO;
    [self initBodyView];
    [self shareVC];
    // Do any additional setup after loading the view.
}
#pragma mark - 懒加载----------
-(HLSelectBtn2View *)btnView
{
    if(!_btnView)
    {
        NSArray *imageArr = [NSArray arrayWithObjects:@"btn_复制链接", @"btn_微信好友", @"btn_朋友圈", @"btn_新浪微博", @"btn_信息", @"btn_邮件", nil];
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
-(void)shareVC
{
    self.btnView.block0 = ^(HLSelectBtn2View *hlSelectBtnView) {
        NSLog(@"复制链接");
    };
    self.btnView.block1 = ^(HLSelectBtn2View *hlSelectBtnView) {
        NSLog(@"分享至微信好友");
        //这种分享是带文字和图片的分享，属于网页分享，注意分享的图片大小不能超过32k。
        WXMediaMessage *message = [WXMediaMessage message];
        message.title = @"ArtPage";
        message.description = @"您的好友给您分享了一组作品！";
        [message setThumbImage:[UIImage imageNamed:@"share"]];

        WXWebpageObject *ext = [WXWebpageObject object];
        if([gainUserDefault(@"shareAddress") isKindOfClass:[NSNull class]])
        {
            ext.webpageUrl = @"http://www.artp.cc/Pages/User/login.aspx";
        }
        else
        {
            ext.webpageUrl = gainUserDefault(@"shareAddress");
        }
        message.mediaObject = ext;
        
        NSLog(@"分享链接为%@", ext.webpageUrl);
        SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
        req.bText = NO;
        req.message = message;
        //这个属性表示分享到好友
        req.scene = WXSceneSession;
        [WXApi sendReq:req];
    };
    self.btnView.block2 = ^(HLSelectBtn2View *hlSelectBtnView) {
        NSLog(@"分享至朋友圈");
        //这种分享是带文字和图片的分享，属于网页分享，注意分享的图片大小不能超过32k。
        WXMediaMessage *message = [WXMediaMessage message];
        message.title = @"ArtPage";
        message.description = @"您的好友给您分享了一组作品！";
        [message setThumbImage:[UIImage imageNamed:@"share"]];
        
        WXWebpageObject *ext = [WXWebpageObject object];
        
        
        ext.webpageUrl = gainUserDefault(@"shareAddress");;
        
        NSLog(@"正在分享的链接地址为 = %@", ext.webpageUrl);
        message.mediaObject = ext;
        
        SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
        req.bText = NO;
        req.message = message;
        //这个属性表示分享到好友
        req.scene = WXSceneTimeline;
        [WXApi sendReq:req];
    };
    self.btnView.block3 = ^(HLSelectBtn2View *hlSelectBtnView) {
        NSLog(@"分享至新浪微博");
        
    };
    self.btnView.block4 = ^(HLSelectBtn2View *hlSelectBtnView) {
        NSLog(@"信息");
    };
    self.btnView.block5 = ^(HLSelectBtn2View *hlSelectBtnView) {
        NSLog(@"邮件");
    };
}
#pragma mark - 添加bodyView
-(void)initBodyView
{
    //添加链接label
    UILabel *label = [[UILabel alloc] init];
    label.text = @"http://artist.artp.cc/123/artlist";
    label.font = HLFont(14);
    label.layer.borderWidth = 1;
    label.textColor = [UIColor grayColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.borderColor = [UIColor grayColor].CGColor;
    [self.view addSubview:label];
    [label makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.centerX);
        make.bottom.equalTo(self.btnView.top).offset(-20);
        make.size.equalTo(CGSizeMake(SCREENWIDTH, 60));
    }];
    //添加titleLabel
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"分享链接";
    titleLabel.textColor = [UIColor grayColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = HLFont(20);
    [self.view addSubview:titleLabel];
    [titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.bottom.equalTo(label.top).offset(-20);
        make.size.equalTo(CGSizeMake(SCREENWIDTH, 20));
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
