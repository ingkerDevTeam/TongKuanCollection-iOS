//
//  MenuCell.m
//  TongKuan
//
//  Created by Beny on 13-5-23.
//  Copyright (c) 2013年 TongKuan. All rights reserved.
//

#import "MenuCell.h"

@implementation MenuCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"settings-menu-light-background.png"]];
        self.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"settings-menu-dark-background.png"]];
        
        UIImageView *separatorTop = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0.5, 320, 0.5)];
        separatorTop.backgroundColor = [UIColor colorWithRed:53.0/255.0 green:56.0/255.0 blue:63.0/255.0 alpha:1.0];
        [self addSubview:separatorTop];
        
        UIImageView *separatorBottom = [[UIImageView alloc] initWithFrame:CGRectMake(0, 43.5, 320, 0.5)];
        separatorBottom.backgroundColor = [UIColor colorWithRed:25.0/255.0 green:26.0/255.0 blue:31.0/255.0 alpha:0.8];
        [self addSubview:separatorBottom];
        
        self.textLabel.textColor = [UIColor whiteColor];
        self.textLabel.font = [UIFont systemFontOfSize:18];

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
