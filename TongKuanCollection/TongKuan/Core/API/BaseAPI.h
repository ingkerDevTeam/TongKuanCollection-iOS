//
//  BaseAPI.h
//  KActive
//
//  Created by Kingdee on 13-5-7.
//  Copyright (c) 2013年 Kingdee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "ASINetworkQueue.h"
#import "JSONKit.h"
#import "UserModel.h"

typedef NS_ENUM(NSInteger, RequestState) {
    RequestStateNone           = 0,//请求未开始或已经结束
    RequestStateRequesting = 1,//正在请求
};

@interface BaseAPI : NSObject<ASIHTTPRequestDelegate,ASIProgressDelegate>
@property (nonatomic,strong) id delegate;
@property (nonatomic,strong) ASIFormDataRequest *request;//数据请求类
@property (nonatomic,strong) NSString *requestURL;//请求连接
@property (nonatomic,assign) RequestType requestType;//请求类型
@property (nonatomic,assign) RequestState requestState;//请求的状态

//返回数据
@property (nonatomic,strong) NSString *code;//请求返回的代码
@property (nonatomic,strong) NSString *message;//请求返回的描述
@property (nonatomic,strong) NSString *error;//错误信息
@property (nonatomic,strong) NSMutableDictionary *responeData;

@property (nonatomic,assign) BOOL isDownloadingFile;//是否正在下载文件
@property (nonatomic,strong) NSString *downloadPath;//文件下载路径

//开始执行异步请求
-(void)startASynchronousRequest;
//开始执行同步请求
-(void)startSynchronousRequest;
//开始下载文件
-(void)startDownloadFile;
//终止请求
-(void)stopRequest;

@end

@protocol BaseAPIDelegate
@required
//请求开始
-(void)baseAPIdidStartedRequest:(BaseAPI *)api;
//请求成功
-(void)baseAPI:(BaseAPI *)api didFinishedRequestWithResponeData:(NSMutableDictionary *)responeData;
//请求失败
-(void)baseAPI:(BaseAPI *)api didFailedRequestWithError:(NSString *)error;
//服务器或网络错误
-(void)baseAPI:(BaseAPI *)api didReceivedNetworkError:(NSString *)error;


@optional
//下载完成
-(void)baseAPI:(BaseAPI *)api didFinishedDownloadWithDownloadPath:(NSString *)downloadPath;
//请求失败
-(void)baseAPI:(BaseAPI *)api didFailedDownloadWithError:(NSString *)error;


@end