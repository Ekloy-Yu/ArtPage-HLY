//
//  HLindexTableViewCell.m
//  ArtPage
//
//  Created by 何龙 on 2018/9/20.
//  Copyright © 2018年 何龙. All rights reserved.
//

#import "HLindexTableViewCell.h"
#import "GetDataBase.h"
@implementation HLindexTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.backgroundColor = [UIColor clearColor];
        //headerImageView布局
        _headerImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_headerImageView];
        [_headerImageView makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(10);
            make.top.equalTo(10);
            make.size.equalTo(CGSizeMake(90, 90));
        }];
        //titleLabel
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = HLFont(18);
        _titleLabel.textColor = HLColor(142, 143, 144);
        [self.contentView addSubview:_titleLabel];
        [_titleLabel makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headerImageView.right).offset(10);
            make.top.equalTo(28);
            make.size.equalTo(CGSizeMake(SCREENWIDTH - 130, 18));
        }];
        //countLabel
        _countLabel = [[UILabel alloc] init];
        _countLabel.font = HLFont(10.5);
        _countLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:_countLabel];
        [_countLabel makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headerImageView.right).offset(10);
            make.top.equalTo(self.titleLabel.bottom).offset(6);
            make.size.equalTo(CGSizeMake(100, 12));
        }];
        //shareBtn
        UIButton *shareBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [shareBtn setImage:[UIImage imageNamed:@"btn_分享"] forState:(UIControlStateNormal)];
        [shareBtn addTarget:self action:@selector(share) forControlEvents:(UIControlEventTouchUpInside)];
        [self.contentView addSubview:shareBtn];
        [shareBtn makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.right).offset(-20);
            make.centerY.equalTo(self.centerY);
            make.size.equalTo(CGSizeMake(30, 30));
        }];
    }
    return self;
}
-(void)share
{
    if(_block)
    {
        _block(self);
    }
}
-(void)setModel:(PublicGroupModel *)obj
{
    UIImage *image;
    if([obj.GroupImage isEqualToString:@""])
    {
        image = [UIImage imageNamed:@"share"];
    }
    else
    {
        image= [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/Library/Caches/%@", NSHomeDirectory(), obj.GroupImage]];
        NSLog(@"obj.groupImage = %@", obj.GroupImage);
    }
    [self.headerImageView setImage:image];
    self.titleLabel.text = obj.GroupName_CN;
    //获取groupID
    NSString *groupID = obj.GroupID;
    NSDictionary *dic = @{@"GroupID":groupID};
    NSMutableArray *selectedArr = [NSMutableArray arrayWithCapacity:1];
    selectedArr = [[GetDataBase shareDataBase] wzGetRecorderDataForTwoWithTableName:@"GroupIDModel" andDicitonary:dic];
    NSInteger count = [selectedArr count];
    self.countLabel.text = [NSString stringWithFormat:@"%ld个项目", count];
    
    //判断是否为英文
    if([gainUserDefault(@"language") isEqualToString:@"English"])
    {
        self.titleLabel.text = obj.GroupName_EN;
        self.countLabel.text = [NSString stringWithFormat:@"%ld items", count];
    }
}
-(void)setECPModel:(ECPGroupModel *)obj
{
    NSLog(@"obj = %@", obj.GroupID);
    
    //获取groupID
    NSString *groupID = obj.GroupID;
    NSDictionary *dic = @{@"GroupID":groupID};
    NSMutableArray *selectedArr = [NSMutableArray arrayWithCapacity:1];
    selectedArr = [[GetDataBase shareDataBase] wzGetRecorderDataForTwoWithTableName:@"GroupIDModel" andDicitonary:dic];
    NSInteger count = [selectedArr count];
    self.countLabel.text = [NSString stringWithFormat:@"%ld个项目", count];
    
    //获取分组中第一张图片
    if(count != 0)
    {
        GroupIDModel *robj = [selectedArr objectAtIndex:0];
        NSString *name = robj.ArtWorkID;
        NSDictionary *imageDic = @{@"ArtWorkID":name};
        NSMutableArray *imageModel = [[GetDataBase shareDataBase] wzGetRecorderDataForTwoWithTableName:@"ArtWorksByGroupModel" andDicitonary:imageDic];
        ArtWorksByGroupModel *artObj = [imageModel objectAtIndex:0];
        UIImage *image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/Library/Caches/ECP/%@/%@.jpg", NSHomeDirectory(), obj.GroupID, artObj.ArtWorkID]];
        /** 判断是否有密码，如果有，让缩略图显示被加密 */
        if([obj.PWDON isEqualToString:@"1"])
        {
            image = [UIImage imageNamed:@"密码锁"];
        }
        [self.headerImageView setImage:image];
    }
    else
    {
        [self.headerImageView setImage:[UIImage imageNamed:@"没有图片提示"]];
    }
    
    self.titleLabel.text = obj.GroupName_CN;
    //判断是否为英文
    if([gainUserDefault(@"language") isEqualToString:@"English"])
    {
        self.titleLabel.text = obj.GroupName_EN;
        self.countLabel.text = [NSString stringWithFormat:@"%ld items", count];
    }
}


@end
