//
//  LoadMoreView.m
//  TongKuan
//
//  Created by Beny on 13-5-22.
//  Copyright (c) 2013年 TongKuan. All rights reserved.
//

#import "LoadMoreView.h"

@interface LoadMoreView ()



@end

@implementation LoadMoreView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(90, 8, 20, 20)];
        self.activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        [self.activityIndicatorView startAnimating];
        [self addSubview:self.activityIndicatorView];
        
        self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 10, 120, 15)];
        self.textLabel.text = @"正在奋力加载中...";
        self.textLabel.textColor = [UIColor grayColor];
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.textLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.textLabel];
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

//设置加载更多完成状态
-(void)setFinishedState:(BOOL)state
{
    self.hidden = state;
}

@end
