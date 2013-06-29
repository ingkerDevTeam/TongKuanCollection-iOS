//
//  Model.m
//  PinkOK
//
//  Created by Beny on 13-5-19.
//  Copyright (c) 2013年 PinkOK. All rights reserved.
//

#import "Model.h"

@implementation Model

//通过请求加载数据
-(void)loadDataFromResponeData:(NSMutableDictionary *)responeData andRequestType:(RequestType)requestType
{
    
}


//保存缓存
-(void)saveCache:(NSMutableDictionary *)data withCacheId:(NSString *)cacheId
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:data forKey:cacheId];
    [defaults synchronize];
}

//通过缓存加载数据
-(NSMutableDictionary *)loadDataFromCacheWithCacheId:(NSString *)cacheId
{
    NSMutableDictionary *cacheData = [[NSUserDefaults standardUserDefaults] objectForKey:cacheId];

    return cacheData;
}

//清除缓存数据
-(void)clearCacheData
{
    
}

//从缓存加载数据
-(BOOL)loadDataFromCache
{
    return YES;
}

@end
