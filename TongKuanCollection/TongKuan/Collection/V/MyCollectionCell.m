//
//  MyCollectionCell.m
//  TongKuan
//
//  Created by Beny on 13-6-13.
//  Copyright (c) 2013年 TongKuan. All rights reserved.
//

#import "MyCollectionCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation MyCollectionCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.thumbnail = [[UIImageView alloc] initWithFrame:CGRectMake(11, 10, 60, 60)];
        [self.contentView addSubview:self.thumbnail];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(88, 10, 212, 39)];
        self.nameLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.nameLabel.font = [UIFont systemFontOfSize:14];
        self.nameLabel.numberOfLines = 2;
        [self.contentView addSubview:self.nameLabel];
        
        self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(88, 49, 58, 21)];
        self.priceLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.priceLabel];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)setCellStyle
{
    //设置边框
    CALayer *layer = [self.thumbnail layer];
    layer.borderColor = [[UIColor colorWithRed:190.0f/255.0f green:193.0f/255.0f blue:196.0f/255.0f alpha:1.0] CGColor];
    //layer.borderColor = [[UIColor grayColor] CGColor];
    layer.borderWidth = 1.0f;
    
    self.priceLabel.textColor = [UIColor colorWithRed:87.0/255.0 green:150.0/255.0 blue:13.0/255.0 alpha:1.0];
}

@end
