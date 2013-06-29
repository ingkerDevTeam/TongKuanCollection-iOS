//
//  SideBarViewController.m
//  TongKuan
//
//  Created by Beny on 13-5-21.
//  Copyright (c) 2013年 TongKuan. All rights reserved.
//

#import "SideBarViewController.h"
#import "TimeLineViewController.h"
#import "IIViewDeckController.h"
#import "MenuCell.h"
#import "CategoryViewController.h"
#import "SettingViewController.h"
#import "UserModel.h"
#import "MyCollectionViewController.h"
#import "LoginViewController.h"
#import "SearchProductViewController.h"

@interface SideBarViewController ()<UITableViewDataSource,UITableViewDelegate,IIViewDeckControllerDelegate,UISearchBarDelegate>

//view
@property (nonatomic,strong) UISearchBar *searchBar;//搜索栏
@property (nonatomic,strong) UITableView *tableView;

//controller
@property (nonatomic,strong) UINavigationController *timelineView;//时间轴
@property (nonatomic,strong) CategoryViewController *categoryView;//分类
@property (nonatomic,strong) UINavigationController *settingView;//设置
@property (nonatomic,strong) UINavigationController *myCollectionView;//收藏界面
@property (nonatomic,strong) SearchProductViewController *searchProductView;//搜索界面

@end

@implementation SideBarViewController

-(CategoryViewController *)categoryView
{
    if (!_categoryView) {
        _categoryView = [[CategoryViewController alloc] init];
    }
    return _categoryView;
}

-(UINavigationController *)settingView
{
    if (!_settingView) {
        UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
        SettingViewController *setView = [mainStoryBoard instantiateViewControllerWithIdentifier:@"SettingView"];
        _settingView = [[UINavigationController alloc] initWithRootViewController:setView];
    }
    return _settingView;
}

-(UINavigationController *)myCollectionView
{
    if (!_myCollectionView) {
        MyCollectionViewController *myCollectionView = [[MyCollectionViewController alloc] init];
        _myCollectionView = [[UINavigationController alloc] initWithRootViewController:myCollectionView];
    }
    return _myCollectionView;
}

-(SearchProductViewController *)searchProductView
{
    if (!_searchProductView) {
        _searchProductView = [[SearchProductViewController alloc] init];
    }
    return _searchProductView;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.searchBar resignFirstResponder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initView];
    
    self.timelineView = (UINavigationController *)self.viewDeckController.centerController;
    self.viewDeckController.delegate = self;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initView
{
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"settings-menu-background.png"]];
    
    //searchBar
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320-44, 44)];
    [self.searchBar setBackgroundImage:[UIImage imageNamed:@"settings-menu-header-background.png"]];
    self.searchBar.delegate = self;
    
    UIImageView *searchBarBackground = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    searchBarBackground.image = [UIImage imageNamed:@"settings-menu-header-background.png"];
    [self.view addSubview:searchBarBackground];
    
    [self.view addSubview:self.searchBar];
    
    //TableView
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, 320, 480-44)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //NSLog(@"%d",self.productlist.count);
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"MenuCell";
    MenuCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[MenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        //cell.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    if (indexPath.row == 0) {
        cell.textLabel.text = @"首页";
        cell.imageView.image = [UIImage imageNamed:@"settings-menu-moments.png"];
    }
    else if (indexPath.row == 1) {
        cell.textLabel.text = @"分类";
        cell.imageView.image = [UIImage imageNamed:@"settings-menu-todo-list.png"];
    }
    else if (indexPath.row == 2) {
        cell.textLabel.text = @"收藏";
        cell.imageView.image = [UIImage imageNamed:@"settings-menu-share.png"];
    }
    else if (indexPath.row == 3) {
        cell.textLabel.text = @"设置";
        cell.imageView.image = [UIImage imageNamed:@"settings-menu-settings.png"];
    }
    
    return cell;
}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];//选中后的反显颜色即刻消失
    if (indexPath.row == 0) {
        [self.viewDeckController closeLeftViewBouncing:^(IIViewDeckController *controller) {
            self.viewDeckController.centerController = self.timelineView;
        }];
    }
    else if (indexPath.row == 1) {
        self.categoryView.timelineView = self.timelineView;
        [self.navigationController pushViewController:self.categoryView animated:YES];

    }
    if (indexPath.row == 2) {
        if ([UserModel getUid]) {
            [self.viewDeckController closeLeftViewBouncing:^(IIViewDeckController *controller) {
                self.viewDeckController.centerController = self.myCollectionView;
            }];
        }
        else {
            UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
            LoginViewController *loginView = [mainStoryBoard instantiateViewControllerWithIdentifier:@"LoginViewNav"];
            [self presentModalViewController:loginView animated:YES];
        }

    }
    else if (indexPath.row == 3) {
        [self.viewDeckController closeLeftViewBouncing:^(IIViewDeckController *controller) {
            self.viewDeckController.centerController = self.settingView;
        }];
    }

}

#pragma mark - UISearchBarDelegate
-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [self.searchBar resignFirstResponder];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"搜索%@",searchBar.text);
    [self.viewDeckController closeLeftViewBouncing:^(IIViewDeckController *controller) {
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:self.searchProductView];
        self.viewDeckController.centerController = nav;
        [self.searchProductView searchProductWithKey:searchBar.text];
    }];

}

@end
