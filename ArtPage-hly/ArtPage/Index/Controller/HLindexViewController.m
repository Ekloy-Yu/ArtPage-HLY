//
//  HLindexViewController.m
//  ArtPage
//
//  Created by 何龙 on 2018/9/19.
//  Copyright © 2018年 何龙. All rights reserved.
//

#import "HLindexViewController.h"
#import "HLindexTableViewCell.h"
#import "AssignToObject.h"
#import "GetDataBase.h"
#import "PublicGroupModel.h"
#import "HLGroupImageViewController.h"
#import "HLColumnViewController.h"
#import "HLSettingUpViewController.h"
#import "HLPasswordView.h"
#import "HLShareViewController.h"
@interface HLindexViewController ()
@property (nonatomic, strong) UITableView *aTableView;
@property (nonatomic, strong) NSMutableArray *objectArr;
@property (nonatomic, strong) HLPasswordView *pwdView;
@end

@implementation HLindexViewController
-(void)loadView
{
    [super loadView];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = HLColor(23, 23, 23);
    
    [self.view addSubview:self.aTableView];
    [self initModel];
    [self initWithFooterView:YES andHeaderView:NO andText:@"公开作品"];
    //点击栏目以及设置响应的方法
    [self jumpVC];
    // Do any additional setup after loading the view.
}
#pragma mark - 懒加载--------------------------------
-(NSMutableArray *)objectArr
{
    if(!_objectArr)
    {
        _objectArr = [[NSMutableArray alloc] initWithCapacity:1];
    }
    return _objectArr;
}
-(UITableView *)aTableView
{
    if(!_aTableView)
    {
        _aTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 80, SCREENWIDTH, SCREENHEIGHT - 100) style:(UITableViewStylePlain)];
        _aTableView.delegate = self;
        _aTableView.dataSource = self;
        _aTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _aTableView.backgroundColor = [UIColor clearColor];
        [_aTableView registerClass:[HLindexTableViewCell class] forCellReuseIdentifier:@"HLcell"];
    }
    return _aTableView;
}
#pragma mark - 栏目以及设置跳转功能------------------------------------
-(void)jumpVC
{
    __weak typeof (self)weakSelf = self;
    //column跳转的block方法
    self.twoFooterView.columnBlock = ^(HLTwoFooterView *twoFooterView) {
        [weakSelf.navigationController pushViewController:[[HLColumnViewController alloc] init] animated:YES];
    };
    //setup跳转的block方法
    self.twoFooterView.setBlock = ^(HLTwoFooterView *twoFooterView) {
        [weakSelf.navigationController pushViewController:[[HLSettingUpViewController alloc] init] animated:YES];
    };
}
#pragma mark - 给model赋值-------------------------------------------------
-(void)initModel
{
    [self.objectArr removeAllObjects];
    [self.objectArr addObject:[[GetDataBase shareDataBase] wzGainTableRecoderID:@"PublicGroupModel"]];
    [self.objectArr addObject:[[GetDataBase shareDataBase] wzGainTableRecoderID:@"ECPGroupModel"]];
//    NSLog(@"objectArr = %@", self.objectArr);
    [self.aTableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *isShow = gainUserDefault(@"isShow");
//    NSLog(@"isShow = %@", isShow);
    if([isShow isEqualToString:@"2"])
    {
        ECPGroupModel *obj2 = [[self.objectArr objectAtIndex:1] objectAtIndex:indexPath.row];
        HLindexTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HLcell"];
        [cell setECPModel:obj2];
        
        /*---        分享按钮     ----*/
        cell.block = ^(HLindexTableViewCell *cell) {
            //拼接链接地址，点击分享时传送地址
            NSString *shareAddress = [NSString stringWithFormat:@"http://%@.artp.cc/%@/artlist", gainUserDefault(@"userName"), obj2.GroupID];
            KUserDefault(shareAddress, @"shareAddress");
            NSLog(@"shareAddress = %@", shareAddress);
            [self.navigationController pushViewController:[[HLShareViewController alloc] init] animated:YES];
        };
        self.titleHeaderView.titleLabel.text = @"非公开作品";
        return cell;
    }
    else
    {
        PublicGroupModel *obj1 = [[self.objectArr objectAtIndex:0] objectAtIndex:indexPath.row];
        HLindexTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HLcell"];
        [cell setModel:obj1];
        self.titleHeaderView.titleLabel.text = @"公开作品";
        
        /*---        分享按钮     ----*/
        cell.block = ^(HLindexTableViewCell *cell) {
            //拼接链接地址，点击分享时传送地址
            NSString *shareAddress = [NSString stringWithFormat:@"http://%@.artp.cc/%@/artlist", gainUserDefault(@"userName"), obj1.GroupID];
            KUserDefault(shareAddress, @"shareAddress");
            NSLog(@"shareAddress = %@", shareAddress);
            [self.navigationController pushViewController:[[HLShareViewController alloc] init] animated:YES];
        };
        return cell;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    /*  ------  判断分组的类别，返回不同的count    -----------*/
    if([gainUserDefault(@"isShow") isEqualToString:@"2"])
    {
       return [[self.objectArr objectAtIndex:1] count];
    }
    else
    {
        return [[self.objectArr objectAtIndex:0] count];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //去除选中状态
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
    //得到groupid
    if([gainUserDefault(@"isShow") isEqualToString:@"2"])
    {
        ECPGroupModel *obj = [[ECPGroupModel alloc] init];
        obj = [[self.objectArr objectAtIndex:1] objectAtIndex:indexPath.row];
        KUserDefault(obj.GroupID, @"GroupID");
        KUserDefault(@"ECP", @"model");
        NSLog(@"分组的密码 = %@", obj.Password);
        KUserDefault(obj.GroupName_CN, @"GroupName");
        //判断是否为英文
        if([gainUserDefault(@"language") isEqualToString:@"English"])
        {
            KUserDefault(obj.GroupName_EN, @"GroupName");
        }
        
        if([obj.PWDON isEqualToString:@"0"])
        {
            [self.navigationController pushViewController:[[HLGroupImageViewController alloc] init] animated:YES];
        }
        else
        {
            [self.pwdView removeFromSuperview];
            /* -------    添加密码输入视图。   -------*/
            _pwdView = [[HLPasswordView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) pwd:obj.Password titleText:obj.GroupName_CN];
            __weak typeof (self)weakSelf = self;
            _pwdView.block = ^(HLPasswordView *view) {
                [weakSelf.pwdView removeFromSuperview];
                [weakSelf.navigationController pushViewController:[[HLGroupImageViewController alloc] init] animated:YES];
            };
            _pwdView.failBlock = ^(HLPasswordView *view) {
                UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"密码不正确" preferredStyle:(UIAlertControllerStyleAlert)];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                }];
                [alertVC addAction:action];
                [weakSelf presentViewController:alertVC animated:YES completion:nil];
            };
            [[UIApplication sharedApplication].keyWindow addSubview:_pwdView];
//            [UIView animateWithDuration:0.3 animations:^{
//                weakSelf.pwdView.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
//
//            }];
        }
    }
    else
    {
        PublicGroupModel *obj = [[PublicGroupModel alloc] init];
        obj = [[self.objectArr objectAtIndex:0] objectAtIndex:indexPath.row];
        KUserDefault(obj.GroupID, @"GroupID");
        KUserDefault(@"Public", @"model");
        KUserDefault(obj.GroupName_CN, @"GroupName");
        //判断是否为英文
        if([gainUserDefault(@"language") isEqualToString:@"English"])
        {
            KUserDefault(obj.GroupName_EN, @"GroupName");
        }
        [self.navigationController pushViewController:[[HLGroupImageViewController alloc] init] animated:YES];
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSString *login = @"已登录";
    KUserDefault(login, @"登录状态");
    [self initModel];
    [self.aTableView reloadData];
}
@end
