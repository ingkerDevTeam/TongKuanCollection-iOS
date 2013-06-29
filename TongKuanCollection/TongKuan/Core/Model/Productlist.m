//
//  Productlist.m
//  TongKuan
//
//  Created by Beny on 13-5-22.
//  Copyright (c) 2013年 TongKuan. All rights reserved.
//

#import "Productlist.h"
#import "ProductModel.h"

@implementation Productlist


-(void)loadDataFromResponeData:(NSMutableDictionary *)responeData andRequestType:(RequestType)requestType
{
    [super loadDataFromResponeData:responeData andRequestType:requestType];
    
    NSMutableDictionary *productlist = [responeData objectForKey:@"product_list"];
    NSString *totalRecord = [NSString stringWithFormat:@"%@",[responeData objectForKey:@"count"]];//获取总记录数
    self.totalRecord = totalRecord.intValue;
    if (self.currentPage == 1 && self.categoryId == 0 && self.isSearching == NO) {
        [self saveCache:responeData withCacheId:DFCacheProductlist];
    }
        
    if (self.totalRecord > 0) {
        for (id object in productlist) {
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
    
    NSMutableDictionary *data = [self loadDataFromCacheWithCacheId:DFCacheProductlist];
    if (data) {
        [self loadDataFromResponeData:data andRequestType:RequestTypeGetProductlist];
        return YES;
    }
    else
        return NO;
    
}

@end
