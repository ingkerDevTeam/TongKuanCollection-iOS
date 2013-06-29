//
//  ProductAPI.h
//  TongKuan
//
//  Created by Beny on 13-5-22.
//  Copyright (c) 2013年 TongKuan. All rights reserved.
//

#import "BaseAPI.h"

@interface ProductAPI : BaseAPI

//获取商品列表
-(void)getProductlistOnPage:(NSInteger)page withCategoryId:(NSInteger)categoryId andUid:(NSString *)uid;
//获取商品详情
-(void)getProductDetailWithProductId:(NSString *)productId andUid:(NSString *)uid;
//收藏商品
-(void)collectProductWithFeedId:(NSString *)feedId;
//取消收藏商品
-(void)unCollectProductWithFeedId:(NSString *)feedId;
//搜索商品列表
-(void)searchProductWithKey:(NSString *)searchKey OnPage:(NSInteger)page andUid:(NSString *)uid;
@end
