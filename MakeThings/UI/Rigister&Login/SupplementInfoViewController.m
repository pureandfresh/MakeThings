//
//  SupplementInfoViewController.m
//  MakeThings
//
//  Created by Jing Ye on 26/04/2018.
//  Copyright © 2018 aiwen. All rights reserved.
//

#import "SupplementInfoViewController.h"
#import "MTAplicationUser.h"
#import "AccountRelatedAPI.h"
#import "LoginViewController.h"


@interface SupplementInfoViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *headProtraitImageView;
@property (weak, nonatomic) IBOutlet UITextField *nickNameTextField;
@property (weak, nonatomic) IBOutlet UIButton *nextStepButton;
@end

@implementation SupplementInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)nextButtonClicked:(id)sender {
    WS(weakSelf);
    [MTAplicationUser sharedAplicationUser].nickName = self.nickNameTextField.text;
    [[[AccountRelatedAPI alloc]init] userRegisterWithPhone:[MTAplicationUser sharedAplicationUser].phoneNumber SMSCode:[MTAplicationUser sharedAplicationUser].verificationCode password:[MTAplicationUser sharedAplicationUser].password name:[MTAplicationUser sharedAplicationUser].nickName successBlock:^(NSDictionary *responseDic) {
        SS(strongSelf, weakSelf);
        NSString *status = [NSString stringWithFormat:@"%@",responseDic[@"status"]];
        if (status.integerValue == 200) {
            [YYHud showSucess:@"注册成功！"];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [LoginViewController pushToLoginViewControllerWithFromViewController:self];
                [strongSelf.navigationController popToRootViewControllerAnimated:YES];
                
            });
            
        }else{
            [YYHud showError:responseDic[@"msg"]];
        }
     
     } failedBlock:^(NSString *errorString) {
        
    }];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

@end
