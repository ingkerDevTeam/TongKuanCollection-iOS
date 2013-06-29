//
//  BaseControl.h
//  TongKuan
//
//  Created by Beny on 13-5-26.
//  Copyright (c) 2013年 TongKuan. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BaseControl : NSObject

@property (nonatomic,strong) UIViewController *viewController;//control所属的viewController

//初始化
-(id)initWithViewController:(UIViewController *)viewController;

//验证用户是否登陆
-(BOOL)verifyUser;

//显示登陆界面
-(void)showLoginView;

@end
