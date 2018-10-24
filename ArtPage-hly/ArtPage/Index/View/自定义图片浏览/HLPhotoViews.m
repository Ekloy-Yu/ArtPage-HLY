//
//  HLPhotoViews.m
//  ArtPage
//
//  Created by 何龙 on 2018/10/20.
//  Copyright © 2018 何龙. All rights reserved.
//

#import "HLPhotoViews.h"
#import "GetDataBase.h"
#import "HLScrollPicture.h"
static NSString *const cellId = @"cellId";
@implementation HLPhotoViews{
    NSMutableArray *_objectArr;
    NSInteger _index;
    NSInteger _totalPage;
    UICollectionViewFlowLayout *_collectionLayout;
    HLScrollPicture *_imageView;
}

-(id)initWithFrame:(CGRect)frame
         pageCount:(NSInteger)totalPage
             index:(NSInteger)index
            objArr:(nonnull NSMutableArray *)objectArr
{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor redColor];
        //接收index
        _index = [gainUserDefault(@"model.index")integerValue];;
        _totalPage = totalPage;
        _objectArr = objectArr;
        [self initCollectionView];
    }
    return self;
}
#pragma mark - initModel
//-(void)initModel
//{
//    _objectArr = [NSMutableArray arrayWithCapacity:1];
//    NSString *Id = gainUserDefault(@"GroupID");
//    NSDictionary *dic = @{@"GroupID":Id};
//    NSMutableArray *selectedArr = [NSMutableArray arrayWithCapacity:1];
//    selectedArr = [[GetDataBase shareDataBase] wzGetRecorderDataForTwoWithTableName:@"GroupIDModel" andDicitonary:dic];
//    for(int i = 0; i < [selectedArr count]; i++)
//    {
//        GroupIDModel *obj = [selectedArr objectAtIndex:i];
//        NSString *name = obj.ArtWorkID;
//        NSDictionary *imageDic = @{@"ArtWorkID":name};
//        NSMutableArray *imageModel = [[GetDataBase shareDataBase] wzGetRecorderDataForTwoWithTableName:@"ArtWorksByGroupModel" andDicitonary:imageDic];
//        ArtWorksByGroupModel *artObj = [imageModel objectAtIndex:0];
//        [_objectArr addObject:artObj];
//    }
//}

#pragma mark - 视图实例话
-(void)initCollectionView
{
    _collectionLayout = [[UICollectionViewFlowLayout alloc] init];
    //shuipinghuado
    _collectionLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _collectView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:_collectionLayout];
    _collectionLayout.itemSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
    _collectView.backgroundColor = [UIColor blackColor];
    //水平方向间隙
    _collectionLayout.minimumLineSpacing = 0;
    _collectView.delegate = self;
    _collectView.dataSource = self;
    _collectView.pagingEnabled = YES;
    
    //注册cell sectionHeader  sectionFooter
    [_collectView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellId];
//    _collectView.contentOffset = CGPointMake(self.frame.size.width * _index, 0);
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
    
    return _objectArr.count;
}
//注册cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ArtWorksByGroupModel *obj = [_objectArr objectAtIndex:indexPath.row];
    NSString *path = [NSString stringWithFormat:@"%@/Library/Caches/%@Original/%@/", NSHomeDirectory(), gainUserDefault(@"model"), gainUserDefault(@"GroupID")];
    UIImage *image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@%@.jpg", path, obj.ArtWorkID]];
    _imageView = [[HLScrollPicture alloc] initWithFrame:self.frame andImage:image];
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




-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self removeFromSuperview];
}
@end
