//
//  AssignToObject.h
//  GainProperty
//
//  Created by wangze on 13-7-18.
//  Copyright (c) 2013年 wangze. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface AssignToObject : NSObject

+ (id)propertyKeysWithString:(NSString *)classStr;
+ (id)reflectDataFromOtherObject:(id)dataSource andObjectStr:(NSString *)classStr;
//这个方法可以直接把从json中得到的数组中的字典转化为具体的对象，其里面都是封装好的具体对象。
+ (NSMutableArray *)customModel:(NSString *)modelClass ToArray:(id)array;

@end
