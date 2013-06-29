//
//  Common.m
//  KingdeeCloudStorage
//
//  Created by KeSunshine on 13-3-28.
//  Copyright (c) 2013年 Beny. All rights reserved.
//

#import "Common.h"
#import "GTMBase64.h"

@implementation Common

+(NSString *)timeFormatfromString:(NSString *)string
{
    /*
     NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
     NSTimeZone *zone = [NSTimeZone systemTimeZone];
     NSInteger interval = [zone secondsFromGMTForDate:datenow];
     NSDate *localeDate = [datenow  dateByAddingTimeInterval: interval];
     NSLog(@"%@", localeDate);*/
    
    NSTimeInterval timeInterval = [string doubleValue];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    NSString *timeString = [dateFormatter stringFromDate:confromTimesp];
    
    return timeString;
}

+(NSString *)unitDependOnFileSize:(long long int)size
{
    NSString *unitString;
    
    if (size/1024 >= 1) {
        if (size/(1024*1024) >= 1) {
            if (size/(1024*1024*1024)) {
                unitString = [NSString stringWithFormat:@"%.2fG", size/(1024*1024*1024.00)];
            }else{
                unitString = [NSString stringWithFormat:@"%.2fM", size/(1024*1024.00)];
            }
        }else{
            unitString = [NSString stringWithFormat:@"%lldK", size/1024];
        }
    }else{
        unitString = [NSString stringWithFormat:@"%lldB", size];
    }
    return unitString;
}

+(BOOL)isFileExpire:(NSString *)expireDate
{
    //获取当前时间
    NSDate *nowDate = [NSDate date];
    
    //转换成时间戳
    double nowDateDoubleValue = [nowDate timeIntervalSince1970];
    
    double expireDateDoubleValue = [expireDate doubleValue];
    
    if (nowDateDoubleValue > expireDateDoubleValue) {
        return NO;
    }else{
        return YES;
    }
}

//获取当前时间的时间戳
+(NSString *)getNowTime
{
    //获取当前时间
    NSDate *nowDate = [NSDate date];
    
    //转换成时间戳
    double nowDateDoubleValue = [nowDate timeIntervalSince1970];
    
    NSString *time = [NSString stringWithFormat:@"%.0f",nowDateDoubleValue];
    return time;
}

//判断是否为4英寸设备
+(BOOL)isFourInchDevice
{
    return  ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON );
}



@end
