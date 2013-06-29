//
//  SearchProductViewController.m
//  TongKuan
//
//  Created by Beny on 13-6-13.
//  Copyright (c) 2013年 TongKuan. All rights reserved.
//

#import "SearchProductViewController.h"
#import "LoadMoreView.h"
#import "EGORefreshTableHeaderView.h"
#import "ProductAPI.h"
#import "Productlist.h"

@interface SearchProductViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property (nonatomic,strong) UILabel *tipsLabel;//提示标签

@end

@implementation SearchProductViewController

-(void)searchProductWithKey:(NSString *)searchKey
{
    self.searchKey = searchKey;
    self.tipsLabel.hidden = YES;
    [self.productlist removeAllObjects];
    [self.productApi searchProductWithKey:searchKey OnPage:1 andUid:[UserModel getUid]];
    [self showProgressHUDWithTitle:@"正在搜索..."];
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
    [self setNavigationBarBackgroundDefault];

}

- (void)viewDidLoad
{
    [self callBaseViewDidLoad];
	// Do any additional setup after loading the view.
    [self initView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initView
{
    self.view.frame = CGRectMake(0, 0, 320, 480-20-44);
    
    //导航栏
    [self addMenuButton];
    self.title = @"搜索";
    
    
    //background
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    
    //TableView
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    //Footer
    self.loadMoreView = [[LoadMoreView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    [self.loadMoreView setFinishedState:YES];
    self.tableView.tableFooterView = self.loadMoreView;
    
    //Tips Label
    self.tipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
    self.tipsLabel.hidden = YES;
    self.tipsLabel.textAlignment = UITextAlignmentCenter;
    self.tipsLabel.font = [UIFont systemFontOfSize:14];
    self.tipsLabel.textColor = [UIColor darkGrayColor];
    self.tipsLabel.backgroundColor = [UIColor clearColor];
    self.tipsLabel.center = self.view.center;
    [self.view addSubview:self.tipsLabel];
    
}

//请求终止
-(void)requestEnded
{
    [self hideProgressHUD];
    self.productlist.isReloading = NO;
    
    if (self.productlist.count == 0) {
        self.tipsLabel.hidden = NO;
        self.tipsLabel.text = [NSString stringWithFormat:@"暂时没有与 %@ 相关的商品哟！",self.searchKey];
    }
    
    if (self.productlist.count >= self.productlist.totalRecord || self.productlist.count == 0) {
        [self.loadMoreView setFinishedState:YES];
    }
    else
        [self.loadMoreView setFinishedState:NO];
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([self scrollviewIsScrollToBottom:scrollView]) {
        //NSLog(@"滑到底部");
        //NSLog(@"%d",self.productApi.requestState);
        if (self.productApi.requestState == RequestStateNone) {
            if (self.productlist.count < self.productlist.totalRecord) {
                //[self.productApi getProductlistOnPage:self.productlist.currentPage+1 withCategoryId:self.productlist.categoryId andUid:[UserModel getUid]];
                [self.productApi searchProductWithKey:self.searchKey OnPage:self.productlist.currentPage+1 andUid:[UserModel getUid]];
            }
            
        }
    }
}

@end
