//
//  ProductModel.h
//  TongKuan
//
//  Created by Beny on 13-5-22.
//  Copyright (c) 2013年 TongKuan. All rights reserved.
//

#import "Model.h"

@interface ProductModel : Model

//Productlist
@property (nonatomic,strong) NSString *productId;//商品ID
@property (nonatomic,strong) NSString *feedId;//动态ID
@property (nonatomic,strong) NSString *productName;//商品名称
@property (nonatomic,strong) NSString *description;//描述
@property (nonatomic,strong) NSString *price;//价格
@property (nonatomic,strong) NSString *collectionCount;//收藏总数
@property (nonatomic,assign) BOOL isCollected;//用户是否收藏
@property (nonatomic,strong) NSString *imageUrl;//大图连接

//Detail
@property (nonatomic,strong) NSString *buyUrl;
@property (nonatomic,strong) NSMutableArray *imagelist;//图片列表

@end
