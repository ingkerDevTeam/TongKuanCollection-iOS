//
//  Model.h
//  PinkOK
//
//  Created by Beny on 13-5-19.
//  Copyright (c) 2013年 PinkOK. All rights reserved.
//  模型类

#import <Foundation/Foundation.h>

@interface Model : NSObject

//通过请求加载数据
-(void)loadDataFromResponeData:(NSMutableDictionary *)responeData andRequestType:(RequestType)requestType;;

//保存缓存
-(void)saveCache:(NSMutableDictionary *)data withCacheId:(NSString *)cacheId;

//通过缓存加载数据
-(NSMutableDictionary *)loadDataFromCacheWithCacheId:(NSString *)cacheId;

//从缓存加载数据
-(BOOL)loadDataFromCache;

//清除缓存数据
-(void)clearCacheData;

@end
