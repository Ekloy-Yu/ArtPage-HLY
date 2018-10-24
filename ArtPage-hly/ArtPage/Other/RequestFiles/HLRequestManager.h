//
//  HLRequestManager.h
//  ArtPage
//
//  Created by 何龙 on 2018/9/27.
//  Copyright © 2018年 何龙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"
#import "AFOwnerHTTPSessionManager.h"
@interface HLRequestManager : NSObject
//下载
+(void)Download:(NSString *)method
   andModelName:(NSString *)model
          andID:(NSString *)Id
         andArr:(NSMutableArray *)arr;
//下载关于相关数据
+(void)downloadGetAbout;

//下载作品相关数据
+(void)downloadArtPartArr:(NSMutableArray *)arr;

//下载图片
+(NSInteger)downloadPart:(dispatch_queue_t)queue
                   model:(NSString *)modelName
                    path:(NSString *)pathName
               imageType:(NSString *)imageType
                   count:(NSInteger)downCount
                sumCount:(NSInteger)sum
                   label:(UILabel *)label;

//返回总下载数量
+(NSInteger)modelnameArr:(NSArray *)arr;
//下载其他图片
+(void)GroupId;
@end
