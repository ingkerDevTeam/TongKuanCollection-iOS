//
//  UIViewController+HUD.m
//  TieXin
//
//  Created by Beny on 13-5-7.
//  Copyright (c) 2013年 Beny. All rights reserved.
//

#import "UIViewController+HUD.h"
#import "ATMHud.h"

static const char *progressHUDNameKey = "progressHUDNameKay";
static const char *notifyHUDNameKey = "notifyHUDNameKey";

@interface UIViewController () 

@end

@implementation UIViewController (HUD)

#pragma mark - ProgressHUD
-(ATMHud *)progressHud
{
    return (ATMHud *)objc_getAssociatedObject(self, progressHUDNameKey);
}

-(void)setProgressHud:(ATMHud *)progressHud
{
    objc_setAssociatedObject(self, progressHUDNameKey, progressHud, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)createProgressHud
{
    if (![self progressHud]) {
        ATMHud *atmhud = [[ATMHud alloc] initWithDelegate:self];
        [self.view addSubview:atmhud.view];
        [self setProgressHud:atmhud];
    }
}

#pragma mark - NotifyHUD
-(ATMHud *)notifyHud
{
    return (ATMHud *)objc_getAssociatedObject(self, notifyHUDNameKey);
}

-(void)setNotifyHud:(ATMHud *)notifyHud
{
    objc_setAssociatedObject(self, notifyHUDNameKey, notifyHud, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)createNotifyHud
{
    if (![self notifyHud]) {
        ATMHud *atmhud = [[ATMHud alloc] initWithDelegate:self];
        [self.view addSubview:atmhud.view];
        [self setNotifyHud:atmhud];
    }
}

#pragma mark getter
//Progress HUD
//根据标题显示进度指示器
-(void)showProgressHUDWithTitle:(NSString *)title
{
    NSString *showTitle = [NSString stringWithFormat:@"   %@   ",title];
    [self createProgressHud];
    [self.progressHud setCaption:showTitle];
    [self.progressHud setActivity:YES];
    [self.progressHud setAccessoryPosition:ATMHudAccessoryPositionTop];
    [self.progressHud setActivityStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self.progressHud show];

}
//停止HUD
-(void)stopProgressHUD
{
    [self.progressHud hide];
}

//根据标题以及状态显示HUD
-(void)showHUDWithTitle:(NSString *)title AndState:(HUDState)state
{
    [self createNotifyHud];
    NSString *showTitle = [NSString stringWithFormat:@"  %@  ",title];
    [self.notifyHud setCaption:showTitle];
    [self.notifyHud setActivity:NO];
    [self.notifyHud setAccessoryPosition:ATMHudAccessoryPositionTop];
    
    
    if (state == HUDStateSuccess) {
        [self.notifyHud setImage:[UIImage imageNamed:@"success_hud.png"]];
    }
    else if (state == HUDStateFailed) {
        [self.notifyHud setImage:[UIImage imageNamed:@"error_hud.png"]];
    }
    else if (state == HUDStateWarning) {
        [self.notifyHud setImage:[UIImage imageNamed:@"warning_hud.png"]];
    }
    else if (state == HUDStateNetworkError) {
        [self.notifyHud setImage:[UIImage imageNamed:@"wifi_hud.png"]];
    }
    
    [self.notifyHud show];
    [self.notifyHud hideAfter:2.0];
}

@end
