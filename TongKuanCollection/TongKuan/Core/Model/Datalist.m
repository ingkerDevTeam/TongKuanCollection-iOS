//
//  Datalist.m
//  TongKuan
//
//  Created by Beny on 13-5-22.
//  Copyright (c) 2013年 TongKuan. All rights reserved.
//

#import "Datalist.h"

@implementation Datalist

-(NSMutableArray *)list
{
    if (!_list) {
        _list = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return _list;
}

//通过请求加载数据
-(void)loadDataFromResponeData:(NSMutableDictionary *)responeData andRequestType:(RequestType)requestType
{
    //若为刷新数据则清空数组
    if (self.isReloading == YES) {
        [self.list removeAllObjects];
        self.currentPage = 1;
    }
    
    if (self.list.count == 0) {
        self.currentPage = 1;
    }
    else
        self.currentPage++;
    
}

//返回计数
-(NSInteger)count
{
    return [self.list count];
}

//返回对象
-(id)objectAtIndex:(NSInteger)index
{
    return [self.list objectAtIndex:index];
}

//移除所有对象
-(void)removeAllObjects
{
    [self.list removeAllObjects];
}

//移除对象
-(void)removeObjectAtIndex:(NSInteger)index
{
    [self.list removeObjectAtIndex:index];
}

@end
