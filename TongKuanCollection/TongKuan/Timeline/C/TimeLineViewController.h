//
//  TimeLineViewController.h
//  TongKuan
//
//  Created by Beny on 13-5-21.
//  Copyright (c) 2013年 TongKuan. All rights reserved.
//

#import "BaseViewController.h"
@class LoadMoreView;
@class EGORefreshTableHeaderView;
@class ProductAPI;
@class CollectControl;
@class Productlist;

@interface TimeLineViewController : BaseViewController

//view
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) LoadMoreView *loadMoreView;
@property (nonatomic,strong) EGORefreshTableHeaderView *refreshTableHeaderView;//下拉刷新视图

//Data
@property (nonatomic,strong) ProductAPI *productApi;
@property (nonatomic,strong) Productlist *productlist;

//Controller
@property (nonatomic,strong) CollectControl *collectControl;

//根据分类加载数据
-(void)getProductlistAtCategoryId:(NSInteger)categoryId;
//调用UBaseViewController的viewDidLoad方法
-(void)callBaseViewDidLoad;

@end
