//
//  HLNewsListViewController.m
//  ArtPage
//
//  Created by 何龙 on 2018/9/26.
//  Copyright © 2018年 何龙. All rights reserved.
//

#import "HLNewsListViewController.h"
#import "HLNewsListTableViewCell.h"
#import "HLColumnViewController.h"
#import "HLSettingUpViewController.h"
#import "GetDataBase.h"
#import "HLDetailNewsListViewController.h"
#import "HLShareViewController.h"
@interface HLNewsListViewController ()
@property (nonatomic, strong) UITableView *aTableView;
@property (nonatomic, strong) NSMutableArray *objectArr;
@end

@implementation HLNewsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = HLColor(23, 23, 23);
    [self.view addSubview:self.aTableView];
    [self initModel];
    [self initWithFooterView:YES andHeaderView:NO andText:@"日志"];
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
        _aTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 80, SCREENWIDTH, SCREENHEIGHT - 70) style:(UITableViewStylePlain)];
        _aTableView.delegate = self;
        _aTableView.dataSource = self;
        _aTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _aTableView.backgroundColor = [UIColor clearColor];
        [_aTableView registerClass:[HLNewsListTableViewCell class] forCellReuseIdentifier:@"HLcell"];
    }
    return _aTableView;
}
#pragma mark - 栏目以及设置跳转功能------------------------------------
-(void)jumpVC
{
    __weak typeof (self)weakSelf = self;
    //column跳转的block方法
    self.twoFooterView.columnBlock = ^(HLTwoFooterView *twoFooterView) {
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    //setup跳转的block方法
    self.twoFooterView.setBlock = ^(HLTwoFooterView *twoFooterView) {
        [weakSelf.navigationController pushViewController:[[HLSettingUpViewController alloc] init] animated:YES];
    };
}
#pragma mark - 给model赋值-------------------------------------------------
-(void)initModel
{
    [self.objectArr addObject:[[GetDataBase shareDataBase] wzGainTableRecoderID:@"NewsListModel"]];
    [self.aTableView reloadData];
}
#pragma mark - tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsListModel *obj = [[self.objectArr objectAtIndex:0] objectAtIndex:indexPath.row];
    
    HLNewsListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HLcell"];
    [cell setNewsListModel:obj];
    
    /*   -------    分享按钮    -------*/
    __weak typeof (self)weakSelf = self;
    cell.block = ^(HLindexTableViewCell *cell) {
        //拼接链接地址，点击分享时传送地址
        NSString *shareAddress = [NSString stringWithFormat:@"http://%@.artp.cc/%@/newsInfo", gainUserDefault(@"userName"), obj.ID];
        KUserDefault(shareAddress, @"shareAddress");
        NSLog(@"shareAddress = %@", shareAddress);
        [weakSelf.navigationController pushViewController:[[HLShareViewController alloc] init] animated:YES];
    };
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.objectArr objectAtIndex:0] count];
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
    
    NewsListModel *obj = [[NewsListModel alloc] init];
    obj = [[self.objectArr objectAtIndex:0] objectAtIndex:indexPath.row];
    KUserDefault(obj.ID, @"NewsListID");
    [self.navigationController pushViewController:[[HLDetailNewsListViewController alloc] init] animated:NO];
    
}
@end
