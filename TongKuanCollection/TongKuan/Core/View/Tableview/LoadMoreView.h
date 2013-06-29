//
//  LoadMoreView.h
//  TongKuan
//
//  Created by Beny on 13-5-22.
//  Copyright (c) 2013年 TongKuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadMoreView : UIView

@property (nonatomic,strong) UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic,strong) UILabel *textLabel;

//设置加载更多完成状态
-(void)setFinishedState:(BOOL)state;

@end
