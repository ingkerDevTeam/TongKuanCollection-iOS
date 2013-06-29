//
//  BaseControl.m
//  TongKuan
//
//  Created by Beny on 13-5-26.
//  Copyright (c) 2013年 TongKuan. All rights reserved.
//

#import "BaseControl.h"
#import "UserModel.h"
#import "LoginViewController.h"

@implementation BaseControl

//初始化
-(id)initWithViewController:(UIViewController *)viewController
{
    self = [super init];
    if (self) {
        self.viewController = viewController;
    }
    return self;
}

//验证用户是否登陆
-(BOOL)verifyUser
{
    if ([UserModel getUid]) {
        //NSLog(@"已经登陆");
        return YES;
    }
    else {

        //NSLog(@"尚未登陆");
        return NO;
    }
}

//显示登陆界面
-(void)showLoginView
{
    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
    LoginViewController *loginView = [mainStoryBoard instantiateViewControllerWithIdentifier:@"LoginViewNav"];
    [self.viewController presentModalViewController:loginView animated:YES];
}

@end
