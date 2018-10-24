//
//  HLRequestManager.m
//  ArtPage
//
//  Created by 何龙 on 2018/9/27.
//  Copyright © 2018年 何龙. All rights reserved.
//

#import "HLRequestManager.h"
#import "GetDataBase.h"
#import "GroupIDModel.h"
@interface HLRequestManager()

@end
@implementation HLRequestManager
#pragma make - 下载关于相关数据
+(void)downloadGetAbout
{
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.completionQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        //信号量的值为0时表示会阻塞当前的线程，为其它数值时表示当前允许执行任务的并发数量
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
            [manager GET:[NSString stringWithFormat:@"http://www.artp.cc/pages/jsonService/jsonForIPad.aspx?Method=GetAbout&UserID=%@", gainUserDefault(@"userId")] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [[GetDataBase shareDataBase] wzDeleteReCordFromTableName:@"GetAboutModel"];
//                [[GetDataBase shareDataBase] wzInsertRecorderDataWithTableName:@"GetAboutModel" valuesDictionary:[[responseObject objectForKey:@"data"] objectAtIndex:0]];
                [[GetDataBase shareDataBase] insertRecorderDataWithTableName:@"GetAboutModel" andModel:[[responseObject objectForKey:@"data"] objectAtIndex:0]];
                NSLog(@"关于%@", [[responseObject objectForKey:@"data"] objectAtIndex:0]);
//                NSLog(@"about = %@", [responseObject objectForKey:@"data"]);
                dispatch_semaphore_signal(semaphore);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                dispatch_semaphore_signal(semaphore);
            }];
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);  //等待
}
#pragma mark - 自定义下载部分代码优化

+(void)Download:(NSString *)method
      andModelName:(NSString *)model
             andID:(NSString *)Id
            andArr:(NSMutableArray *)arr
{
        //开始下载并且获取公开作品的groupID---------------------
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.completionQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        //信号量的值为0时表示会阻塞当前的线程，为其它数值时表示当前允许执行任务的并发数量
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        [manager GET:[NSString stringWithFormat:@"http://www.artp.cc/pages/jsonService/jsonForIPad.aspx?Method=%@&UserID=%@", method, gainUserDefault(@"userId")] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //判断数据库某些数据是否存在
            NSArray *objArr = responseObject[@"data"];
    /*--------判断数据库是否包含多余信息----------*/
            //获取数据库中的modelarr
            NSMutableArray *modelArr = [NSMutableArray arrayWithCapacity:1];
            modelArr = [[GetDataBase shareDataBase] wzGainTableRecoderID:model];
            for(int k = 0; k < [modelArr count]; k++)
            {
                NSInteger count = 0;
                //找到数据库中当前model的id
                int modelId = [[[modelArr objectAtIndex:k] valueForKey:Id] intValue];
                for(int j = 0; j < [objArr count]; j++)
                {
                    count++;
                    int gainId = [[[objArr objectAtIndex:j] valueForKey:Id] intValue];
//                    NSLog(@"gainId = %d", gainId);
                    if(modelId == gainId)
                    {
                        count = 200;//附一个不可能存在的值。
                        break;
                    }
                }
                if(count == [objArr count])
                {
                    
                    //删除数据库中此条信息
                    NSString *modelID = [NSString stringWithFormat:@"%d", modelId];
                    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:1];
                    NSDictionary *dicc = @{Id:modelID};
                    [dic addEntriesFromDictionary:dicc];
                    [[GetDataBase shareDataBase] wzDeleteRecordDataWithTableName:model andDictionary:dic];
                    //删除本地文件中的此条信息。
                    NSFileManager *fm = [NSFileManager defaultManager];
                    NSString * docsdir = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                    NSString *dataFilePath1 = [docsdir stringByAppendingPathComponent:[NSString stringWithFormat:@"/Caches/Public/%@", modelID]];
                    NSString *dataFilePath2 = [docsdir stringByAppendingPathComponent:[NSString stringWithFormat:@"/Caches/PublicOriginal/%@", modelID]];
                    NSString *dataFilePath3 = [docsdir stringByAppendingPathComponent:[NSString stringWithFormat:@"/Caches/ECP/%@", modelID]];
                    NSString *dataFilePath4 = [docsdir stringByAppendingPathComponent:[NSString stringWithFormat:@"/Caches/ECPOriginal/%@", modelID]];
                    [fm removeItemAtPath:dataFilePath1 error:nil];
                    [fm removeItemAtPath:dataFilePath2 error:nil];
                    [fm removeItemAtPath:dataFilePath3 error:nil];
                    [fm removeItemAtPath:dataFilePath4 error:nil];
                    
                }
                else
                {
                    
                }
            }
            
        /*--------- 暴力更新数据库----------*/
//            [[GetDataBase shareDataBase] wzDeleteReCordFromTableName:model];
//            [[GetDataBase shareDataBase] insertRecorderDataWithTableName:model andModel:[responseObject objectForKey:@"data"]];
            for(int i = 0; i < [objArr count]; i++)
            {
                if(![[GetDataBase shareDataBase] isExistTable:model andObject:[[responseObject objectForKey:@"data"] objectAtIndex:i] andObjectAtIndex:0])
                {
                    [[GetDataBase shareDataBase] insertRecorderDataWithTableName:model andModel:[[responseObject objectForKey:@"data"] objectAtIndex:i]];
                }
                else
                {
                    /** 判断是否被修改，如果被修改，update，如果没有，跳过  */
//                    NSLog(@"update %@", [[responseObject objectForKey:@"data"] objectAtIndex:i]);
                }
                //获得groupId
                NSString *groupId = [objArr[i] objectForKey:Id];
                [arr addObject:groupId];
            }
            dispatch_semaphore_signal(semaphore);//不管请求状态是什么，都得发送信号，否则会一直卡着进程
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            dispatch_semaphore_signal(semaphore);//不管请求状态是什么，都得发送信号，否则会一直卡着进程
        }];
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);  //等待
}
#pragma mark - 下载作品相关数据--------------------
+(void)downloadArtPartArr:(NSMutableArray *)arr
{
    //用groupId下载相关数据-----------------------------
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.completionQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        for(int i = 0; i < [arr count]; i++)
        {
            dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
            NSString *url = [NSString stringWithFormat:@"http://www.artp.cc/pages/jsonService/jsonForIPad.aspx?Method=GetArtWorksByGroup&GroupID=%@", arr[i]];
            [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
             {
                 NSArray *objArr = responseObject[@"data"];
                 /*--------判断数据库是否包含多余信息----     start------*/
                 //先获取artID数组
                 NSDictionary *artIdDic = @{@"GroupID":arr[i]};
                 NSMutableArray *artIdMutablArr = [NSMutableArray arrayWithCapacity:1];
                 artIdMutablArr = [[GetDataBase shareDataBase] wzGetRecorderDataForTwoWithTableName:@"GroupIDModel" andDicitonary:artIdDic];
//                 NSLog(@"artIdarr = %@", artIdMutablArr);
                 //获取数据库中的modelarr
                 NSMutableArray *modelArr = [NSMutableArray arrayWithCapacity:1];
                 //添加modelArr
                 for(int zz = 0; zz < [artIdMutablArr count]; zz++)
                 {
                     //取出id
                     NSString *artId = [[artIdMutablArr objectAtIndex:zz] valueForKey:@"ArtWorkID"];
                     NSDictionary *tempDic = @{@"ArtWorkID":artId};
                     [modelArr addObject:[[[GetDataBase shareDataBase] wzGetRecorderDataForTwoWithTableName:@"ArtWorksByGroupModel" andDicitonary:tempDic] objectAtIndex:0]];
                 }
                 
                 
                 
                 for(int j = 0; j < [modelArr count]; j++)
                 {
                     NSInteger count = 0;
                     //找到数据库中当前model的id
                     int modelId = [[[modelArr objectAtIndex:j] valueForKey:@"ArtWorkID"] intValue];

//                     NSLog(@"modelId = %d", modelId);
                     for(int k = 0; k < [objArr count]; k++)
                     {
                         count++;
                         int gainId = [[[objArr objectAtIndex:k] valueForKey:@"ArtWorkID"] intValue];
//                         NSLog(@"gainId = %d", gainId);
                         if(modelId == gainId)
                         {
                             count = 200;
                             break;
                         }
                     }
                     if(count == [objArr count])
                     {
//                         NSLog(@"delete");
                         /*----------------删除数据库中此条信息------------*/
                         NSString *modelID = [NSString stringWithFormat:@"%d", modelId];
                         NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:1];
                         NSDictionary *dicc = @{@"ArtWorkID":modelID};
                         [dic addEntriesFromDictionary:dicc];
                         [[GetDataBase shareDataBase] wzDeleteRecordDataWithTableName:@"ArtWorksByGroupModel" andDictionary:dic];
                         [[GetDataBase shareDataBase] wzDeleteRecordDataWithTableName:@"GroupIDModel" andDictionary:dic];
                         /*----------------删除本地文件中此条信息------------*/
                         NSFileManager *fm = [NSFileManager defaultManager];
                         NSString * docsdir = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                         NSString *dataFilePath1 = [docsdir stringByAppendingPathComponent:[NSString stringWithFormat:@"/Caches/Public/%@/%@.jpg", arr[i], modelID]];
                         NSString *dataFilePath2 = [docsdir stringByAppendingPathComponent:[NSString stringWithFormat:@"/Caches/PublicOriginal/%@/%@.jpg", arr[i], modelID]];
                         NSString *dataFilePath3 = [docsdir stringByAppendingPathComponent:[NSString stringWithFormat:@"/Caches/ECP/%@/%@.jpg", arr[i], modelID]];
                         NSString *dataFilePath4 = [docsdir stringByAppendingPathComponent:[NSString stringWithFormat:@"/Caches/ECPOriginal/%@/%@.jpg", arr[i], modelID]];
                         [fm removeItemAtPath:dataFilePath1 error:nil];
                         [fm removeItemAtPath:dataFilePath2 error:nil];
                         [fm removeItemAtPath:dataFilePath3 error:nil];
                         [fm removeItemAtPath:dataFilePath4 error:nil];
                     }
                     else
                     {
//                         NSLog(@"不删除");
                     }
                 }
                 /*--------判断数据库是否包含多余信息----     start------*/
                 /*--------- 暴力更新数据库---start-------*/
//                 [[GetDataBase shareDataBase] wzDeleteReCordFromTableName:@"ArtWorksByGroupModel"];
//                 [[GetDataBase shareDataBase] insertRecorderDataWithTableName:@"ArtWorksByGroupModel" andModel:[responseObject objectForKey:@"data"]];
//
//                 [[GetDataBase shareDataBase] wzDeleteReCordFromTableName:@"GroupIDModel"];
                 /*--------- 暴力更新数据库-----end-----*/
                 
                 for(int z = 0; z < [objArr count]; z++)
                 {
                     if(![[GetDataBase shareDataBase] isExistTable:@"ArtWorksByGroupModel" andObject:[[responseObject objectForKey:@"data"] objectAtIndex:z] andObjectAtIndex:0])
                     {
                         //利用groupID和imageId创建一张表
                         NSDictionary *dic = @{@"GroupID":arr[i], @"ArtWorkID":[[[responseObject objectForKey:@"data"] objectAtIndex:z] objectForKey:@"ArtWorkID"]};
                         [[GetDataBase shareDataBase] insertRecorderDataWithTableName:@"GroupIDModel" andModel:dic];
                         [[GetDataBase shareDataBase] insertRecorderDataWithTableName:@"ArtWorksByGroupModel" andModel:[[responseObject objectForKey:@"data"] objectAtIndex:z]];
                     }
                 }
                 dispatch_semaphore_signal(semaphore);//不管请求状态是什么，都得发送信号，否则会一直卡着进程
             } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                 dispatch_semaphore_signal(semaphore);//不管请求状态是什么，都得发送信号，否则会一直卡着进程
             }];
            dispatch_semaphore_wait(semaphore,DISPATCH_TIME_FOREVER);  //等待
        }
}

#pragma mark - 下载图片至本地路径
+(NSInteger)downloadPart:(dispatch_queue_t)queue
                   model:(NSString *)modelName
                    path:(NSString *)pathName
               imageType:(NSString *)imageType
                   count:(NSInteger)downCount
                sumCount:(NSInteger)sum
                   label:(UILabel *)label
{
    NSInteger hadDownCount = 0;
    __block NSInteger count = 0;
    //用数据库中的图片链接地址下载图片并保存-------------------------
        /**。      获取图片数组------------**/
        NSArray *GroupIDArr = [[[GetDataBase shareDataBase] wzGainTableRecoderID:modelName] valueForKey:@"GroupID"];
        //创建文件路径
        NSString *docsdir = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        for(int g = 0; g < [GroupIDArr count]; g++)
        {
//            NSLog(@"groupIDarr count = %ld", [GroupIDArr count]);
            /*---------存放文件命名的数组---------------*/
            NSMutableArray *fileNameArr = [NSMutableArray arrayWithCapacity:1];
            /*---------存放下载地址的数组---------------*/
            NSMutableArray *downArr = [NSMutableArray arrayWithCapacity:1];
            /*---------存放下载路径的数组---------------*/
            NSString *dataFilePath = [docsdir stringByAppendingPathComponent:[NSString stringWithFormat:@"/Caches/%@/%@", pathName, GroupIDArr[g]]];
            // 在Libary目录下创建 "文件目录" 文件夹
            BOOL isDir = NO;
            // fileExistsAtPath 判断一个文件或目录是否有效，isDirectory判断是否一个目录
            BOOL existed = [fileManager fileExistsAtPath:dataFilePath isDirectory:&isDir];
            if (!(isDir && existed)) {
                // 在Document目录下创建一个archiver目录
                [fileManager createDirectoryAtPath:dataFilePath withIntermediateDirectories:YES attributes:nil error:nil];
            }
            /*---------找到相应图片---------------*/
            NSDictionary *dic = @{@"GroupID":GroupIDArr[g]};
            NSMutableArray *selectedArr = [NSMutableArray arrayWithCapacity:1];
            selectedArr = [[GetDataBase shareDataBase] wzGetRecorderDataForTwoWithTableName:@"GroupIDModel" andDicitonary:dic];
            hadDownCount+= [selectedArr count];
            for(int j = 0; j < [selectedArr count]; j++)
            {
                GroupIDModel *obj = [selectedArr objectAtIndex:j];
                NSString *name = obj.ArtWorkID;
                NSDictionary *imageDic = @{@"ArtWorkID":name};
                NSMutableArray *imageModel = [[GetDataBase shareDataBase] wzGetRecorderDataForTwoWithTableName:@"ArtWorksByGroupModel" andDicitonary:imageDic];
                ArtWorksByGroupModel *artobj = [imageModel objectAtIndex:0];
                if([imageType isEqualToString:@"原图"])
                {
                    [downArr addObject:artobj.ARTWORK_FILE_ORIGINAL];
                }
                else
                {
                    [downArr addObject:artobj.ARTWORK_THUMBNAIL];
                }
                [fileNameArr addObject:artobj.ArtWorkID];
            }
            /*---------开始下载---------------*/
            AFOwnerHTTPSessionManager *manager = [AFOwnerHTTPSessionManager shareManager];
            manager.completionQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            for (int i = 0; i < [downArr count]; ++i)
            {
                dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
//                NSLog(@"downArr count = %ld", [downArr count]);
//                NSLog(@"count = %ld, downcount = %ld", count, downCount);
                count++;
        /*---------判断是否在本地存在---------------*/
                //获取文件保存在沙盒下的路径
                NSString *imgPath = [NSString stringWithFormat:@"%@/%@.jpg", dataFilePath, fileNameArr[i]];
                NSData *imgData = [NSData dataWithContentsOfFile:imgPath];
                if(imgData)
                {
                    float pro = (downCount + count) * 1.0 / sum;
                    //回到主线程渲染ui   --------
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSString *z = @"%";
                        label.text = [NSString stringWithFormat:@"%.0f%@", pro * 100, z];
                    });
                }
                else
                {
                    [manager downloadFileURL:[NSString stringWithFormat:@"http://www.artp.cc/%@", downArr[i]] filesavePath:dataFilePath fileName:[NSString stringWithFormat:@"%@.jpg", fileNameArr[i]] progress:^(NSProgress *downloadProgress) {
                        dispatch_semaphore_signal(semaphore);//不管请求状态是什么，都得发送信号，否则会一直卡着进程
                    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
                        if([AFOwnerHTTPSessionManager shareManager].urlSessionManager.tasks.count == 0)
                        {
                            NSLog(@"下载完成");
                            NSLog(@"downCount = %ld", downCount + count);
                            label.text = [NSString stringWithFormat:@"%.2ld%%", (downCount + count) / sum * 100];
                        }
                        else
                        {
                            float pro = (downCount + count) * 1.0 / sum;
                            NSLog(@"下载进度:%f", pro);
                            NSString *z = @"%";
                            label.text = [NSString stringWithFormat:@"%.0f%@", pro * 100, z];
                        }
                        dispatch_semaphore_signal(semaphore);//不管请求状态是什么，都得发送信号，否则会一直卡着进程
                    }];
                    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);  //等待
                }
            }
        }
    return hadDownCount;
}
#pragma mark - 获取总下载量
+(NSInteger)modelnameArr:(NSArray *)arr
{
    NSInteger sumCount = 0;
    for(int i = 0; i < [arr count]; i++)
    {
        NSArray *GroupIDArr = [[[GetDataBase shareDataBase] wzGainTableRecoderID:arr[i]] valueForKey:@"GroupID"];
        for(int j = 0; j < [GroupIDArr count]; j++)
        {
            NSDictionary *dic = @{@"GroupID":GroupIDArr[j]};
            NSMutableArray *selectedArr = [NSMutableArray arrayWithCapacity:1];
            selectedArr = [[GetDataBase shareDataBase] wzGetRecorderDataForTwoWithTableName:@"GroupIDModel" andDicitonary:dic];
            /** count * 2的原因是需要下载原图以及缩略图  */
            sumCount+= [selectedArr count] * 2;
        }
    }
    return sumCount;
}
#pragma mark - 下载其他相关图片
+(void)GroupId
{
    AFOwnerHTTPSessionManager *manager = [AFOwnerHTTPSessionManager shareManager];
    NSMutableArray *downloadArr = [NSMutableArray arrayWithCapacity:1];
    /**。      获取图片数组------------**/
    NSArray *publicArr = [[[GetDataBase shareDataBase] wzGainTableRecoderID:@"PublicGroupModel"] valueForKey:@"GroupImage"];
    NSArray *ECPArr = [[[GetDataBase shareDataBase] wzGainTableRecoderID:@"ECPGroupModel"] valueForKey:@"GroupImage"];
    NSArray *NewsListURLarr = [[[GetDataBase shareDataBase] wzGainTableRecoderID:@"NewsListModel"] valueForKey:@"IMAGE_URL"];
    NSArray *aboutArr = [[[GetDataBase shareDataBase] wzGainTableRecoderID:@"GetAboutModel"] valueForKey:@"ARTIST_IMAGE"];
    [downloadArr addObjectsFromArray:publicArr];
    [downloadArr addObjectsFromArray:ECPArr];
    [downloadArr addObjectsFromArray:NewsListURLarr];
    [downloadArr addObjectsFromArray:aboutArr];
    manager.completionQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    NSLog(@"downloatArr = %@", downloadArr);
    //创建文件路径-------------------------------------
    NSString * docsdir = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *dataFilePath = [docsdir stringByAppendingPathComponent:@"/Caches"];
        for (int i = 0; i < [downloadArr count]; ++i)
        {
                //信号量的值为0时表示会阻塞当前的线程，为其它数值时表示当前允许执行任务的并发数量
                dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
                [manager downloadFileURL:[NSString stringWithFormat:@"http://www.artp.cc/%@", downloadArr[i]] filesavePath:dataFilePath fileName:downloadArr[i] progress:^(NSProgress *downloadProgress) {
                    dispatch_semaphore_signal(semaphore);//不管请求状态是什么，都得发送信号，否则会一直卡着进程
                } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
                    dispatch_semaphore_signal(semaphore);//不管请求状态是什么，都得发送信号，否则会一直卡着进程
                }];
                
                dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);  //等待
    }
}
@end
