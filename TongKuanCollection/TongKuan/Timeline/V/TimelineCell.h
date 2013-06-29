//
//  TimelineCell.h
//  TongKuan
//
//  Created by Beny on 13-5-21.
//  Copyright (c) 2013年 TongKuan. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface TimelineCell : UITableViewCell

@property (nonatomic,strong) id delegate;

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *collectionCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *collectButton;

//设置样式
-(void)setCellStyle;

@end


@protocol TimelineCellDelegate

-(void)timelineCell:(TimelineCell *)cell collectButtonPressedWithCollected:(BOOL)collected;


@end