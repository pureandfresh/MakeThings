             //
//  LoginViewController.m
//  MakeThings
//
//  Created by Jing Ye on 25/04/2018.
//  Copyright © 2018 aiwen. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "AccountRelatedAPI.h"
#import "MTAplicationUser.h"
#import "MainTabBarViewController.h"
#import "UserViewController.h"
#import "UIViewController+Extention.h"

@interface LoginViewController ()<UITextFieldDelegate,BaseRequestAPIDelegate>
@property (weak, nonatomic) IBOutlet UITextField *passwordTextfield;
@property (weak, nonatomic) IBOutlet UITextField *mobileTextfield;
@property (weak, nonatomic) IBOutlet UILabel *registerLabel;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)setupUI{
    self.loginButton.layer.cornerRadius = 5;
    self.navigationItem.hidesBackButton = YES;
}

- (IBAction)userLoginByWeibo:(id)sender {
}

- (IBAction)userLoginByQQ:(id)sender {
}
- (IBAction)userLoginByWechat:(id)sender {
}
- (IBAction)registerButtonClicked:(id)sender {
    
    [RegisterViewController pushToRegisterViewControllerWithFromViewCOntroller:self];
}
- (IBAction)loginButtonClicked:(id)sender {
    
    WS(weakSelf);
    AccountRelatedAPI *api =  [[AccountRelatedAPI alloc]init];
    api.delegate = self;
    [api userLoginWithPhoneNumber:self.mobileTextfield.text password:self.passwordTextfield.text successBlock:^(NSDictionary *responseDic) {
        SS(strongSelf, weakSelf);
        NSString *status = [NSString stringWithFormat:@"%@",responseDic[@"status"]];
        if (status.integerValue == 0) {
            [[MTAplicationUser sharedAplicationUser] updateMTAplicationUserWithDictionary:responseDic[@"data"]];
            [[MTAplicationUser sharedAplicationUser] saveLoginUserInfo:[MTAplicationUser sharedAplicationUser]];
            
            if (self.presentingViewController) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }else{
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:UserStoryboard bundle:nil];
//                MainTabBarViewController *vc = [storyboard instantiateViewControllerWithIdentifier:MainTabBarViewControllerID];
                
                UserViewController *vc = [storyboard instantiateViewControllerWithIdentifier:UserViewControllerName];
                [strongSelf.navigationController pushViewController:vc animated:YES];

            }
            
        }
        
    } failedBlock:^(NSString *errorString) {
        
    }];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


#pragma mark - BaseRequestAPIDelegate

- (void)userSessionExpired{
    [LoginViewController presentToLoginViewControllerWithFromViewController:[self getCurrentViewController]];
}

+(void)pushToLoginViewControllerWithFromViewController:(UIViewController *)fromViewController{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:RegisterStoryboardName bundle:nil];
    LoginViewController *vc = [storyboard instantiateViewControllerWithIdentifier:LoginViewControllerID];
    [fromViewController.navigationController pushViewController:vc animated:YES];

}

+(void)presentToLoginViewControllerWithFromViewController:(UIViewController *)fromViewController{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:RegisterStoryboardName bundle:nil];
    LoginViewController *vc = [storyboard instantiateViewControllerWithIdentifier:LoginViewControllerID];
    [fromViewController presentViewController:vc animated:YES completion:nil];

}


@end
