//
//  SearchProductViewController.h
//  TongKuan
//
//  Created by Beny on 13-6-13.
//  Copyright (c) 2013年 TongKuan. All rights reserved.
//

#import "TimeLineViewController.h"

@interface SearchProductViewController : TimeLineViewController

@property (nonatomic,strong) NSString *searchKey;//搜索的关键子

-(void)searchProductWithKey:(NSString *)searchKey;

@end
