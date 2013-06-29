//
//  ProductDetailViewController.h
//  TongKuan
//
//  Created by Beny on 13-5-24.
//  Copyright (c) 2013年 TongKuan. All rights reserved.
//

#import "BaseViewController.h"
@class ProductModel;

@interface ProductDetailViewController : BaseViewController

//获取商品信息
-(void)getProductDetail:(ProductModel *)product;

@end
