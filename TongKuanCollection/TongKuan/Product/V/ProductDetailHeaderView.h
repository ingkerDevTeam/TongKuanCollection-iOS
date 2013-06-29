//
//  ProductDetailHeaderView.h
//  TongKuan
//
//  Created by Beny on 13-5-24.
//  Copyright (c) 2013年 TongKuan. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ProductDetailHeaderView : UIView

@property (nonatomic,strong) id delegate;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *collectCountLabel;

//设置图片
-(void)setImagelist:(NSArray *)imagelist;

@end

@protocol ProductDetailHeaderViewDelegate <NSObject>

-(void)productDetailHeaderViewBuyButtonPressed;

@end
