//
//  APITestViewController.m
//  PinkOK
//
//  Created by Beny on 13-5-15.
//  Copyright (c) 2013年 PinkOK. All rights reserved.
//

#import "APITestViewController.h"
#import "UserAPI.h"

@interface APITestViewController ()<BaseAPIDelegate>

@property (nonatomic,strong) UserAPI *loginApi;


@end

@implementation APITestViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.loginApi  = [[UserAPI alloc] init];
    self.loginApi.delegate  = self;
    [self.loginApi loginWitheEmail:@"hb91@qq.com" AndPassword:@"095092"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - BaseAPIDelegate

-(void)baseAPIdidStartedRequest:(BaseAPI *)api
{
    NSLog(@"开始请求");
}

-(void)baseAPI:(BaseAPI *)api didFinishedRequestWithResponeData:(NSMutableDictionary *)responeData
{
    NSLog(@"请求完成");
    UserModel *user = [[UserModel alloc] init];
    [user loadDataFromResponeData:responeData andRequestType:api.requestType];
    NSLog(@"%@",[UserModel getUid]);
}


-(void)baseAPI:(BaseAPI *)api didFailedRequestWithError:(NSString *)error
{
    NSLog(@"请求失败");
}

-(void)baseAPI:(BaseAPI *)api didReceivedNetworkError:(NSString *)error
{
    NSLog(@"网络错误");
}

@end
