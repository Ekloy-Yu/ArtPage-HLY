//
//  HLGroupImageViewController.m
//  ArtPage
//
//  Created by 何龙 on 2018/9/22.
//  Copyright © 2018年 何龙. All rights reserved.
//

#import "HLGroupImageViewController.h"
#import "GroupIDModel.h"
#import "HLGroupImageCollectionViewCell.h"
#import "GetDataBase.h"
#import "HLImageDetailViewController.h"
#import "HLShareViewController.h"
#import "HLPhotoViews.h"
@interface HLGroupImageViewController ()
{
    NSInteger realScreenWidth;
    NSInteger realScreenHeight;
}
@property (nonatomic, strong) UICollectionView *mainCollectionView;
@property (nonatomic, strong) NSMutableArray *objectArr;



@end

@implementation HLGroupImageViewController{
    NSMutableArray *_selectedArr;
}


-(void)loadView
{
    [super loadView];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createmainCollectionView];
    [self initWithFooterView:NO andHeaderView:YES andText:@"详情"];
    [self initModel];
    // Do any additional setup after loading the view.
}
-(void)initTitle:(NSInteger)count
{
    self.titleHeaderView.hidden = YES;
    UILabel *GroupNameLabel = [[UILabel alloc] init];
    GroupNameLabel.textColor = HLColor(142, 143, 144);
    GroupNameLabel.text = gainUserDefault(@"GroupName");
    GroupNameLabel.font = HLFont(18);
    [self.view addSubview:GroupNameLabel];
    [GroupNameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(20);
        make.top.equalTo(30);
        make.size.equalTo(CGSizeMake(SCREENWIDTH - 70, 22));
    }];
    
    UILabel *countLabel = [[UILabel alloc] init];
    countLabel.textColor = HLColor(71, 72, 73);
    countLabel.text = [NSString stringWithFormat:@"%ld个项目", count];
    //判断是否为英文
    if([gainUserDefault(@"language") isEqualToString:@"English"])
    {
       countLabel.text = [NSString stringWithFormat:@"%ld items", count];
    }
    countLabel.font = HLFont(14);
    [self.view addSubview:countLabel];
    [countLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(20);
        make.top.equalTo(GroupNameLabel.bottom).offset(0);
        make.size.equalTo(CGSizeMake(SCREENWIDTH - 70, 22));
    }];
    UIButton *shareBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [shareBtn setImage:[UIImage imageNamed:@"btn_分享"] forState:(UIControlStateNormal)];
    [shareBtn addTarget:self action:@selector(share) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:shareBtn];
    [shareBtn makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.right).offset(-20);
        make.centerY.equalTo(GroupNameLabel.bottom);
        make.size.equalTo(CGSizeMake(30, 30));
    }];
}
-(void)share
{
    //拼接链接地址，点击分享时传送地址
    NSString *shareAddress = [NSString stringWithFormat:@"http://%@.artp.cc/%@/artlist", gainUserDefault(@"userName"), gainUserDefault(@"GroupID")];
    KUserDefault(shareAddress, @"shareAddress");
    NSLog(@"shareAddress = %@", shareAddress);
    [self.navigationController pushViewController:[[HLShareViewController alloc] init] animated:YES];
}
-(void)createmainCollectionView
{
    //1.初始化layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //设置collectionView滚动方向
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    //2.初始化collectionView
    _mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 80, SCREENWIDTH, SCREENHEIGHT - 136) collectionViewLayout:layout];
    _mainCollectionView.backgroundColor = [UIColor clearColor];
    //3.注册collectionViewCell
    [_mainCollectionView registerClass:[HLGroupImageCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    //4.设置代理
    _mainCollectionView.delegate = self;
    _mainCollectionView.dataSource = self;
    [self.view addSubview:self.mainCollectionView];
}
-(NSMutableArray *)objectArr
{
    if(!_objectArr)
    {
        _objectArr = [[NSMutableArray alloc] initWithCapacity:1];
    }
    return _objectArr;
}

-(void)initModel
{
    NSString *Id = gainUserDefault(@"GroupID");
    NSDictionary *dic = @{@"GroupID":Id};
    _selectedArr = [NSMutableArray arrayWithCapacity:1];
    _selectedArr = [[GetDataBase shareDataBase] wzGetRecorderDataForTwoWithTableName:@"GroupIDModel" andDicitonary:dic];
    for(int i = 0; i < [_selectedArr count]; i++)
    {
        GroupIDModel *obj = [_selectedArr objectAtIndex:i];
        NSString *name = obj.ArtWorkID;
        NSDictionary *imageDic = @{@"ArtWorkID":name};
        NSMutableArray *imageModel = [[GetDataBase shareDataBase] wzGetRecorderDataForTwoWithTableName:@"ArtWorksByGroupModel" andDicitonary:imageDic];
        ArtWorksByGroupModel *artObj = [imageModel objectAtIndex:0];
        [self.objectArr addObject:artObj];
    }
    [self initTitle:[_selectedArr count]];
}
#pragma mark - UICollectionView
//返回section个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个section的item个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.objectArr count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ArtWorksByGroupModel *obj = [self.objectArr objectAtIndex:indexPath.row];
    HLGroupImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    [cell setModel:obj];
    return cell;
}

#pragma mark - 设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(SCREENWIDTH / 4, SCREENWIDTH / 4);
}
//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
} 
//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 3;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.selected = YES;
    
//    /*------     发送信息：当前点击的图片是第几张。 ------*/
    NSLog(@"%ld", indexPath.item);
    NSString *index = [NSString stringWithFormat:@"%ld", indexPath.item];
    KUserDefault(index, @"model.index");
    [self.navigationController pushViewController:[[HLImageDetailViewController alloc] init] animated:YES];
    
//    NSInteger i = [index integerValue];
//另一种做法
//    HLPhotoViews *photoView = [[HLPhotoViews alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) pageCount:[_selectedArr count] index:i objArr:_objectArr];
//    [[UIApplication sharedApplication].keyWindow addSubview:photoView];
}

@end
