//
//  UserAPI.h
//  KActive
//
//  Created by Kingdee on 13-5-7.
//  Copyright (c) 2013年 Kingdee. All rights reserved.
//

#import "BaseAPI.h"

@interface UserAPI : BaseAPI


//使用用户名和密码登陆
-(void)loginWitheEmail:(NSString *)email AndPassword:(NSString *)password;
//使用用户名，邮箱和密码注册
-(void)registerWithUserName:(NSString *)userName AndEmail:(NSString *)email AndPassword:(NSString *)password;
//获取本机用户信息
-(void)getUserInfoByUid:(NSString *)uid;
//获取用户的收藏
-(void)getMyCollection;

@end
