//
//  BaseViewController.m
//  TongKuan
//
//  Created by Beny on 13-5-21.
//  Copyright (c) 2013年 TongKuan. All rights reserved.
//  

#import "BaseViewController.h"
#import "NavigationBackButton.h"
#import "NavigationButton.h"
#import "NavigationLeftButton.h"
#import "UserModel.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //设置导航条
    [self setNavigationBarBackgroundDefault];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - NavigationBar
//设置导航条默认颜色
-(void)setNavigationBarBackgroundDefault
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed: @"bg-nav.png"] forBarMetrics:UIBarMetricsDefault];
}

//添加菜单按钮
-(void)addMenuButton
{
    NavigationLeftButton *menuButton = [[NavigationLeftButton alloc] init];
    [menuButton addTarget:self action:@selector(menuButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    self.navigationItem.leftBarButtonItem = leftButton;
}

//添加返回按钮
-(void)addBackButton
{
    NavigationBackButton *backButton = [[NavigationBackButton alloc] init];
    [backButton addTarget:self action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = leftButton;
}


//添加取消按钮
-(void)addCancelButton
{
    NavigationButton *button = [[NavigationButton alloc] init];
    [button setTitle:@"取消" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(cancelButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftButton;
}

#pragma mark NavigationBar Action

-(void)menuButtonPressed
{
    //NSLog(@"侧边栏");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showMenuBar" object:nil];
}

-(void)backButtonPressed
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)cancelButtonPressed
{
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark - Controll
//判断scrollview是否滑到底部
-(BOOL)scrollviewIsScrollToBottom:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.frame.size.height-44) {
        return YES;
    }
    else
        return NO;
}



//隐藏ProgressHUD
-(void)hideProgressHUD
{
    [self performSelector:@selector(stopProgressHUD) withObject:nil afterDelay:0.1];
}

#pragma mark - View
//隐藏多余的tableview分割线
- (void)setExtraCellLineHidden:(UITableView *)tableView
{
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

@end
