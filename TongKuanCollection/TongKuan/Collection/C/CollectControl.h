//
//  CollectControl.h
//  TongKuan
//
//  Created by Beny on 13-5-26.
//  Copyright (c) 2013年 TongKuan. All rights reserved.
//

#import "BaseControl.h"

@interface CollectControl : BaseControl

//根据商品ID收藏商品
-(void)collectProdcutWithFeedId:(NSString *)feedId andCollected:(BOOL)collected andCollectButton:(UIButton *)collectButton;

@end
