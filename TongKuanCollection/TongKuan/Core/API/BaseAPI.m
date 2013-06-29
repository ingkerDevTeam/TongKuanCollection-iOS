//
//  BaseAPI.m
//  KActive
//
//  Created by Kingdee on 13-5-7.
//  Copyright (c) 2013年 Kingdee. All rights reserved.
//

#import "BaseAPI.h"

@implementation BaseAPI
//开始执行同步请求
-(void)startSynchronousRequest
{
    self.request.timeOutSeconds = DFRequestTimeOut;
    [self.request setDelegate:self];
    [self.request startSynchronous];
}

//开始执行异步请求
-(void)startASynchronousRequest
{
    
    self.request.timeOutSeconds = DFRequestTimeOut;
    [self.request setDelegate:self];
    [self.request startAsynchronous];
}

//开始下载
-(void)startDownloadFile
{
    self.isDownloadingFile = YES;
}

//终止请求
-(void)stopRequest
{
    [self.request clearDelegatesAndCancel];
}

#pragma mark - ASIHttpRequestDelegate

-(void)requestStarted:(ASIHTTPRequest *)request
{
    self.requestState = RequestStateRequesting;
    if ([self.delegate respondsToSelector:@selector(baseAPIdidStartedRequest:)]) {
        [self.delegate baseAPIdidStartedRequest:self];
    }
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    self.requestState = RequestStateNone;

    NSLog(@"%@",[request responseString]);
    if (self.isDownloadingFile) {
        //文件下载
    }
    else {
        
        NSMutableDictionary *responeData = [[request responseString] objectFromJSONString];
        
        self.code = [NSString stringWithFormat:@"%@",[responeData objectForKey:@"code"]] ;
        self.message = [NSString stringWithFormat:@"%@",[responeData objectForKey:@"message"]] ;
        
        //认证成功
        if ([self.code isEqualToString:@"200"]) {
            if ([self.delegate respondsToSelector:@selector(baseAPI:didFinishedRequestWithResponeData:)]) {
                [self.delegate baseAPI:self didFinishedRequestWithResponeData:responeData];
            }
        }
        //认证失败
        else if([self.code isEqualToString:@"401"]){
            self.error = [NSString stringWithFormat:@"%@",[responeData objectForKey:@"error"]];

            if ([self.message isEqualToString:@"Login failed"] || [self.description isEqualToString:@"Register failed"]) {
                if ([self.delegate respondsToSelector:@selector(baseAPI:didFailedRequestWithError:)]) {
                    [self.delegate baseAPI:self didFailedRequestWithError:self.error];
                }
            }
            else {
                [UserModel destoryUserInfo];
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Verify Error" message:@"Please login again!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                
                /*
                //切换视图
                UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
                UIWindow *window = [[UIApplication sharedApplication] delegate].window;
                LoginViewController *loginVC = [mainStoryBoard instantiateViewControllerWithIdentifier:@"Login"];
                
                [window setRootViewController:loginVC];
                window.windowLevel = UIWindowLevelNormal;
                [window makeKeyAndVisible];
                 */
            }
        }
        //其他错误
        else if([self.code isEqualToString:@"400"]){
            self.error = [NSString stringWithFormat:@"%@",[responeData objectForKey:@"error"]];
            if ([self.delegate respondsToSelector:@selector(baseAPI:didFailedRequestWithError:)]) {
                [self.delegate baseAPI:self didFailedRequestWithError:self.error];
            }
        }

        else
        {
            //服务器出错
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Server Error" message:@"Please try later." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            if ([self.delegate respondsToSelector:@selector(baseAPI:didReceivedNetworkError:)]) {
                [self.delegate baseAPI:self didReceivedNetworkError:@"Server Error"];
            }
        }
    }

    
}


- (void)requestFailed:(ASIHTTPRequest *)request
{
    self.requestState = RequestStateNone;
    NSError *error = [request error];
	NSLog(@"the error is %@",error);
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"showNetworkErrorHUD" object:nil];
    if ([self.delegate respondsToSelector:@selector(baseAPI:didReceivedNetworkError:)]) {
        [self.delegate baseAPI:self didReceivedNetworkError:@"Network Error"];
    }

}

@end
