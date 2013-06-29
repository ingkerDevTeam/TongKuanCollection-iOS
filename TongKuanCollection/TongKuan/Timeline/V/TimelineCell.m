//
//  TimelineCell.m
//  TongKuan
//
//  Created by Beny on 13-5-21.
//  Copyright (c) 2013年 TongKuan. All rights reserved.
//

#import "TimelineCell.h"
#import <QuartzCore/QuartzCore.h>

@interface TimelineCell()
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;



@end


@implementation TimelineCell

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        //NSLog(@"call");

    }

    return self;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
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

    //设置cell样式
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    //设置边框
    CALayer *layer = [self.backgroundImage layer];
    layer.borderColor = [[UIColor colorWithRed:190.0f/255.0f green:193.0f/255.0f blue:196.0f/255.0f alpha:1.0] CGColor];
    //layer.borderColor = [[UIColor grayColor] CGColor];
    layer.borderWidth = 1.0f;
    [layer setCornerRadius:4.0];
    
    self.priceLabel.textColor = [UIColor colorWithRed:87.0/255.0 green:150.0/255.0 blue:13.0/255.0 alpha:1.0];
    self.collectionCountLabel.textColor = [UIColor colorWithRed:181.0/255.0 green:181.0/255.0 blue:181.0/255.0 alpha:1.0];
}

- (IBAction)favoriteButtonPressed:(id)sender {    
    if ([self.delegate respondsToSelector:@selector(timelineCell:collectButtonPressedWithCollected:)]) {
        [self.delegate timelineCell:self collectButtonPressedWithCollected:!self.collectButton.selected];
    }
}
@end
