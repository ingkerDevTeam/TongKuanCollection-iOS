//
//  Productlist.h
//  TongKuan
//
//  Created by Beny on 13-5-22.
//  Copyright (c) 2013年 TongKuan. All rights reserved.
//

#import "Datalist.h"

@interface Productlist : Datalist

@property (nonatomic,assign) NSInteger categoryId;//分类的id
@property (nonatomic,assign) BOOL isSearching;//判断是否为搜索列表



@end
