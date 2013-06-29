//
//  RegexMatch.m
//  TieXin
//
//  Created by Beny on 13-5-8.
//  Copyright (c) 2013年 Beny. All rights reserved.
//

#import "RegexMatch.h"

@implementation RegexMatch

//判断用户名格式
+(BOOL)isAUserName:(NSString *)username
{
    NSString *regex = @"^[a-zA-Z\\xa0-\\xff_][0-9a-zA-Z\\xa0-\\xff_]{3,15}$";
    NSLog(@"%@",regex);
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if ([predicate evaluateWithObject:username] == YES) {
        return YES;
    }
    else
        return NO;
}

//判断邮箱格式
+(BOOL)isAnEmail:(NSString *)email
{
    NSString *regex = @"\\b([a-zA-Z0-9%_.+\\-]+)@([a-zA-Z0-9.\\-]+?\\.[a-zA-Z]{2,6})\\b";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if ([predicate evaluateWithObject:email] == YES) {
        return YES;
    }
    else
        return NO;
}

@end
