//
//  ECPGroupModel.h
//  ArtPage
//
//  Created by 何龙 on 2018/9/20.
//  Copyright © 2018年 何龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ECPGroupModel : NSObject
@property (nonatomic, strong) NSString *GroupID;
@property (nonatomic, strong) NSString *GroupName_CN;
@property (nonatomic, strong) NSString *GroupName_EN;
@property (nonatomic, strong) NSString *GroupImage;
@property (nonatomic, strong) NSString *Password;
@property (nonatomic, strong) NSString *GROUP_LASTUPDATEDATE;
@property (nonatomic, strong) NSString *GROUP_SORT;
@property (nonatomic, strong) NSString *isShow;
@property (nonatomic, strong) NSString *viewDate;
@property (nonatomic, strong) NSString *PWDON;
@property (nonatomic, strong) NSString *viewDateON;

@end
