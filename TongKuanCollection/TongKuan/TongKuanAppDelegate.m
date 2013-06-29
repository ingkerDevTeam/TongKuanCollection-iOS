//
//  TongKuanAppDelegate.m
//  TongKuan
//
//  Created by Beny on 13-5-21.
//  Copyright (c) 2013年 TongKuan. All rights reserved.
//

#import "TongKuanAppDelegate.h"
#import "SideBarViewController.h"
#import "TimeLineViewController.h"
//测试一下

@implementation TongKuanAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    //
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showRootView) name:@"showRootView" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showMenuBar) name:@"showMenuBar" object:nil];
    
    [self showRootView];
    


    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)showRootView
{
    SideBarViewController *sideBarView = [[SideBarViewController alloc] init];
    UINavigationController *sideBarNav = [[UINavigationController alloc] initWithRootViewController:sideBarView];
    self.leftViewController = sideBarNav;
    
    TimeLineViewController *timelineView = [[TimeLineViewController alloc] init];
    UINavigationController *timelineNav = [[UINavigationController alloc] initWithRootViewController:timelineView];
    self.centerViewController = timelineNav;
    
    IIViewDeckController *deckView = [[IIViewDeckController alloc] initWithCenterViewController:self.centerViewController leftViewController:self.leftViewController];
    deckView.centerhiddenInteractivity = IIViewDeckCenterHiddenNotUserInteractiveWithTapToCloseBouncing;
    self.viewDeckController = deckView;
    self.viewDeckController.panningCancelsTouchesInView = YES;//点击边缘后弹回
    self.viewDeckController.panningMode = IIViewDeckNoPanning;//禁止手势拖动
    self.viewDeckController.leftSize = 44;
    self.window.rootViewController = deckView;
    [self.window makeKeyAndVisible];
}

-(void)showMenuBar
{
    //NSLog(@"显示侧边栏");
    [self.viewDeckController toggleLeftView];
}


@end
