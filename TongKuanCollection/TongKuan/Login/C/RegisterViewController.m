//
//  RegisterViewController.m
//  TongKuan
//
//  Created by Beny on 13-5-26.
//  Copyright (c) 2013年 TongKuan. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegexMatch.h"
#import "UserAPI.h"
#import "UserModel.h"

@interface RegisterViewController ()<BaseAPIDelegate>
@property (weak, nonatomic) IBOutlet UIButton *registerButton;

@property (weak, nonatomic) IBOutlet UITextField *userNameTextView;
@property (weak, nonatomic) IBOutlet UITextField *emailTextView;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextView;
@property (weak, nonatomic) IBOutlet UITextField *confirmPassowrdTextView;

//Data
@property (nonatomic,strong) UserAPI *userApi;

@end

@implementation RegisterViewController

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
    
    [self initView];
	// Do any additional setup after loading the view.
}

-(void)initView
{
    //导航栏
    self.title = @"用户注册";
    self.view.backgroundColor = [UIColor colorWithRed:30.0/255.0 green:34.0/255.0 blue:36.0/255.0 alpha:1.0];
    [self addBackButton];
    
    //按钮
    [self.registerButton setBackgroundImage:[[UIImage imageNamed:@"login_registerButton.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:4]  forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setRegisterButton:nil];
    [super viewDidUnload];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField*)textField
{
    if (textField.tag == 1)
    {
        [self.emailTextView becomeFirstResponder];
    }
    else if (textField.tag == 2)
    {
        [self.passwordTextView becomeFirstResponder];
    }
    else if (textField.tag == 3)
    {
        [self.confirmPassowrdTextView becomeFirstResponder];
    }
    else {
        
        [self textFieldResignFirstResponder];
    }
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateView:1];
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

-(void)textFieldResignFirstResponder
{
    [self animateView:0];
    [self.userNameTextView resignFirstResponder];
    [self.passwordTextView resignFirstResponder];
    [self.emailTextView resignFirstResponder];
    [self.confirmPassowrdTextView resignFirstResponder];
    
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
-(void)backButtonPressed
{
    [self.userApi stopRequest];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)backgroundPressed:(id)sender {
    [self textFieldResignFirstResponder];
}

- (IBAction)registerButtonPressed:(UIButton *)sender {
    [self textFieldResignFirstResponder];
    if (self.userNameTextView.text.length == 0 || self.emailTextView.text.length == 0 || self.passwordTextView.text.length == 0 || self.confirmPassowrdTextView.text.length == 0) {
        [self showHUDWithTitle:@"表单填写不完整!" AndState:HUDStateWarning];
    }
    else if ([self.passwordTextView.text isEqualToString:self.confirmPassowrdTextView.text] == NO) {
        [self showHUDWithTitle:@"两次输入密码不一致!" AndState:HUDStateWarning];
    }
    
    else if ([RegexMatch isAnEmail:self.emailTextView.text] == NO) {

        [self showHUDWithTitle:@"邮箱格式不正确!" AndState:HUDStateWarning];
    }
    else if (self.passwordTextView.text.length < 6) {

        [self showHUDWithTitle:@"密码长度至少为6位!" AndState:HUDStateWarning];

    }
    else {
        [self.userApi registerWithUserName:self.userNameTextView.text AndEmail:self.emailTextView.text AndPassword:self.passwordTextView.text];
        [self showProgressHUDWithTitle:@"正在注册..."];
    }
    
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
    [self showHUDWithTitle:@"注册成功" AndState:HUDStateSuccess];
    [self performSelector:@selector(registerSuccess) withObject:nil afterDelay:2.0];
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

-(void)registerSuccess
{
    [self dismissModalViewControllerAnimated:YES];
}


@end
