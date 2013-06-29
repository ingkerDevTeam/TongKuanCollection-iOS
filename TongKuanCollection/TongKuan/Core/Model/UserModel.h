//
//  UserModel.h
//  PinkOK
//
//  Created by Beny on 13-5-19.
//  Copyright (c) 2013年 PinkOK. All rights reserved.
//

#import "Model.h"

@interface UserModel : Model
@property (nonatomic,strong) NSString *uid;//用户id
@property (nonatomic,strong) NSString *email;//email
@property (nonatomic,strong) NSString *uname;//用户名
@property (nonatomic,strong) NSString *password;//密码
@property (nonatomic,strong) NSString *avatar;//头像
@property (nonatomic,assign) int sex;//性别
@property (nonatomic,strong) NSString *location;//位置




//UID管理
//获取本机用户信息
+(UserModel *)getLocalUserInfo;
//获取UID
+(NSString *)getUid;
//保存用户信息
+(void)saveUserInfo:(UserModel *)user;
//销毁用户信息
+(void)destoryUserInfo;

@end
