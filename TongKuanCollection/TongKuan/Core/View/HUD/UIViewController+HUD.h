//
//  UIViewController+HUD.h
//  TieXin
//
//  Created by Beny on 13-5-7.
//  Copyright (c) 2013年 Beny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ATMHudDelegate.h"
#import <objc/runtime.h>

typedef NS_ENUM(NSInteger, HUDState) {
    HUDStateSuccess           = 1,//成功状态
    HUDStateFailed = 2,//失败状态
    HUDStateWarning = 3,//警告状态
    HUDStateNetworkError = 4,//网络错误状态
};

@interface UIViewController (HUD) <ATMHudDelegate>

@property (nonatomic,strong) ATMHud *progressHud;
@property (nonatomic,strong) ATMHud *notifyHud;
//Progress HUD
//根据标题显示进度指示器
-(void)showProgressHUDWithTitle:(NSString *)title;
//停止HUD
-(void)stopProgressHUD;

//Notify HUD
//根据标题以及状态显示HUD
-(void)showHUDWithTitle:(NSString *)title AndState:(HUDState)state;

@end
