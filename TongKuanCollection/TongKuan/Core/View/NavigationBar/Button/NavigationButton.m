//
//  NavigationButton.m
//  KingdeeCloudStorage
//
//  Created by Kingdee on 13-3-22.
//  Copyright (c) 2013年 Beny. All rights reserved.
//

#import "NavigationButton.h"

@implementation NavigationButton

- (id)init
{
    self = [super init];
    if (self) {
        
        self.frame = CGRectMake(0, 0, 50.0, 30.0);
        [self setBackgroundImage:[[UIImage imageNamed:@"bar-item.png"] stretchableImageWithLeftCapWidth:4 topCapHeight:4]  forState:UIControlStateNormal];
        [self setBackgroundImage:[[UIImage imageNamed:@"bar-item-tap.png"] stretchableImageWithLeftCapWidth:4 topCapHeight:4] forState:UIControlStateHighlighted];
        
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        
    }
    return self;
}


@end
