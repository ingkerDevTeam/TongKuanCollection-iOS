//
//  RegexMatch.h
//  TieXin
//
//  Created by Beny on 13-5-8.
//  Copyright (c) 2013年 Beny. All rights reserved.
//  正则表达式匹配类

#import <Foundation/Foundation.h>

@interface RegexMatch : NSObject

//判断用户名格式
+(BOOL)isAUserName:(NSString *)username;
//判断邮箱格式
+(BOOL)isAnEmail:(NSString *)email;

@end
