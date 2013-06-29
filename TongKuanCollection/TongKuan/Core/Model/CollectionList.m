//
//  CollectionList.m
//  TongKuan
//
//  Created by Beny on 13-6-13.
//  Copyright (c) 2013年 TongKuan. All rights reserved.
//

#import "CollectionList.h"
#import "ProductModel.h"

@implementation CollectionList

-(void)loadDataFromResponeData:(NSMutableDictionary *)responeData andRequestType:(RequestType)requestType
{
    [super loadDataFromResponeData:responeData andRequestType:requestType];
    
    NSMutableDictionary *collectionlist = [responeData objectForKey:@"collection_list"];
    NSString *totalRecord = [NSString stringWithFormat:@"%@",[responeData objectForKey:@"count"]];//获取总记录数
    self.totalRecord = totalRecord.intValue;
    
    [self saveCache:responeData withCacheId:DFCacheCollectionlist];
    
    if (self.totalRecord > 0) {
        for (id object in collectionlist) {
            ProductModel *product = [[ProductModel alloc] init];
            [product loadDataFromResponeData:object andRequestType:requestType];
            
            [self.list addObject:product];
        }
    }
    
}

//从缓存加载数据
-(BOOL)loadDataFromCache
{
    [super loadDataFromCache];
    
    NSMutableDictionary *data = [self loadDataFromCacheWithCacheId:DFCacheCollectionlist];
    if (data) {
        [self loadDataFromResponeData:data andRequestType:RequestTypeGetProductlist];
        return YES;
    }
    else
        return NO;
    
}

@end
