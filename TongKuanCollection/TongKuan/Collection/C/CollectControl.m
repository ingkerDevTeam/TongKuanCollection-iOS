//
//  CollectControl.m
//  TongKuan
//
//  Created by Beny on 13-5-26.
//  Copyright (c) 2013年 TongKuan. All rights reserved.
//

#import "CollectControl.h"
#import "ProductAPI.h"

@interface CollectControl()<UIAlertViewDelegate>

@property (nonatomic,strong) ProductAPI *productApi;

@end

@implementation CollectControl

-(ProductAPI *)productApi
{
    if (!_productApi) {
        _productApi = [[ProductAPI alloc] init];
        _productApi.delegate = self;
    }
    return _productApi;
}

//根据商品ID收藏商品
-(void)collectProdcutWithFeedId:(NSString *)feedId andCollected:(BOOL)collected andCollectButton:(UIButton *)collectButton
{
    if ([self verifyUser]) {
        collectButton.selected = collected;
        if (collected) {
            [self.productApi collectProductWithFeedId:feedId];
        }
        else {
            [self.productApi unCollectProductWithFeedId:feedId];
        }
        //NSLog(@"fid%@collected%d",feedId,collected);
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"系统提示" message:@"登录后才能对商品进行收藏哟，是否登录？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"登录", nil];
        [alert show];
    }
}

#pragma mark - UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self showLoginView];
    }
}

@end
