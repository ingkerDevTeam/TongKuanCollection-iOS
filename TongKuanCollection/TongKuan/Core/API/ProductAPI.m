//
//  ProductAPI.m
//  TongKuan
//
//  Created by Beny on 13-5-22.
//  Copyright (c) 2013年 TongKuan. All rights reserved.
//

#import "ProductAPI.h"

@implementation ProductAPI

//获取商品列表
-(void)getProductlistOnPage:(NSInteger)page withCategoryId:(NSInteger)categoryId andUid:(NSString *)uid
{

    NSString *requestUrl = [NSString stringWithFormat:@"%@&mod=Product&act=getProductlist&limit=%d&page=%d&category_id=%d",DFRequestUrl,DFTimelineLimit,page,categoryId];
    if (uid) {
        requestUrl = [requestUrl stringByAppendingFormat:@"&uid=%@",uid];
    }
    NSLog(@"%@",requestUrl);
    NSURL *url = [NSURL URLWithString:requestUrl];
    self.request = [ASIFormDataRequest requestWithURL:url];
    self.requestType = RequestTypeGetProductlist;
    //[self performSelector:@selector(startASynchronousRequest) withObject:nil afterDelay:2.1];
    [self startASynchronousRequest];
}

//获取商品详情
-(void)getProductDetailWithProductId:(NSString *)productId andUid:(NSString *)uid
{
    NSString *requestUrl = [NSString stringWithFormat:@"%@&mod=Product&act=getProductInfo&product_id=%@",DFRequestUrl,productId];
    if (uid) {
        requestUrl = [requestUrl stringByAppendingFormat:@"&uid=%@",uid];
    }
    NSLog(@"%@",requestUrl);
    NSURL *url = [NSURL URLWithString:requestUrl];
    self.request = [ASIFormDataRequest requestWithURL:url];
    self.requestType = RequestTypeGetProductDetail;
    //[self performSelector:@selector(startASynchronousRequest) withObject:nil afterDelay:2.1];
    [self startASynchronousRequest];
}

//收藏商品
-(void)collectProductWithFeedId:(NSString *)feedId
{
    NSString *requestUrl = [NSString stringWithFormat:@"%@mod=Product&act=collect&feed_id=%@&uid=%@",DFRequestUrl,feedId,[UserModel getUid]];
    NSLog(@"%@",requestUrl);
    NSURL *url = [NSURL URLWithString:requestUrl];
    self.request = [ASIFormDataRequest requestWithURL:url];
    self.requestType = RequestTypeGetProductDetail;
    //[self performSelector:@selector(startASynchronousRequest) withObject:nil afterDelay:2.1];
    [self startASynchronousRequest];
}

//取消收藏商品
-(void)unCollectProductWithFeedId:(NSString *)feedId
{
    NSString *requestUrl = [NSString stringWithFormat:@"%@mod=Product&act=uncollect&feed_id=%@&uid=%@",DFRequestUrl,feedId,[UserModel getUid]];
    NSLog(@"%@",requestUrl);
    NSURL *url = [NSURL URLWithString:requestUrl];
    self.request = [ASIFormDataRequest requestWithURL:url];
    self.requestType = RequestTypeGetProductDetail;
    //[self performSelector:@selector(startASynchronousRequest) withObject:nil afterDelay:2.1];
    [self startASynchronousRequest];
}

//搜索商品列表
-(void)searchProductWithKey:(NSString *)searchKey OnPage:(NSInteger)page andUid:(NSString *)uid
{
    NSString *requestUrl = [NSString stringWithFormat:@"%@mod=Product&act=searchProduct&limit=%d&page=%d&searchkey=%@",DFRequestUrl,DFTimelineLimit,page,searchKey];
    if (uid) {
        requestUrl = [requestUrl stringByAppendingFormat:@"&uid=%@",uid];
    }
    requestUrl = [requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",requestUrl);
    NSURL *url = [NSURL URLWithString:requestUrl];
    self.request = [ASIFormDataRequest requestWithURL:url];
    self.requestType = RequestTypeSearchProduct;
    //[self performSelector:@selector(startASynchronousRequest) withObject:nil afterDelay:2.1];
    [self startASynchronousRequest];
}

@end
