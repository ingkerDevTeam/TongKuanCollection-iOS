//
//  TimeLineViewController.m
//  TongKuan
//
//  Created by Beny on 13-5-21.
//  Copyright (c) 2013年 TongKuan. All rights reserved.
//

#import "TimeLineViewController.h"
#import "EGORefreshTableHeaderView.h"
#import "TimelineCell.h"
#import "ProductAPI.h"
#import "ProductModel.h"
#import "Datalist.h"
#import "Productlist.h"
#import "UIImageView+WebCache.h"
#import "LoadMoreView.h"
#import "ProductDetailViewController.h"
#import "LoginViewController.h"
#import "CollectControl.h"

@interface TimeLineViewController ()<UITableViewDataSource,UITableViewDelegate,BaseAPIDelegate,UIScrollViewDelegate,EGORefreshTableHeaderDelegate,TimelineCellDelegate>


@end

@implementation TimeLineViewController

-(ProductAPI *)productApi
{
    if (!_productApi) {
        _productApi = [[ProductAPI alloc] init];
        _productApi.delegate = self;
    }
    return _productApi;
}

-(Productlist *)productlist
{
    if (!_productlist) {
        _productlist = [[Productlist alloc] init];
    }
    return _productlist;
}

-(CollectControl *)collectControl
{
    if (!_collectControl) {
        _collectControl = [[CollectControl alloc] initWithViewController:self];
    }
    return _collectControl;
}


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
    
    [self initView];
    //NSLog(@"%f",self.view.frame.size.height);
    
    //loadcathe
    if ([self.productlist loadDataFromCache]) {
        [self.tableView reloadData];
    }
    
    //reloadData
    [self viewRefrashData];	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//调用UBaseViewController的viewDidLoad方法
-(void)callBaseViewDidLoad
{
    [super viewDidLoad];
}

-(void)initView
{
    self.view.frame = CGRectMake(0, 0, 320, 480-20-44);
    
    //导航栏
    [self addMenuButton];
    self.title = @"同款精选";
    
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
    
    //Refresh Header View
    self.refreshTableHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height, self.view.frame.size.width, self.tableView.bounds.size.height)];
    self.refreshTableHeaderView.delegate = self;
    [self.tableView addSubview:self.refreshTableHeaderView];
    
}

//根据分类加载数据
-(void)getProductlistAtCategoryId:(NSInteger)categoryId
{
    self.productlist.categoryId = categoryId;
    [self.productApi stopRequest];
    [self viewRefrashData];
}

-(void)refreshData
{
    if (self.productApi.requestState == RequestStateNone) {
        self.productlist.isReloading = YES;
        [self.productApi getProductlistOnPage:1 withCategoryId:self.productlist.categoryId andUid:[UserModel getUid]];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%d",self.productlist.count);
    return self.productlist.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 372;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *cellIdentifier = @"TimelineCell";
    TimelineCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
    if (cell == nil) {
        NSArray *nibsArray=[[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
        cell = (TimelineCell *)[nibsArray objectAtIndex:0];
        UINib *n= [UINib nibWithNibName:@"TimelineCell" bundle:[NSBundle mainBundle]];
        [self.tableView registerNib:n forCellReuseIdentifier:cellIdentifier];
    }
    [cell setCellStyle];
    ProductModel *product = [self.productlist objectAtIndex:indexPath.row];
    cell.nameLabel.text = product.productName;
    cell.priceLabel.text = product.price;
    cell.collectionCountLabel.text = product.collectionCount;
    [cell.image setImageWithURL:[NSURL URLWithString:product.imageUrl]];
    [cell.collectButton setSelected:product.isCollected];
    cell.tag = indexPath.row;
    cell.delegate = self;
    //NSLog(@"%@",product.imageUrl);
    //cell.textLabel.text = @"sss";
    return cell;
        
}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失
    
    ProductModel *product = [self.productlist objectAtIndex:indexPath.row];
    
    
    ProductDetailViewController *productDetailView = [[ProductDetailViewController alloc] init];
    [productDetailView getProductDetail:product];
    [self.navigationController pushViewController:productDetailView animated:YES];
    
    //NSLog(@"选中");
    
}



#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	
	[self.refreshTableHeaderView egoRefreshScrollViewDidScroll:scrollView];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	[self.refreshTableHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([self scrollviewIsScrollToBottom:scrollView]) {
        //NSLog(@"滑到底部");
        //NSLog(@"%d",self.productApi.requestState);
        if (self.productApi.requestState == RequestStateNone) {
            if (self.productlist.count < self.productlist.totalRecord) {
                [self.productApi getProductlistOnPage:self.productlist.currentPage+1 withCategoryId:self.productlist.categoryId andUid:[UserModel getUid]];
            }
            
        }
    }
}

#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    [self refreshData];
    
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
    
    return self.productlist.isReloading;
	
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return [NSDate date]; // should return date data source was last changed
	
}

-(void)viewRefrashData{
    [self.tableView setContentOffset:CGPointMake(0, -75) animated:YES];
    [self performSelector:@selector(doneManualRefresh) withObject:nil afterDelay:0.4];
}
-(void)doneManualRefresh{
    [self.refreshTableHeaderView egoRefreshScrollViewDidScroll:self.tableView];
    [self.refreshTableHeaderView egoRefreshScrollViewDidEndDragging:self.tableView];
}

#pragma mark - BaseAPIDelegate
//请求开始
-(void)baseAPIdidStartedRequest:(BaseAPI *)api
{
    
}

//请求成功
-(void)baseAPI:(BaseAPI *)api didFinishedRequestWithResponeData:(NSMutableDictionary *)responeData
{
    //NSLog(@"%@",responeData);
    NSLog(@"搜索完成");
    [self.productlist loadDataFromResponeData:responeData andRequestType:api.requestType];
    [self.tableView reloadData];
    
    [self requestEnded];
}

//请求失败
-(void)baseAPI:(BaseAPI *)api didFailedRequestWithError:(NSString *)error
{
    [self requestEnded];
}
//服务器或网络错误
-(void)baseAPI:(BaseAPI *)api didReceivedNetworkError:(NSString *)error
{
    [self requestEnded];
    [self showHUDWithTitle:@"网络连接有问题" AndState:HUDStateNetworkError];
}


//请求终止
-(void)requestEnded
{
    self.productlist.isReloading = NO;
    [self.refreshTableHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
    
    if (self.productlist.count >= self.productlist.totalRecord || self.productlist.count == 0) {
        [self.loadMoreView setFinishedState:YES];
    }
    else
        [self.loadMoreView setFinishedState:NO];
}

#pragma mark - TimelineCellDelegate
-(void)timelineCell:(TimelineCell *)cell collectButtonPressedWithCollected:(BOOL)collected
{
    
    ProductModel *product = [self.productlist objectAtIndex:cell.tag];
    product.isCollected = collected;
    [self.collectControl collectProdcutWithFeedId:product.feedId andCollected:collected andCollectButton:cell.collectButton];

}

@end
