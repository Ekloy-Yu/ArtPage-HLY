//
//  HLDownloadViewController.m
//  ArtPage
//
//  Created by 何龙 on 2018/9/20.
//  Copyright © 2018年 何龙. All rights reserved.
//

#import "HLDownloadViewController.h"
#import "HLDownLoadContentView.h"
#import "HLindexViewController.h"
#import "HLRequestManager.h"
#import "HLNavigationViewController.h"
@interface HLDownloadViewController ()
/*---     下载按钮 ------*/
@property (nonatomic, strong) UIButton *downloadBtn;
@property (nonatomic, strong) HLDownLoadContentView *contentView;

/*------     用于存放提示信息的数组     ------*/
@property (nonatomic, strong) NSArray *textArr;

/*------     用于存放groupID的数组 ------*/
@property (nonatomic, strong) NSMutableArray *groupIdArr;

/*------     下载数量 ------*/
@property (nonatomic, assign) NSInteger downloadCount;

/*------     显示进度的label ------*/
@property (nonatomic, strong) UILabel *progressLabel;

@property (nonatomic, assign) NSInteger dCount;

/*------     总下载数 ------*/
@property (nonatomic, assign) NSInteger sum;

@property (nonatomic, assign) BOOL down;
@end

@implementation HLDownloadViewController{

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dCount = 1;
    /*------     初始化头部与尾部 ------*/
    [self initWithFooterView:NO andHeaderView:NO andText:nil];
    [self.oneFooterView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(100, 70));
    }];
    /*------     添加内容视图 ------*/
    [self initContentView];
    
    
    self.downloadBtn.selected = NO;
    self.progressLabel.text = @"0%";
    
}
#pragma mark - 懒加载----------------start-------------------------------
-(UILabel *)progressLabel
{
    if(!_progressLabel)
    {
        _progressLabel = [[UILabel alloc] init];
        _progressLabel.font = HLFont(60);
        _progressLabel.textColor = [UIColor whiteColor];
        _progressLabel.textAlignment = NSTextAlignmentRight;
        [self.view addSubview:_progressLabel];
        [_progressLabel makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(0);
            make.bottom.equalTo(self.view.bottom).offset(-20);
            make.size.equalTo(CGSizeMake(200, 80));
        }];
    }
    return _progressLabel;
}
-(NSMutableArray *)groupIdArr
{
    if(!_groupIdArr)
    {
        _groupIdArr = [NSMutableArray arrayWithCapacity:1];
    }
    return _groupIdArr;
}
-(NSArray *)textArr
{
    if(!_textArr)
    {
        NSString *str1 = @"数据同步|执行该步骤将会下载您在ArtPage上的全部图片与相关数据，200张图片的下载容量约为20M，建议在WIFI环境下使用该功能，以免产生额外的流量费用。";
        NSString *str2 = @"数据同步中|取消下载会暂时停止同步数据,下次同步时会继续从本次下载的进度开始同步。";
        NSString *str3 = @"数据同步已完成|您在ArtPage上的全部图片与相关数据已同步到当前设备中。如需管理分组及作品，请使用浏览器访问网页端ArtPage。";
        _textArr = [NSArray arrayWithObjects:str1, str2, str3, nil];
    }
    return _textArr;
}
-(UIButton *)downloadBtn
{
    if(!_downloadBtn)
    {
        _downloadBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_downloadBtn setImage:[UIImage imageNamed:@"btn_开始下载"] forState:(UIControlStateNormal)];
        [_downloadBtn setImage:[UIImage imageNamed:@"btn_取消下载"] forState:(UIControlStateSelected)];
        [_downloadBtn addTarget:self action:@selector(btnSelected:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.view addSubview:_downloadBtn];
        [_downloadBtn makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(20);
            make.top.equalTo(self.contentView.bottom).offset(50);
            make.size.equalTo(CGSizeMake(SCREENWIDTH - 40, 47));
        }];
    }
    return _downloadBtn;
}
#pragma mark - 懒加载----------------end-------------------------------

-(void)initContentView
{
    _contentView = [[HLDownLoadContentView alloc] initWithFrame:CGRectZero andStr:self.textArr[0]];
    _contentView.frame = CGRectMake(0, 120, SCREENWIDTH, CGRectGetMaxY(_contentView.contentLabel.frame));
    [self.view addSubview:_contentView];
}

#pragma mark - 点击下载----------------------
-(void)btnSelected:(UIButton *)btn
{
    _contentView.contentLabel.text = _textArr[1];
    //如果下载完成
    if(_down)
    {
        //获取当前时间日期
        NSDate *date=[NSDate date];
        NSDateFormatter *format1=[[NSDateFormatter alloc] init];
        [format1 setDateFormat:@"yyyy-MM-dd hh:mm"];
        NSString *dateStr = [format1 stringFromDate:date];
        
        /*------     存取最后更新时间 ------*/
        KUserDefault(dateStr, @"lastDate");
        
        /*------     判断是否是登录状态 ------*/
        if([gainUserDefault(@"登录状态") isEqualToString:@"已登录"])
        {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        else
        {
//            [self dismissViewControllerAnimated:YES completion:nil];
            HLindexViewController *tempVC = [[HLindexViewController alloc] init];
            UIApplication *vc = [UIApplication sharedApplication];
            vc.keyWindow.rootViewController =[[HLNavigationViewController alloc] initWithRootViewController:tempVC];
        }
        /*--------     放在这里时，默认直接pop再次点击会找不到第三个控制器，导致崩溃  --------*/
//        NSString *login = @"已登录";
//        KUserDefault(login, @"登录状态");
    }
    if(btn.selected)
    {
        //暂停下载
        btn.selected = NO;
        self.oneFooterView.hidden = NO;
        [[AFOwnerHTTPSessionManager shareManager] suspendAllDownload];
    }
    else
    {
        //开始下载
        btn.selected = YES;
        self.oneFooterView.hidden = YES;
        if(self.dCount == 1)
        {
           [self beginDownload];
        }
        else
        {
            [[AFOwnerHTTPSessionManager shareManager] startAllDownload];
        }
        self.dCount = 2;
    }
}
#pragma mark - 下载操作-----------------------------
-(void)beginDownload
{
    dispatch_queue_t queue = dispatch_queue_create("com.helong.serial", DISPATCH_QUEUE_CONCURRENT);
    /*------     下载公开作品相关数据 ------*/
    [HLRequestManager Download:@"GetPublicGroup" andModelName:@"PublicGroupModel" andID:@"GroupID" andArr:self.groupIdArr];
    
    /*------     下载非公开作品相关数据 ------*/
    [HLRequestManager Download:@"GetECPGroup" andModelName:@"ECPGroupModel" andID:@"GroupID" andArr:self.groupIdArr];
    
    /*------     下载日志相关数据 ------*/
    [HLRequestManager Download:@"GetNewsList" andModelName:@"NewsListModel" andID:@"ID" andArr:self.groupIdArr];
    
    /*------     下载关于相关数据 ------*/
//    [HLRequestManager Download:@"GetAbout" andModelName:@"GetAboutModel" andqueue:queue andID:@"AvailableForFreelance" andArr:self.groupIdArr];
    [HLRequestManager downloadGetAbout];
    /*------     下载作品相关数据 ------*/
    [HLRequestManager downloadArtPartArr:self.groupIdArr];
    //下载图片保存至本地路径
    [self downloadPart:queue];
}
#pragma mark - 下载图片至本地路径
-(void)downloadPart:(dispatch_queue_t)queue
{
//    __weak typeof (self)weakSelf = self;
//    //用数据库中的图片链接地址下载图片并保存-------------------------
//    dispatch_barrier_async(queue, ^{
//
//        NSArray *arr  = @[@"PublicGroupModel", @"ECPGroupModel"];
//        weakSelf.sum = [HLRequestManager modelnameArr:arr];
//        /*-----------  groupImage下载  --------------*/
//        [HLRequestManager GroupId];
//        /*-----------  newsListImage下载  --------------*/
//    });
//    /*-----------  公开作品缩略图下载  --------------*/
//    dispatch_barrier_async(queue, ^{
//        weakSelf.downloadCount = [HLRequestManager downloadPart:queue model:@"PublicGroupModel" path:@"Public" imageType:@"缩略图" count:0 sumCount:weakSelf.sum label:weakSelf.progressLabel];
//    });
//    /*-----------  非公开作品缩略图下载  --------------*/
//    dispatch_barrier_async(queue, ^{
//        weakSelf.downloadCount+= [HLRequestManager downloadPart:queue model:@"ECPGroupModel" path:@"ECP" imageType:@"缩略图" count:weakSelf.downloadCount sumCount:weakSelf.sum label:weakSelf.progressLabel];
//    });
//        //        /*-----------  公开作品原图下载  ---------------*/
//    dispatch_barrier_async(queue, ^{
//        weakSelf.downloadCount+= [HLRequestManager downloadPart:queue model:@"PublicGroupModel" path:@"PublicOriginal" imageType:@"原图"count:weakSelf.downloadCount sumCount:weakSelf.sum label:weakSelf.progressLabel];
//        });
//        //        /*-----------  非公开作品原图下载  --------------*/
//    dispatch_barrier_async(queue, ^{
//        weakSelf.downloadCount+= [HLRequestManager downloadPart:queue model:@"ECPGroupModel" path:@"ECPOriginal" imageType:@"原图" count:weakSelf.downloadCount sumCount:weakSelf.sum label:weakSelf.progressLabel];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            weakSelf.progressLabel.text = @"100%";
//            [weakSelf.downloadBtn setImage:[UIImage imageNamed:@"btn_进入主界面"] forState:UIControlStateSelected];
//            weakSelf.contentView.contentLabel.text = weakSelf.textArr[2];
//        });
//    });
    __weak typeof (self)weakSelf = self;
    //用数据库中的图片链接地址下载图片并保存-------------------------
    dispatch_barrier_async(queue, ^{
        
        NSArray *arr  = @[@"PublicGroupModel", @"ECPGroupModel"];
        NSInteger sum = [HLRequestManager modelnameArr:arr];
        NSInteger count = 0;
        /*-----------  groupImage下载  --------------*/
        [HLRequestManager GroupId];
        /*-----------  newsListImage下载  --------------*/
        
        /*-----------  公开作品缩略图下载  --------------*/
        count = [HLRequestManager downloadPart:queue model:@"PublicGroupModel" path:@"Public" imageType:@"缩略图" count:0 sumCount:sum label:weakSelf.progressLabel];
        /*-----------  非公开作品缩略图下载  --------------*/
        count+= [HLRequestManager downloadPart:queue model:@"ECPGroupModel" path:@"ECP" imageType:@"缩略图" count:count sumCount:sum label:weakSelf.progressLabel];
        
        //        /*-----------  公开作品原图下载  ---------------*/
        count+= [HLRequestManager downloadPart:queue model:@"PublicGroupModel" path:@"PublicOriginal" imageType:@"原图"count:count sumCount:sum label:weakSelf.progressLabel];
        //
        //
        //        /*-----------  非公开作品原图下载  --------------*/
        count+= [HLRequestManager downloadPart:queue model:@"ECPGroupModel" path:@"ECPOriginal" imageType:@"原图" count:count sumCount:sum label:weakSelf.progressLabel];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.progressLabel.text = @"100%";
            [weakSelf.downloadBtn setImage:[UIImage imageNamed:@"btn_进入主界面"] forState:UIControlStateSelected];
            weakSelf.contentView.contentLabel.text = weakSelf.textArr[2];
            weakSelf.down = YES;
        });
    });
}


@end
