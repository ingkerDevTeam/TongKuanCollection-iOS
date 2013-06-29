//
//  BaseViewController.h
//  TongKuan
//
//  Created by Beny on 13-5-21.
//  Copyright (c) 2013年 TongKuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "UIViewController+HUD.h"

@interface BaseViewController : UIViewController

#pragma mark - NavigationBar
//设置导航条默认颜色
-(void)setNavigationBarBackgroundDefault;
//添加菜单按钮
-(void)addMenuButton;
//添加返回按钮
-(void)addBackButton;
//添加取消按钮
-(void)addCancelButton;

#pragma mark NavigationBar Action
-(void)menuButtonPressed;

#pragma mark - Controll
//判断scrollview是否滑到底部
-(BOOL)scrollviewIsScrollToBottom:(UIScrollView *)scrollView;
//隐藏ProgressHUD
-(void)hideProgressHUD;


#pragma mark - View
//隐藏多余的tableview分割线
- (void)setExtraCellLineHidden:(UITableView *)tableView;

@end
