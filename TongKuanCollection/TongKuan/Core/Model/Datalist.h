//
//  Datalist.h
//  TongKuan
//
//  Created by Beny on 13-5-22.
//  Copyright (c) 2013年 TongKuan. All rights reserved.
//

#import "Model.h"

@interface Datalist : Model

@property (nonatomic,assign) NSInteger currentPage;//当前页
@property (nonatomic,assign) NSInteger totalRecord;//数据库中所有记录总数
@property (nonatomic,strong) NSMutableArray *list;//数据列表
@property (nonatomic,assign) BOOL isReloading;//是否为重新加载数据



//NSMutableArray
//返回计数
-(NSInteger)count;
//返回对象
-(id)objectAtIndex:(NSInteger)index;
//移除所有对象
-(void)removeAllObjects;
//移除对象
-(void)removeObjectAtIndex:(NSInteger)index;

@end
