//
//  NewsListModel.h
//  ArtPage
//
//  Created by 何龙 on 2018/9/22.
//  Copyright © 2018年 何龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsListModel : NSObject
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *NAME_CN;
@property (nonatomic, strong) NSString *NAME_EN;
@property (nonatomic, strong) NSString *CONTENT_CN;
@property (nonatomic, strong) NSString *CONTENT_EN;
@property (nonatomic, strong) NSString *IMAGE_URL;
@property (nonatomic, strong) NSString *SUBMIT_DATE;
@property (nonatomic, strong) NSString *CLICK;
@property (nonatomic, strong) NSString *LASTUPDATEDATE;
@end
