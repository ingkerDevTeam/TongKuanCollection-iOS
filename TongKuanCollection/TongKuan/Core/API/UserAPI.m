//
//  UserAPI.m
//  KActive
//
//  Created by Kingdee on 13-5-7.
//  Copyright (c) 2013年 Kingdee. All rights reserved.
//

#import "UserAPI.h"

@implementation UserAPI

//使用用户名和密码登陆
-(void)loginWitheEmail:(NSString *)email AndPassword:(NSString *)password
{
    NSString *requestUrl = [NSString stringWithFormat:@"%@mod=User&act=login&email=%@&password=%@",DFRequestUrl,email,password];
    NSLog(@"%@",requestUrl);
    NSURL *url = [NSURL URLWithString:requestUrl];
    self.request = [ASIFormDataRequest requestWithURL:url];
    self.requestType = RequestTypeLogin;
    //[self performSelector:@selector(didStartASynchronousRequest) withObject:nil afterDelay:0.1];
    [self startASynchronousRequest];
}

//使用用户名，邮箱和密码注册
-(void)registerWithUserName:(NSString *)userName AndEmail:(NSString *)email AndPassword:(NSString *)password
{
    NSString *requestUrl = [NSString stringWithFormat:@"%@mod=User&act=register&uname=%@&email=%@&password=%@",DFRequestUrl,userName,email,password];
    requestUrl = [requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",requestUrl);
    NSURL *url = [NSURL URLWithString:requestUrl];
    self.request = [ASIFormDataRequest requestWithURL:url];
    self.requestType = RequestTypeRegister;
    //[self performSelector:@selector(didStartASynchronousRequest) withObject:nil afterDelay:0.1];
    [self startASynchronousRequest];
}

//获取本机用户信息
-(void)getUserInfoByUid:(NSString *)uid
{
    NSString *requestUrl = [NSString stringWithFormat:@"%@&mod=User&act=getUserInfo&uid=%@",DFRequestUrl,uid];
    requestUrl = [requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",requestUrl);
    NSURL *url = [NSURL URLWithString:requestUrl];
    self.request = [ASIFormDataRequest requestWithURL:url];
    self.requestType = RequestTypeGetUserInfo;
    //[self performSelector:@selector(didStartASynchronousRequest) withObject:nil afterDelay:0.1];
    [self startASynchronousRequest];
}

//获取用户的收藏
-(void)getMyCollection
{
    NSString *requestUrl = [NSString stringWithFormat:@"%@&mod=User&act=getMyCollection&uid=%@",DFRequestUrl,[UserModel getUid]];
    requestUrl = [requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",requestUrl);
    NSURL *url = [NSURL URLWithString:requestUrl];
    self.request = [ASIFormDataRequest requestWithURL:url];
    self.requestType = RequestTypeGetUserInfo;
    //[self performSelector:@selector(didStartASynchronousRequest) withObject:nil afterDelay:0.1];
    [self startASynchronousRequest];
}

@end
