//
//  HLImageDetailViewController.m
//  ArtPage
//
//  Created by 何龙 on 2018/10/8.
//  Copyright © 2018年 何龙. All rights reserved.
//

#import "HLImageDetailViewController.h"
#import "GetDataBase.h"
#import "HLBottomView.h"
#import "HLScrollPicture.h"
@interface HLImageDetailViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    /*------     实时的屏幕宽高 ------*/
    NSInteger realScreenWidth;
    NSInteger realScreenHeight;
}
/*------     collectionView相关对象。  ------*/
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *collectionViewDataSource;
@property (nonatomic, strong) UICollectionViewFlowLayout *collectionLayout;

/*------     总图片数 ------*/
@property (nonatomic, assign) NSInteger totalPage;

/*------     图片下标  ------*/
@property (nonatomic, assign) NSInteger index;

/*------     底部视图 ------*/
@property (nonatomic, strong) HLBottomView *bottomView;


@property (nonatomic, strong) HLScrollPicture *imageView;


@property (assign, nonatomic) CGFloat scale;//记录上次手势结束的放大倍数
@property (assign, nonatomic) CGFloat realScale;//当前手势应该放大的倍数
@end
// 注意const的位置
static NSString *const cellId = @"cellId";

@implementation HLImageDetailViewController
// 支持设备自动旋转
- (BOOL)shouldAutorotate
{
    return YES;
}

// 支持竖屏显示
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscapeLeft |UIInterfaceOrientationMaskLandscapeRight;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    /*------     接收index ------*/
    _index = [gainUserDefault(@"model.index")integerValue];
    realScreenWidth = SCREENWIDTH;
    realScreenHeight = SCREENHEIGHT;
    self.scale = 1;
    
    /*------     给数据源赋值。  ------*/
    [self initCollectionViewDataSource];
    [self.view addSubview:self.collectionView];
    
    //点击屏幕手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showWorkInfo)];
    [self.view addGestureRecognizer:tap];
    
    
    //添加捏合手势识别器，changeImageSize:方法实现图片的放大与缩小
    UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(changeImageSize:)];
    [self.view addGestureRecognizer:pinchRecognizer];
    
}
#pragma mark - 捏合手势
-(void)changeImageSize:(UIPinchGestureRecognizer *)pinch
{
    self.realScale = self.scale + (pinch.scale - 1);//当前的放大倍数是上次的放大倍数加上当前手势pinch程度
    
    if (self.realScale > 10) {//设置最大放大倍数
        self.realScale = 10;
    }else if (self.realScale < 1){//最小放大倍数
        self.realScale = 1;
    }
    
    self.collectionView.transform = CGAffineTransformMakeScale(self.realScale, self.realScale);

    if (pinch.state == UIGestureRecognizerStateEnded){//当结束捏合手势时记录当前图片放大倍数
        
        self.scale = self.realScale;
        
    }

    NSLog(@"%f-------%f",self.scale,self.realScale);
}

//显示或隐藏图片信息，点击手势事件
- (void)showWorkInfo
{
    self.bottomView.hidden = !self.bottomView.hidden;
//    self.imageView.frame = CGRectMake(0, 0, realScreenWidth, realScreenHeight);
}


#pragma mark - 给model赋值
- (void) initCollectionViewDataSource{
    self.collectionViewDataSource = [NSMutableArray arrayWithCapacity:1];
    NSString *Id = gainUserDefault(@"GroupID");
    NSDictionary *dic = @{@"GroupID":Id};
    NSMutableArray *selectedArr = [NSMutableArray arrayWithCapacity:1];
    selectedArr = [[GetDataBase shareDataBase] wzGetRecorderDataForTwoWithTableName:@"GroupIDModel" andDicitonary:dic];
    for(int i = 0; i < [selectedArr count]; i++)
    {
        GroupIDModel *obj = [selectedArr objectAtIndex:i];
        NSString *name = obj.ArtWorkID;
        NSDictionary *imageDic = @{@"ArtWorkID":name};
        NSMutableArray *imageModel = [[GetDataBase shareDataBase] wzGetRecorderDataForTwoWithTableName:@"ArtWorksByGroupModel" andDicitonary:imageDic];
        ArtWorksByGroupModel *artObj = [imageModel objectAtIndex:0];
        [self.collectionViewDataSource addObject:artObj];
    }
    _totalPage = [selectedArr count];
}

#pragma mark - 视图实例划
- (UICollectionView *) collectionView
{
    if (!_collectionView) {
        
        self.collectionLayout = [[UICollectionViewFlowLayout alloc]init];
        //水平滚动
        self.collectionLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        NSLog(@"初始化：%p",self.collectionLayout);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) collectionViewLayout:self.collectionLayout];
        self.collectionLayout.itemSize = CGSizeMake(SCREENWIDTH, SCREENHEIGHT);
        _collectionView.backgroundColor = [UIColor blackColor];
        //水平方向间隙
        _collectionLayout.minimumInteritemSpacing = 0;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        
        //注册cell 、sectionHeader、sectionFooter
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellId];
        _collectionView.contentOffset = CGPointMake(realScreenWidth * _index, 0);
    }
    return _collectionView;
}


#pragma mark ---- UICollectionViewDataSource

//返回组数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//返回每组的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.collectionViewDataSource.count;
}
//注册cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ArtWorksByGroupModel *obj = [self.collectionViewDataSource objectAtIndex:indexPath.row];
    NSString *path = [NSString stringWithFormat:@"%@/Library/Caches/%@Original/%@/", NSHomeDirectory(), gainUserDefault(@"model"), gainUserDefault(@"GroupID")];
    UIImage *image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@%@.jpg", path, obj.ArtWorkID]];
    _imageView = [[HLScrollPicture alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) andImage:image];
//    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    //初始化cell
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    //删除cell的所有子视图，避免重用时的残留
    while ([cell.contentView.subviews lastObject] != nil)
    {
        [[cell.contentView.subviews lastObject] removeFromSuperview];
    }
    //把imgView添加到cell上显示
    [cell.contentView addSubview:_imageView];
    return cell;
}
#pragma mark ----UICollectionViewDelegate
//该代理继承自UIScrollView
- (void)scrollViewDidEndDecelerating:(UICollectionView *)collectionView
{
    static NSInteger oldIndex;
    oldIndex = _index;
    _index = collectionView.contentOffset.x / realScreenWidth;
    NSLog(@"index = %ld",_index);
    NSLog(@"oldIndex = %ld", oldIndex);
    if(oldIndex == _index && [self.collectionViewDataSource count] > 1)
    {
        ;
    }
    else
    {
        [_imageView oldFrame:CGRectMake(0, 0, realScreenWidth, realScreenHeight)];
        self.scale  = 1;
        ArtWorksByGroupModel *obj = _collectionViewDataSource[_index];
        //初始化scrollView对象
        [_bottomView removeFromSuperview];
        if([gainUserDefault(@"language") isEqualToString:@"English"])
        {
            _bottomView = [[HLBottomView alloc] initWithFrame:CGRectZero titleLabel:obj.ARTWORK_NAME_EN contentLabel:obj.ARTWORK_DESC_EN width:realScreenWidth];
        }
        else
        {
            _bottomView = [[HLBottomView alloc] initWithFrame:CGRectZero titleLabel:obj.ARTWORK_NAME_CN contentLabel:obj.ARTWORK_DESC_CN width:realScreenWidth];
        }
        __weak typeof (self)weakSelf = self;
        _bottomView.block = ^(HLBottomView *view) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
        [self saveImage];
        [self.view addSubview:_bottomView];
        [_bottomView makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(0);
            make.left.equalTo(0);
            make.width.equalTo(self->realScreenWidth);
            make.height.equalTo(150);
        }];
        _bottomView.hidden = YES;
        [self showWorkInfo];
    }
}
-(void)saveImage
{
    __weak typeof (self)weakSelf = self;
    _bottomView.saveBlock = ^(HLBottomView *view) {
        ArtWorksByGroupModel *obj = weakSelf.collectionViewDataSource[weakSelf.index];
        //通过路径和文件名获取图片信息
        NSString *path = [NSString stringWithFormat:@"%@/Library/Caches/%@Original/%@/", NSHomeDirectory(), gainUserDefault(@"model"), gainUserDefault(@"GroupID")];
        UIImage *image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@%@.jpg", path, obj.ArtWorkID]];
        //保存图片
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, -50, SCREENWIDTH, 50)];
        label.backgroundColor = [[UIColor orangeColor] colorWithAlphaComponent:0.7];
        label.text = @"图片已保存";
        label.textAlignment = NSTextAlignmentCenter;
        label.font = HLFont(22);
        label.textColor = [UIColor whiteColor];
        [weakSelf.view addSubview:label];
        
        //为此label创建动画效果
//        CABasicAnimation *animation = [CABasicAnimation animation];
//        animation.keyPath = @"position.y";
//        animation.fromValue = @-50;
//        animation.toValue = @50;
//        animation.duration = 1;
//
//
//        [label.layer addAnimation:animation forKey:@"positon"];
//        label.layer.position = CGPointMake(SCREENWIDTH / 2, 50);
        
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            label.frame = CGRectMake(0, 0, SCREENWIDTH, 50);
        } completion:nil];
        [UIView animateWithDuration:0.5 delay:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            label.frame = CGRectMake(0, -50, SCREENWIDTH, 50);
        } completion:nil];
    };
}
#pragma mark ---- UICollectionViewDelegateFlowLayout

// 返回cell与Section之间的间隔
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
//每行cell的最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.f;
}
//每行cell的最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.f;
}

//屏幕旋转之后执行的方法
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    NSLog(@"%lf, %lf", size.width, size.height);
    
    realScreenWidth = size.width;
    realScreenHeight = size.height;
    self.collectionLayout.itemSize = CGSizeMake(realScreenWidth, realScreenHeight);
    _collectionView.frame = CGRectMake(0, 0, realScreenWidth, realScreenHeight);
    [_imageView updateFrame:CGRectMake(0, 0, realScreenWidth, realScreenHeight)];
    self.realScale = 1;
    _collectionView.contentOffset = CGPointMake(realScreenWidth * _index, 0);
    
    [_collectionView reloadData];
}


@end
