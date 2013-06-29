//
//  NavigationBackButton.m
//  KingdeeCloudStorage
//
//  Created by Kingdee on 13-3-22.
//  Copyright (c) 2013年 Beny. All rights reserved.
//

#import "NavigationBackButton.h"

@implementation NavigationBackButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake(0, 0, 50.0, 30.0);
        [self setBackgroundImage:[UIImage imageNamed:@"button_background_normal.png"] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:@"button_background_highlight.png"] forState:UIControlStateHighlighted];
        
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        [self setTitle:@" 返回" forState:UIControlStateNormal];
    }
    
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
