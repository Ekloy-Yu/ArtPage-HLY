//
//  HLindexTableViewCell.h
//  ArtPage
//
//  Created by 何龙 on 2018/9/20.
//  Copyright © 2018年 何龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PublicGroupModel.h"
@interface HLindexTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *headerImageView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *countLabel;

@property (nonatomic, strong) UIButton *btn;

typedef void(^shareBlock)(HLindexTableViewCell *cell);
@property (nonatomic, strong) shareBlock block;

-(void)setModel:(PublicGroupModel *)obj;

-(void)setECPModel:(ECPGroupModel *)obj;
@end
