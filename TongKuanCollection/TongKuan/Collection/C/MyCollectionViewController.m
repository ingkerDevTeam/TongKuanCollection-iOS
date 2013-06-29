//
//  MyCollectionViewController.m
//  TongKuan
//
//  Created by Beny on 13-6-13.
//  Copyright (c) 2013年 TongKuan. All rights reserved.
//

#import "MyCollectionViewController.h"
#import "EGORefreshTableHeaderView.h"
#import "CollectControl.h"
#import "UserAPI.h"
#import "CollectionList.h"
#import "ProductModel.h"
#import "MyCollectionCell.h"
#import "UIImageView+WebCache.h"
#import "ProductDetailViewController.h"

@interface MyCollectionViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,EGORefreshTableHeaderDelegate>

//view
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) EGORefreshTableHeaderView *refreshTableHeaderView;//下拉刷新视图

//Data
@property (nonatomic,strong) UserAPI *userApi;
@property (nonatomic,strong) CollectionList *collectionList;

//Controller
@property (nonatomic,strong) CollectControl *collectControl;

@end

@implementation MyCollectionViewController

-(CollectControl *)collectControl
{
    if (!_collectControl) {
        _collectControl = [[CollectControl alloc] initWithViewController:self];
    }
    return _collectControl;
}

-(UserAPI *)userApi
{
    if (!_userApi) {
        _userApi = [[UserAPI alloc] init];
        _userApi.delegate = self;
    }
    return _userApi;
}

-(CollectionList *)collectionList
{
    if (!_collectionList) {
        _collectionList = [[CollectionList alloc] init];
    }
    return _collectionList;
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
	// Do any additional setup after loading the view.
    [self initView];
    //NSLog(@"%f",self.view.frame.size.height);
    
    
    //loadcathe
    if ([self.collectionList loadDataFromCache]) {
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

-(void)initView
{
    self.view.frame = CGRectMake(0, 0, 320, 480-20-44);
    
    //导航栏
    [self addMenuButton];
    self.title = @"我的收藏";
    
    //background
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    
    //TableView
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self setExtraCellLineHidden:self.tableView];
    //self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    
    //Refresh Header View
    self.refreshTableHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height, self.view.frame.size.width, self.tableView.bounds.size.height)];
    self.refreshTableHeaderView.delegate = self;
    [self.tableView addSubview:self.refreshTableHeaderView];
    
}



-(void)refreshData
{
    if (self.userApi.requestState == RequestStateNone) {
        self.collectionList.isReloading = YES;
        [self.userApi getMyCollection];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //NSLog(@"%d",self.productlist.count);
    return self.collectionList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"MyCollectionCell";
    
    MyCollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[MyCollectionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    [cell setCellStyle];
    ProductModel *product = [self.collectionList objectAtIndex:indexPath.row];
    cell.nameLabel.text = product.productName;
    cell.priceLabel.text = product.price;
    [cell.thumbnail setImageWithURL:[NSURL URLWithString:product.imageUrl]];
    cell.tag = indexPath.row;
    //cell.delegate = self;
    //NSLog(@"%@",product.imageUrl);
    //cell.textLabel.text = @"sss";
     
    return cell;
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失
    
    
    ProductModel *product = [self.collectionList objectAtIndex:indexPath.row];
    
    
    ProductDetailViewController *productDetailView = [[ProductDetailViewController alloc] init];
    [productDetailView getProductDetail:product];
    [self.navigationController pushViewController:productDetailView animated:YES];
     
    
    //NSLog(@"选中");
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //[dataArray removeObjectAtIndex:indexPath.row];
        // Delete the row from the data source.
        ProductModel *product = [self.collectionList objectAtIndex:indexPath.row];
        [self.collectControl collectProdcutWithFeedId:product.feedId andCollected:NO andCollectButton:nil];
        
        [self.collectionList removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        NSLog(@"删除");
    }

}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	
	[self.refreshTableHeaderView egoRefreshScrollViewDidScroll:scrollView];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	[self.refreshTableHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}



#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    [self refreshData];
    
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
    
    return self.collectionList.isReloading;
	
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
    
    [self.collectionList loadDataFromResponeData:responeData andRequestType:api.requestType];
    NSLog(@"%d",self.collectionList.count);
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
    //[self stopProgressHUD];
    self.collectionList.isReloading = NO;
    [self.refreshTableHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
    
}


@end
