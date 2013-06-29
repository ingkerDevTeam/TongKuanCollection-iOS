//
//  ProductDetailViewController.m
//  TongKuan
//
//  Created by Beny on 13-5-24.
//  Copyright (c) 2013年 TongKuan. All rights reserved.
//

#import "ProductDetailViewController.h"
#import "ProductDetailHeaderView.h"
#import "ProductModel.h"
#import "ProductAPI.h"
#import "CollectControl.h"
#import "ProductWebViewController.h"

@interface ProductDetailViewController ()<UITableViewDataSource,UITableViewDelegate,BaseAPIDelegate,ProductDetailHeaderViewDelegate>
//View
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) ProductDetailHeaderView *productDetailHeaderView;

//Data
@property (nonatomic,strong) ProductModel *product;
@property (nonatomic,strong) ProductAPI *productApi;

//Controller
@property (nonatomic,strong) CollectControl *collectControl;

@end

@implementation ProductDetailViewController

-(ProductAPI *)productApi
{
    if (!_productApi) {
        _productApi = [[ProductAPI alloc] init];
        _productApi.delegate = self;
    }
    return _productApi;
}

-(ProductModel *)product
{
    if (!_product) {
        _product = [[ProductModel alloc] init];
    }
    return _product;
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
	
    //initView
    [self initView];
    
    //LoadData
    [self.productApi getProductDetailWithProductId:self.product.productId andUid:[UserModel getUid]];
    [self showProgressHUDWithTitle:@"正在加载..."];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//获取商品信息
-(void)getProductDetail:(ProductModel *)product
{
    self.product.productId = product.productId;
    self.product.productName = product.productName;
    self.product.price = product.price;
    self.product.collectionCount = product.collectionCount;
}

-(void)initView
{
    self.view.frame = CGRectMake(0, 0, 320, 480-20-44);
    
    //导航栏
    [self addBackButton];
    
    //background
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    
    //TableView
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    //ProjectDetailHeaderView
    self.productDetailHeaderView = [[[NSBundle mainBundle] loadNibNamed:@"ProductDetailHeaderView" owner:self options:NULL] objectAtIndex:0];
    self.tableView.tableHeaderView = self.productDetailHeaderView;
    self.productDetailHeaderView.delegate = self;
    [self setProductDetail];
    
}

-(void)setProductDetail
{
    self.title = self.product.productName;
    self.productDetailHeaderView.priceLabel.text = self.product.price;
    self.productDetailHeaderView.collectCountLabel.text = self.product.collectionCount;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //NSLog(@"%d",self.productlist.count);
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize titleSize = [self.product.description sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(300, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    return titleSize.height+30;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"ProductDetailCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    //cell.backgroundColor = [UIColor whiteColor];
    cell.textLabel.text = self.product.description;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.numberOfLines = 100;
    //NSLog(@"%f",cell.textLabel.frame.size.width);
    
    //cell.textLabel.text = @"sss";
    return cell;
    
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
    [self hideProgressHUD];
    
    NSMutableDictionary *product = [responeData objectForKey:@"product"];
    
    [self.product loadDataFromResponeData:product andRequestType:api.requestType];
    [self setProductDetail];
    [self.productDetailHeaderView setImagelist:self.product.imagelist];
    [self.tableView reloadData];
    
}

//请求失败
-(void)baseAPI:(BaseAPI *)api didFailedRequestWithError:(NSString *)error
{
    [self hideProgressHUD];
    [self showHUDWithTitle:error AndState:HUDStateFailed];
}
//服务器或网络错误
-(void)baseAPI:(BaseAPI *)api didReceivedNetworkError:(NSString *)error
{
    [self hideProgressHUD];
    [self showHUDWithTitle:@"网络连接有问题" AndState:HUDStateNetworkError];
}

#pragma mark - ProductDetailHeaderViewDelegate
-(void)productDetailHeaderViewBuyButtonPressed
{
    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
    ProductWebViewController *productWebView = [mainStoryBoard instantiateViewControllerWithIdentifier:@"ProductWebView"];
    productWebView.requestUrl = self.product.buyUrl;
    [self.navigationController pushViewController:productWebView animated:YES];
}

@end
