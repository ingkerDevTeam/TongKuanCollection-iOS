//
//  MyCollectionCell.h
//  TongKuan
//
//  Created by Beny on 13-6-13.
//  Copyright (c) 2013年 TongKuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCollectionCell : UITableViewCell
@property (strong, nonatomic) UIImageView *thumbnail;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *priceLabel;

//设置样式
-(void)setCellStyle;

@end
