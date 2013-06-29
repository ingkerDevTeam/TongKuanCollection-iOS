//
//  ProductModel.m
//  TongKuan
//
//  Created by Beny on 13-5-22.
//  Copyright (c) 2013年 TongKuan. All rights reserved.
//

#import "ProductModel.h"
#import "JSONKit.h"

@implementation ProductModel

-(void)loadDataFromResponeData:(NSMutableDictionary *)responeData andRequestType:(RequestType)requestType
{
    [super loadDataFromResponeData:responeData andRequestType:requestType];
    
    self.productId = [NSString stringWithFormat:@"%@",[responeData objectForKey:@"product_id"]];
    self.feedId = [NSString stringWithFormat:@"%@",[responeData objectForKey:@"feed_id"]];
    self.productName = [NSString stringWithFormat:@"%@",[responeData objectForKey:@"product_name"]];
    self.description = [NSString stringWithFormat:@"%@",[responeData objectForKey:@"description"]];
    self.collectionCount = [NSString stringWithFormat:@"%@",[responeData objectForKey:@"collection_count"]];
    self.price = [NSString stringWithFormat:@"￥%@",[responeData objectForKey:@"price"]];
    NSString *isCollected = [NSString stringWithFormat:@"%@",[responeData objectForKey:@"is_collected"]];
    self.isCollected = isCollected.boolValue;
    self.imageUrl = [NSString stringWithFormat:@"%@",[responeData objectForKey:@"image_url"]];
    
    if (requestType == RequestTypeGetProductDetail) {
        self.buyUrl = [NSString stringWithFormat:@"%@",[responeData objectForKey:@"buy_url"]];
        //NSLog(@"购买连接%@",self.buyUrl);
        NSMutableDictionary *imagelist = [responeData objectForKey:@"imagelist"];
        
        self.imagelist = [[NSMutableArray alloc] initWithCapacity:0];
        for (id object in imagelist) {
            NSString *imageUrl = [NSString stringWithFormat:@"%@",object];
            [self.imagelist addObject:imageUrl];
            //NSLog(@"%@",imageUrl);
        }
        
    }
    
}

@end
