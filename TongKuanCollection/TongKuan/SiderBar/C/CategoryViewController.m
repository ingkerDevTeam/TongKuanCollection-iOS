//
//  CategoryViewController.m
//  TongKuan
//
//  Created by Beny on 13-5-23.
//  Copyright (c) 2013年 TongKuan. All rights reserved.
//

#import "CategoryViewController.h"
#import "IIViewDeckController.h"
#import "MenuCell.h"
#import "NavigationBackButton.h"
#import "IIViewDeckController.h"

@interface CategoryViewController ()<UITableViewDataSource,UITableViewDelegate,IIViewDeckControllerDelegate>

@property (nonatomic,strong) UITableView *tableView;


@end

@implementation CategoryViewController

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
    self.navigationController.navigationBarHidden = NO;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [self initView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initView
{
    //Navigation
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed: @"settings-menu-header-background.png"] forBarMetrics:UIBarMetricsDefault];
    
    NavigationBackButton *backButton = [[NavigationBackButton alloc] init];
    [backButton setTitle:@" 返回" forState:UIControlStateNormal];
    [backButton setBackgroundImage:[[UIImage imageNamed:@"header_back_button_slice.png"] stretchableImageWithLeftCapWidth:12 topCapHeight:4]  forState:UIControlStateNormal];
    [backButton setBackgroundImage:[[UIImage imageNamed:@"header_back_button_slice_sel.png"] stretchableImageWithLeftCapWidth:12 topCapHeight:4] forState:UIControlStateHighlighted];
    [backButton addTarget:self action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = leftButton;
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"settings-menu-background.png"]];

    
    //TableView
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 480-44)];
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
    return 8;
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
        cell.textLabel.text = @"全部";
        cell.tag = 0;
    }
    else if (indexPath.row == 1) {
        cell.textLabel.text = @"衣服";
        cell.tag = 3;
    }
    else if (indexPath.row == 2) {
        cell.textLabel.text = @"裙子";
        cell.tag = 5;
    }
    else if (indexPath.row == 3) {
        cell.textLabel.text = @"包包";
        cell.tag = 2;
    }
    else if (indexPath.row == 4) {
        cell.textLabel.text = @"鞋子";
        cell.tag = 4;
    }
    else if (indexPath.row == 5) {
        cell.textLabel.text = @"裤子";
        cell.tag = 9;
    }
    else if (indexPath.row == 6) {
        cell.textLabel.text = @"饰品";
        cell.tag = 6;
    }
    else if (indexPath.row == 7) {
        cell.textLabel.text = @"其它";
        cell.tag = 1;
    }
    
    return cell;
    
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    TimeLineViewController *timelineView = [self.timelineView.viewControllers objectAtIndex:0];
    
    [timelineView getProductlistAtCategoryId:cell.tag];
    
    [self.viewDeckController closeLeftViewBouncing:^(IIViewDeckController *controller) {
        self.viewDeckController.centerController = self.timelineView;

    }];
}

#pragma mark - Action
-(void)backButtonPressed
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


@end
