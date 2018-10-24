//
//  ArtWorksByGroupModel.h
//  ArtPage
//
//  Created by 何龙 on 2018/9/20.
//  Copyright © 2018年 何龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArtWorksByGroupModel : NSObject
@property (nonatomic, strong) NSString *ArtWorkID;
@property (nonatomic, strong) NSString *ARTWORK_NAME_CN;
@property (nonatomic, strong) NSString *ARTWORK_NAME_EN;
@property (nonatomic, strong) NSString *ARTWORK_DESC_CN;
@property (nonatomic, strong) NSString *ARTWORK_DESC_EN;
@property (nonatomic, strong) NSString *ARTWORK_FILE_ORIGINAL;
@property (nonatomic, strong) NSString *ARTWORK_FILE_COMMON;
@property (nonatomic, strong) NSString *ARTWORK_THUMBNAIL;
@property (nonatomic, strong) NSString *ARTWORK_CREATEDATE;
@property (nonatomic, strong) NSString *ARKWORK_LASTUPDATEDATE;
@property (nonatomic, strong) NSString *ARTWORK_TAG;
@property (nonatomic, strong) NSString *ARTWORK_SORT;
@property (nonatomic, strong) NSString *ARTWORK_FILE_1600;
@end
