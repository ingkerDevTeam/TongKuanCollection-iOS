//
//  TongKuanAppDelegate.h
//  TongKuan
//
//  Created by Beny on 13-5-21.
//  Copyright (c) 2013年 TongKuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IIViewDeckController.h"

@interface TongKuanAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,strong) UIViewController *leftViewController;
@property (nonatomic,strong) UIViewController *centerViewController;
@property (nonatomic,strong) IIViewDeckController *viewDeckController;

@end
