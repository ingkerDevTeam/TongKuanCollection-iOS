//
//  UserModel.m
//  PinkOK
//
//  Created by Beny on 13-5-19.
//  Copyright (c) 2013年 PinkOK. All rights reserved.
//

#import "UserModel.h"


@implementation UserModel

//通过请求加载数据
-(void)loadDataFromResponeData:(NSMutableDictionary *)responeData andRequestType:(RequestType)requestType
{
    if (requestType == RequestTypeGetUserInfo || requestType == RequestTypeLogin || requestType == RequestTypeRegister) {
        self.uid = [NSString stringWithFormat:@"%@",[responeData objectForKey:@"uid"]];
        self.uname = [NSString stringWithFormat:@"%@",[responeData objectForKey:@"uname"]];
        self.email = [NSString stringWithFormat:@"%@",[responeData objectForKey:@"email"]];
        self.avatar = [NSString stringWithFormat:@"%@",[responeData objectForKey:@"avatar"]];
        
        NSLog(@"保存用户信息");
        [UserModel saveUserInfo:self];
    }

}


#pragma mark - Class Method
//UID管理
//获取用户信息
+(UserModel *)getLocalUserInfo
{
    UserModel *user = [[UserModel alloc] init];
    user.uid = [[NSUserDefaults standardUserDefaults] objectForKey:@"Uid"];
    user.uname = [[NSUserDefaults standardUserDefaults] objectForKey:@"UName"];
    user.email = [[NSUserDefaults standardUserDefaults] objectForKey:@"Email"];
    user.avatar = [[NSUserDefaults standardUserDefaults] objectForKey:@"Avatar"];
    return user;
}

//获取UID
+(NSString *)getUid
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"Uid"];
}

//保存用户信息
+(void)saveUserInfo:(UserModel *)user
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:user.uid forKey:@"Uid"];
    [defaults setObject:user.uname forKey:@"UName"];
    [defaults setObject:user.email forKey:@"Email"];
    [defaults setObject:user.avatar forKey:@"Avatar"];
    [defaults synchronize];
}

//销毁用户信息
+(void)destoryUserInfo
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Uid"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"UName"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Email"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Avatar"];
}


@end
