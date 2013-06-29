//
//  Common.h
//  KingdeeCloudStorage
//
//  Created by KeSunshine on 13-3-28.
//  Copyright (c) 2013年 Beny. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>


@interface Common : NSObject

//转换时间格式
+(NSString *)timeFormatfromString:(NSString *)string;

//判断文件大小单位
+(NSString *)unitDependOnFileSize:(long long int)size;

//判断文件是否过期，过期返回YES，否则返回NO
+(BOOL)isFileExpire:(NSString *)expireDate;

//获取当前时间的时间戳
+(NSString *)getNowTime;

//判断是否为4英寸设备
+(BOOL)isFourInchDevice;

//弹出系统提示
+(void)showSystemNotifyWithMessage:(NSString *)message;

@end
