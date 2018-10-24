//
//  HLPhotoView.m
//  CollectionView进入照片查看器
//
//  Created by 何龙 on 2018/9/26.
//  Copyright © 2018年 何龙. All rights reserved.
//

#import "HLPhotoView.h"

@interface HLPhotoView ()
/** currentRect scrollView中对应cell在window中的位置 */
@property (assign, nonatomic) CGRect currentRect;

/** baseView 用来放置scrollView的容器 */
@property (weak, nonatomic) UIView *baseView;

/** currecntIndex scrollView中，当前图片的编号 */
@property (assign, nonatomic) NSInteger currecntIndex;
/** indexLabel 图片序号指示器 */
@property (weak, nonatomic) UILabel *indexLabel;

/** footerView 用来响应某些操作   **/
@property (nonatomic, strong) UIView *footerView;
/** bodyView  图片说明   **/
@property (nonatomic, strong) UIView *bodyView;
// scrollView的三张图片
/** leftImageView */
@property (weak, nonatomic) UIImageView *leftImageView;
/** centerImageView */
@property (weak, nonatomic) UIImageView *centerImageView;
/** rightImageView */
@property (weak, nonatomic) UIImageView *rightImageView;
@end

@implementation HLPhotoView
- (void)willMoveToSuperview:(UIView *)newSuperview {
    [self setupScrollView];
    [self createFooterView];
    [self createBodyView];
    self.bodyView.hidden = YES;
}
-(void)setupScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.bounds;
    [self addSubview:scrollView];
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.contentSize = CGSizeMake(SCREENWIDTH * 3, SCREENHEIGHT);
    scrollView.pagingEnabled = YES;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    [scrollView setContentOffset:CGPointMake(SCREENWIDTH, 0) animated:NO];
    scrollView.delegate = self;
    // 给scrollView添加手势，点击scrollView，大图缩小
    UITapGestureRecognizer *showFootView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewDidClick)];
    [scrollView addGestureRecognizer:showFootView];
    
    _scrollView = scrollView;
    
    //设置初始照片
    UIImage *centerImage = nil;
    UIImage *leftImage = nil;
    UIImage *rightImage = nil;
    NSString *path = [NSString stringWithFormat:@"%@/Library/Caches/%@Original/%@/", NSHomeDirectory(), gainUserDefault(@"model"), gainUserDefault(@"GroupID")];
    //如果点击的是第一张
    if(self.index == 0)
    {
        centerImage = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@%@.jpg", path, _iconArray[0]]];
        leftImage = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@%@.jpg", path, _iconArray[_iconArray.count - 1]]];
        rightImage = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@%@.jpg", path, _iconArray[1]]];
    }
    //如果点击的是最后一张
    else if(self.index == _iconArray.count - 1)
    {
        centerImage = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@%@.jpg", path, _iconArray[_iconArray.count - 1]]];
        leftImage = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@%@.jpg", path, _iconArray[_iconArray.count - 2]]];
        rightImage = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@%@.jpg", path, _iconArray[0]]];
    }
    else
    {
        centerImage = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@%@.jpg", path, _iconArray[self.index]]];
        leftImage = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@%@.jpg", path, _iconArray[self.index - 1]]];
        rightImage = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@%@.jpg", path, _iconArray[self.index + 1]]];
    }
    self.currecntIndex = self.index;
    self.currentRect = CGRectFromString(self.rectArray[self.index]);
    // 添加三个imageView，设置初始图片
    UIImageView *leftImageView = [[UIImageView alloc] init];
    CGFloat leftHeight = SCREENWIDTH / leftImage.size.width * leftImage.size.height;
    leftImageView.frame = CGRectMake(0, (SCREENHEIGHT - leftHeight)*0.5, SCREENWIDTH, leftHeight);
    leftImageView.image = leftImage;
    [scrollView addSubview:leftImageView];
    _leftImageView = leftImageView;
    
    UIImageView *centerImageView = [[UIImageView alloc] init];
    CGFloat centerHeight = SCREENWIDTH / centerImage.size.width * centerImage.size.height;
    centerImageView.frame = CGRectMake(SCREENWIDTH, (SCREENHEIGHT -centerHeight) * 0.5, SCREENWIDTH, centerHeight);
    centerImageView.image = centerImage;
    [scrollView addSubview:centerImageView];
    _centerImageView = centerImageView;
    
    UIImageView *rightImageView = [[UIImageView alloc] init];
    rightImageView.image = rightImage;
    CGFloat rightHeight = SCREENWIDTH / rightImage.size.width * rightImage.size.height;
    rightImageView.frame = CGRectMake(SCREENWIDTH * 2, (SCREENHEIGHT-rightHeight)*0.5, SCREENWIDTH, rightHeight);
    [scrollView addSubview:rightImageView];
    _rightImageView = rightImageView;
}
// 刷新iamgeView中的图片。难点：计算左中右的下标
- (void)refreshImages{
    NSString *path = [NSString stringWithFormat:@"%@/Library/Caches/%@Original/%@/", NSHomeDirectory(), gainUserDefault(@"model"), gainUserDefault(@"GroupID")];
    NSInteger leftImageIndex;
    NSInteger rightImageIndex;
    CGPoint offset = self.scrollView.contentOffset;
    // 向右滑动。这时候应该让currentIndex加1：即让currentIndex + 1的图片显示在屏幕上
    if (offset.x > SCREENWIDTH) {
        self.currecntIndex = (self.currecntIndex + 1) % self.iconArray.count;
    }
    // 向左滑动。这时候应该让currentIndex减1：即让currentIndex - 1的图片显示在屏幕上
    else if (offset.x < SCREENWIDTH) {
        self.currecntIndex = (self.currecntIndex + self.iconArray.count - 1) % self.iconArray.count;
    }
    
    leftImageIndex = (self.currecntIndex + self.iconArray.count - 1) % self.iconArray.count;
    rightImageIndex = (self.currecntIndex + 1) % self.iconArray.count;
    
    
    self.leftImageView.image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@%@.jpg", path, self.iconArray[leftImageIndex]]];
    self.centerImageView.image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@%@.jpg", path, self.iconArray[self.currecntIndex]]];
    self.rightImageView.image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@%@.jpg", path, self.iconArray[rightImageIndex]]];
    
    CGFloat leftHeight = SCREENWIDTH / self.leftImageView.image.size.width * self.leftImageView.image.size.height;
    CGFloat centerHeight = SCREENWIDTH / self.centerImageView.image.size.width * self.centerImageView.image.size.height;
    CGFloat rightHeight = SCREENWIDTH / self.rightImageView.image.size.width * self.rightImageView.image.size.height;
    self.leftImageView.frame = CGRectMake(0, (SCREENHEIGHT - leftHeight) * 0.5, SCREENWIDTH, leftHeight);
    self.centerImageView.frame = CGRectMake(SCREENWIDTH, (SCREENHEIGHT - centerHeight)*0.5, SCREENWIDTH, centerHeight);
    self.rightImageView.frame = CGRectMake(SCREENWIDTH * 2,  (SCREENHEIGHT -rightHeight) * 0.5, SCREENWIDTH, rightHeight);
    
    
    _currentRect = CGRectFromString(self.rectArray[self.currecntIndex]);
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    // 刷新imageView的图片
    [self refreshImages];
    // 把currentPageIndex立刻移到中间来
    [scrollView setContentOffset:CGPointMake(SCREENWIDTH, 0) animated:NO];
}
#pragma mark - footerview
-(void)createFooterView
{
    _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT - 70, SCREENWIDTH, 70)];
    _footerView.backgroundColor = [UIColor blackColor];
    _footerView.alpha = 0.5;
    [self addSubview:_footerView];
    NSArray *nameArr = @[@"btn_返回", @"btn_保存至相册"];
    for(int i = 0; i < 2; i++)
    {
        UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        btn.tag = i;
        [btn setImage:[UIImage imageNamed:nameArr[i]] forState:(UIControlStateNormal)];
        [btn addTarget:self action:@selector(btnSelected:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.footerView addSubview:btn];
        [btn makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.footerView.centerX).offset(i * 100 - 50);
            make.centerY.equalTo(self.footerView.centerY);
            if(i == 0)
            {
            make.size.equalTo(CGSizeMake(22, 35));
            }
            else
            {
                make.size.equalTo(CGSizeMake(55, 35));
            }
        }];
    }
}
#pragma mark - bodyView
-(void)createBodyView
{
    _bodyView = [[UIView alloc] init];
    _bodyView.backgroundColor = [UIColor blackColor];
    _bodyView.alpha = 0.4;
    [self addSubview:_bodyView];
    [_bodyView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.bottom.equalTo(self.footerView.top);
        make.size.equalTo(CGSizeMake(SCREENWIDTH, 200));
    }];
    UILabel *titleLable = [[UILabel alloc] init];
    titleLable.textColor = [UIColor grayColor];
    titleLable.text = @"图片详情";
    [self.bodyView addSubview:titleLable];
    [titleLable makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bodyView.top).offset(20);
        make.left.equalTo(self.bodyView.left).offset(20);
        make.size.equalTo(CGSizeMake(SCREENWIDTH - 40, 30));
    }];
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.textColor = [UIColor grayColor];
    contentLabel.text = @"并不是所有的爱情都能够走到最后，爱情中总是需要经历各种各样的磨难，只有在磨难当中不断增进相互间的了解，才能一直走到最后修得正果。但是许多人的爱情却只是问题不断，理解却一直无法促成，最后爱情被问题吞噬，两人一拍而散。";
    contentLabel.numberOfLines = 0;
    [self.bodyView addSubview:contentLabel];
    [contentLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLable.bottom).offset(0);
        make.left.equalTo(self.bodyView.left).offset(20);
        make.size.equalTo(CGSizeMake(SCREENWIDTH - 40, 150));
    }];
}
#pragma mark - 手势方法
- (void)scrollViewDidClick
{
    if(self.bodyView.hidden)
    {
        self.bodyView.hidden = NO;
    }
    else
    {
        self.bodyView.hidden = YES;
    }
}
-(void)btnSelected:(UIButton *)btn
{
    switch (btn.tag) {
        case 0:
            NSLog(@"0");
            [self.scrollView removeFromSuperview];
            [self removeFromSuperview];
            break;
        case 1:
            NSLog(@"1");
            break;
            
        default:
            break;
    }
}
#pragma mark - 界面滑动时执行的方法
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    NSLog(@"%lf, %lf", size.width, size.height);
    
//    realScreenWidth = size.width;
//    realScreenHeight = size.height;
    
    [self reuseScrollViewReversal];
}

-(void)reuseScrollViewReversal
{
//    self.baseView.scrollView.frame = CGRectMake(0, 0, realScreenWidth, realScreenHeight);
//    self.baseView.scrollView.contentSize = CGSizeMake(3 * realScreenWidth, realScreenHeight);
//    
//    //    CGPoint contentoffset = CGPointMake(realScreenWidth * imageIndex, 0);
//    //    ownScrollView.contentOffset = contentoffset;
//    
//    int i = 0;
//    for (UIView *imageView in [self.baseView.scrollView subviews])
//    {
//        if ([imageView isKindOfClass:[UIImageView class]])
//        {
//            imageView.frame = CGRectMake(i * realScreenWidth, 0, realScreenWidth, realScreenHeight);
//        }
//        ++i;
//    }
}
@end
