//
//  ViewController.m
//  ArtPage
//
//  Created by 何龙 on 2018/9/19.
//  Copyright © 2018年 何龙. All rights reserved.
//

#import "ViewController.h"
#import "HLDownloadViewController.h"
#import "AFHTTPSessionManager.h"
#import "HLLoginView.h"

@interface ViewController ()
@property (nonatomic, strong) HLLoginView *loginView;
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@end

@implementation ViewController
// 支持设备自动旋转
- (BOOL)shouldAutorotate
{
    return NO;
}

// 支持竖屏显示
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = HLColor(30, 30, 30);
    
    /*-----   初始化登录视图。 ---------*/
    [self createLoginView];
    
    /*----    判断是否为登录状态，如果是，添加一个返回按钮 -----------*/
    if([gainUserDefault(@"登录状态") isEqualToString:@"已登录"])
    {
        UIButton *backBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [backBtn setImage:[UIImage imageNamed:@"箭头"] forState:(UIControlStateNormal)];
        [backBtn addTarget:self action:@selector(back) forControlEvents:(UIControlEventTouchUpInside)];
        [self.view addSubview:backBtn];
        [backBtn makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(10);
            make.top.equalTo(10);
            make.size.equalTo(CGSizeMake(25, 27));
        }];
    }
    // Do any additional setup after loading the view, typically from a nib.
}
#pragma mark - 返回按钮执行的方法
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 初始化网络
-(AFHTTPSessionManager *)manager
{
    if(!_manager)
    {
        _manager = [[AFHTTPSessionManager alloc] init];
        _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    return _manager;
}

-(void)createLoginView
{
    _loginView = [[HLLoginView alloc] init];
    __weak typeof (self)weakSelf = self;
    _loginView.block = ^(HLLoginView *loginView) {
        NSString *url = [NSString stringWithFormat:@"http://www.artp.cc/pages/jsonService/jsonForIPad.aspx?Method=CheckUser&UserName=%@&Password=%@", weakSelf.loginView.userTextField.text, weakSelf.loginView.pwdTextField.text];
        [weakSelf.manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            NSLog(@"%@", responseObject);
//            NSLog(@"%@", [responseObject objectForKey:@"ErrMessage"]);
            if([[responseObject objectForKey:@"ErrMessage"] isKindOfClass:[NSNull class]])
            {
                NSString *userName = [[[responseObject objectForKey:@"data"] objectAtIndex:0] objectForKey:@"ACCOUNT_DOMAIN"];
                id type = [[[responseObject objectForKey:@"data"] objectAtIndex:0] objectForKey:@"ACCOUNT_TYPE2"];
                NSString *UserID = [[[responseObject objectForKey:@"data"] objectAtIndex:0] objectForKey:@"UserID"];
                NSString *endDate = [[[responseObject objectForKey:@"data"] objectAtIndex:0] objectForKey:@"endDate"];
                KUserDefault(userName, @"userName");
                KUserDefault(type, @"type");
                KUserDefault(UserID, @"userId");
                KUserDefault(endDate, @"endDate");
                if([gainUserDefault(@"登录状态") isEqualToString:@"已登录"])
                {
                    [weakSelf.navigationController pushViewController:[[HLDownloadViewController alloc] init] animated:YES];
                }
                else
                {
                    [weakSelf presentViewController:[[HLDownloadViewController alloc] init] animated:YES completion:nil];
                }
            }
            else
            {
                NSString *alertText = [responseObject objectForKey:@"ErrMessage"];
                NSLog(@"%@", alertText);
                [weakSelf createAlertView:alertText];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@", error);
        }];
    };
    [self.view addSubview:_loginView];
    [_loginView makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(0);
        make.size.equalTo(CGSizeMake(SCREENWIDTH, SCREENHEIGHT));
    }];
}
#pragma mark - 创建弹窗
-(void)createAlertView:(NSString *)text
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:text preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVC addAction:action];
    [self presentViewController:alertVC animated:YES completion:nil];
}
#pragma mark - 消除存储的临时数据（不应该写在这里)
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    /* --  当操作路径为 登录-设置-更新账号-back到设置页面-更新数据-点击下载时，userId被清除，下载时找不到userId，会导致程序崩溃   --*/
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userName"];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"type"];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userId"];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"endDate"];
    
}
#pragma mark - 创建路径
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //创建文件路径-------------------------------------
    NSString * docsdir = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *dataFilePath = [docsdir stringByAppendingPathComponent:[NSString stringWithFormat:@"/Caches/userfiles/%@", gainUserDefault(@"userId")]];
//    NSString *dataFilePath1 = [docsdir stringByAppendingPathComponent:@"/Caches/About"];
//    NSString *dataFilePath2 = [docsdir stringByAppendingPathComponent:@"/Caches/NewsList"];
//    NSString *dataFilePath3 = [docsdir stringByAppendingPathComponent:@"/Caches/ECP"];
//    NSString *dataFilePath4 = [docsdir stringByAppendingPathComponent:@"/Caches/ECPOriginal"];
//    NSString *dataFilePath5 = [docsdir stringByAppendingPathComponent:@"/Caches/Public"];
//    NSString *dataFilePath6 = [docsdir stringByAppendingPathComponent:@"/Caches/PublicOriginal"];
    // 在Libary目录下创建 "文件目录" 文件夹
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = NO;
    // fileExistsAtPath 判断一个文件或目录是否有效，isDirectory判断是否一个目录
    BOOL existed = [fileManager fileExistsAtPath:dataFilePath isDirectory:&isDir];
//    BOOL existed1 = [fileManager fileExistsAtPath:dataFilePath1 isDirectory:&isDir];
//    BOOL existed2 = [fileManager fileExistsAtPath:dataFilePath2 isDirectory:&isDir];
//    BOOL existed3 = [fileManager fileExistsAtPath:dataFilePath3 isDirectory:&isDir];
//    BOOL existed4 = [fileManager fileExistsAtPath:dataFilePath4 isDirectory:&isDir];
//    BOOL existed5 = [fileManager fileExistsAtPath:dataFilePath5 isDirectory:&isDir];
//    BOOL existed6 = [fileManager fileExistsAtPath:dataFilePath6 isDirectory:&isDir];
    
    if (!(isDir && existed)) {
        // 在Document目录下创建一个archiver目录
        [fileManager createDirectoryAtPath:dataFilePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
//    if (!(isDir && existed1)) {
//        // 在Document目录下创建一个archiver目录
//        [fileManager createDirectoryAtPath:dataFilePath1 withIntermediateDirectories:YES attributes:nil error:nil];
//    }
//    if (!(isDir && existed2)) {
//        // 在Document目录下创建一个archiver目录
//        [fileManager createDirectoryAtPath:dataFilePath2 withIntermediateDirectories:YES attributes:nil error:nil];
//    }
//    if (!(isDir && existed6)) {
//        // 在Document目录下创建一个archiver目录
//        [fileManager createDirectoryAtPath:dataFilePath6 withIntermediateDirectories:YES attributes:nil error:nil];
//    }
//    if (!(isDir && existed3)) {
//        // 在Document目录下创建一个archiver目录
//        [fileManager createDirectoryAtPath:dataFilePath3 withIntermediateDirectories:YES attributes:nil error:nil];
//    }
//    if (!(isDir && existed4)) {
//        // 在Document目录下创建一个archiver目录
//        [fileManager createDirectoryAtPath:dataFilePath4 withIntermediateDirectories:YES attributes:nil error:nil];
//    }
//    if (!(isDir && existed5)) {
//        // 在Document目录下创建一个archiver目录
//        [fileManager createDirectoryAtPath:dataFilePath5 withIntermediateDirectories:YES attributes:nil error:nil];
//    }
    
}

@end
