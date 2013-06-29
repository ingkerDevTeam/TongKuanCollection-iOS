//
//  SettingViewController.m
//  TongKuan
//
//  Created by Beny on 13-5-27.
//  Copyright (c) 2013年 TongKuan. All rights reserved.
//

#import "SettingViewController.h"
#import "UserModel.h"
#import "UserModel.h"
#import "SDImageCache.h"
#import "LoginViewController.h"
#import "AboutViewController.h"

@interface SettingViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SettingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self initView];
}

-(void)initView
{
    self.title = @"设置";
    
    [self addMenuButton];
    
    //background
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    
    //tableView
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = [UIColor clearColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logout:(id)sender {
    [UserModel destoryUserInfo];
    [self showHUDWithTitle:@"退出成功" AndState:HUDStateSuccess];
}

- (void)viewDidUnload {
    [self setTableView:nil];
    [super viewDidUnload];
}


#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            if ([UserModel getUid]) {
                UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"请选择你的操作" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"退出登录" otherButtonTitles:nil, nil];
                [actionSheet showInView:self.view];
             
            }
            else {
                UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
                LoginViewController *loginView = [mainStoryBoard instantiateViewControllerWithIdentifier:@"LoginViewNav"];
                [self presentModalViewController:loginView animated:YES];
            }

        }
        
    }
    else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            [[SDImageCache sharedImageCache] clearDisk];
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            cell.detailTextLabel.text = @"0.0M";
            [self showHUDWithTitle:@"清理成功" AndState:HUDStateSuccess];
        }
        else if (indexPath.row == 2) {
            UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
            AboutViewController *aboutView = [mainStoryBoard instantiateViewControllerWithIdentifier:@"AboutView"];
            [self.navigationController pushViewController:aboutView animated:YES];
        }
    }
    
}



#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if (section == 0) {
        return 1;
    }
    else
        return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"SettingCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"账号信息";
            if ([UserModel getUid]) {
                UserModel *user = [UserModel getLocalUserInfo];
                cell.detailTextLabel.text = user.uname;
            }
            else
                cell.detailTextLabel.text = @"尚未登录";
        }
        else
            cell.textLabel.text = @"修改密码";
        
    }
    else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"清空缓存";
            cell.detailTextLabel.text= [NSString stringWithFormat:@"%.1fM",[[SDImageCache sharedImageCache] getSize]/1000000.0] ;
        }
        else if(indexPath.row == 1)
            cell.textLabel.text = @"给我评分";
        else if(indexPath.row == 2)
            cell.textLabel.text = @"关于本软件";
    }
    
    
    return cell;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"个人";
    }
    else
        return @"关于";
}

#pragma mark - UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == actionSheet.destructiveButtonIndex) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"系统提示" message:@"确定要退出登录吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"退出登录", nil];
        [alert show];
    }
}

#pragma mark - UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [UserModel destoryUserInfo];
        [self.tableView reloadData];
    }
}


@end
