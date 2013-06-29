//
//  ProductWebViewController.m
//  TongKuan
//
//  Created by Beny on 13-5-26.
//  Copyright (c) 2013年 TongKuan. All rights reserved.
//

#import "ProductWebViewController.h"

@interface ProductWebViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ProductWebViewController

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
	
    [self initView];
}

-(void)initView
{
    //导航条设置
    [self setNavigationBarBackgroundDefault];
    [self addBackButton];
    
    //webview
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.requestUrl]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setWebView:nil];
    [super viewDidUnload];
}


#pragma mark - UIWebViewDelegate
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self showHUDWithTitle:@"载入失败，请检查网络设置" AndState:HUDStateFailed];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.title = @"手机淘宝";
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    self.title = @"正在载入...";
}

@end
