//
//  NavigationLeftButton.m
//  KingdeeCloudStorage
//
//  Created by Kingdee on 13-3-26.
//  Copyright (c) 2013年 Beny. All rights reserved.
//

#import "NavigationLeftButton.h"

@implementation NavigationLeftButton

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code
        self.frame = CGRectMake(10, 9, 40.0, 30.0);
        
        [self setImage:[UIImage imageNamed:@"button_navi_menu_normal.png"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"button_navi_menu_highlight.png"] forState:UIControlStateHighlighted];

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
