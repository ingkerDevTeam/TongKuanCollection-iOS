//
//  LoginViewController.m
//  TongKuan
//
//  Created by Beny on 13-5-21.
//  Copyright (c) 2013年 TongKuan. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "UserAPI.h"
#import "UserModel.h"


@interface LoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *loginInputBackground;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *toRegisterButton;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextView;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextView;

@property (nonatomic,strong) UserAPI *userApi;

@end

@implementation LoginViewController

-(UserAPI *)userApi
{
    if (!_userApi) {
        _userApi = [[UserAPI alloc] init];
        _userApi.delegate = self;
    }
    return _userApi;
}

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
	// Do any additional setup after loading the view.
    [self initView];
}

-(void)initView
{
    self.title = @"用户登录";
    [self addCancelButton];
    self.view.backgroundColor = [UIColor colorWithRed:30.0/255.0 green:34.0/255.0 blue:36.0/255.0 alpha:1.0];
    
    
    [self.loginButton setBackgroundImage:[[UIImage imageNamed:@"login_loginbutton.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:4]  forState:UIControlStateNormal];
    
    [self.toRegisterButton setBackgroundImage:[[UIImage imageNamed:@"login_signupbg.png"] stretchableImageWithLeftCapWidth:4 topCapHeight:4]  forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setLoginInputBackground:nil];
    [self setLoginButton:nil];
    [self setToRegisterButton:nil];
    [self setUserNameTextView:nil];
    [self setPasswordTextView:nil];
    [super viewDidUnload];
}


#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField*)textField
{
    
    if ([textField returnKeyType] !=UIReturnKeyDone)
    {
        [self.passwordTextView becomeFirstResponder];
    }
    else {
        
        [self textFieldResignFirstResponder];
    }
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateView:2];
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
}

-(void)textFieldResignFirstResponder
{
    [self animateView:0];
    [self.userNameTextView resignFirstResponder];
    [self.passwordTextView resignFirstResponder];
}

- (void)animateView:(NSUInteger)tag
{
    CGRect rect = self.view.frame;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    if (tag ) {
        rect.origin.y = -44.0f * tag;
    } else {
        rect.origin.y = 0;
    }
    self.view.frame = rect;
    [UIView commitAnimations];
}

#pragma mark - Action
- (IBAction)backgroundPressed:(id)sender {
    [self textFieldResignFirstResponder];
}

- (IBAction)loginButtonPressed:(id)sender {
    [self textFieldResignFirstResponder];
    if (self.userNameTextView.text.length == 0) {
        [self showHUDWithTitle:@"Email不能为空!" AndState:HUDStateWarning];
        return;
    }
    else if (self.passwordTextView.text.length == 0) {
        [self showHUDWithTitle:@"密码不能为空!" AndState:HUDStateWarning];
        return;
    }
    else {
        [self.userApi loginWitheEmail:self.userNameTextView.text AndPassword:self.passwordTextView.text];
        [self showProgressHUDWithTitle:@"正在登录..."];
    }
}

-(void)cancelButtonPressed
{
    //NSLog(@"取消登陆");
    [self.userApi stopRequest];
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)toRegisterButtonPressed:(id)sender {
    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
    RegisterViewController *registerView = [mainStoryBoard instantiateViewControllerWithIdentifier:@"RegisterView"];
    [self.navigationController pushViewController:registerView animated:YES];
}

#pragma mark - BaseAPIDelegate
//请求开始
-(void)baseAPIdidStartedRequest:(BaseAPI *)api
{
    
}

//请求成功
-(void)baseAPI:(BaseAPI *)api didFinishedRequestWithResponeData:(NSMutableDictionary *)responeData
{
    //NSLog(@"%@",responeData);
    [self hideProgressHUD];
    UserModel *user = [[UserModel alloc] init];
    [user loadDataFromResponeData:responeData andRequestType:RequestTypeRegister];
    [self performSelector:@selector(loginSuccess) withObject:nil afterDelay:0.1];
}

//请求失败
-(void)baseAPI:(BaseAPI *)api didFailedRequestWithError:(NSString *)error
{
    [self hideProgressHUD];
    [self showHUDWithTitle:error AndState:HUDStateFailed];
}

//服务器或网络错误
-(void)baseAPI:(BaseAPI *)api didReceivedNetworkError:(NSString *)error
{
    [self hideProgressHUD];
    [self showHUDWithTitle:@"网络连接有问题" AndState:HUDStateNetworkError];
    
}

-(void)loginSuccess
{
    [self dismissModalViewControllerAnimated:YES];
}

@end
