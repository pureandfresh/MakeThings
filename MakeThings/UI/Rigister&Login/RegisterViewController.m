//
//  RegisterViewController.m
//  MakeThings
//
//  Created by Jing Ye on 25/04/2018.
//  Copyright © 2018 aiwen. All rights reserved.
//

#import "RegisterViewController.h"
#import "AccountRelatedAPI.h"
#import "SetPasswordViewController.h"
#import "MTAplicationUser.h"

const NSString *userValidationDateKey = @"userValidationDateKey";
static NSInteger const TimeInvel   = 60;       // （60s）

@interface RegisterViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *verificationCodeTextField;
@property (weak, nonatomic) IBOutlet UIButton *verificationCodeButton;
@property (weak, nonatomic) IBOutlet UIButton *nextStepButton;

@property (nonatomic,copy) NSString *verficationCode;

@property (nonatomic) NSTimer *validTimer;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setupUI{
    self.nextStepButton.layer.cornerRadius = 5;
    self.verificationCodeButton.layer.cornerRadius = 5;
    self.verificationCodeButton.layer.borderWidth = 1;
    self.verificationCodeButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
}


#pragma mark - timmer

-(void)startTime
{
    [self.validTimer invalidate];
    self.validTimer = nil;
    [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:(NSString *)userValidationDateKey];
    self.validTimer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(calculateTimer) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.validTimer forMode:NSDefaultRunLoopMode];
}
- (void) calculateTimer
{
    NSDate *startTime = [[NSUserDefaults standardUserDefaults] objectForKey:(NSString *)userValidationDateKey];
    if (!startTime || [startTime timeIntervalSinceNow] < -TimeInvel) {
        [self.verificationCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self.validTimer invalidate];
        self.validTimer = nil;
    } else {
        int seconds = [startTime timeIntervalSinceNow] + TimeInvel;
        NSString *strTime = [NSString stringWithFormat:@"%d", seconds];
        [self.verificationCodeButton setTitle:[NSString stringWithFormat:@"%@s",strTime] forState:UIControlStateNormal];
    }
}



#pragma mark - action

- (IBAction)nextStepButtonClicked:(id)sender {
    
    [MTAplicationUser sharedAplicationUser].phoneNumber = self.phoneTextField.text;
    [MTAplicationUser sharedAplicationUser].verificationCode = self.verficationCode;
    if (self.verificationCodeTextField.text.length == 6) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:RegisterStoryboardName bundle:nil];
                SetPasswordViewController *vc  = [storyboard instantiateViewControllerWithIdentifier:SetPasswordViewControllerID];
        [self.navigationController pushViewController:vc animated:YES];

 
    }
}

- (IBAction)obtainVerfivationCode:(id)sender {
    
    WS(weakSelf);
    
    [[[AccountRelatedAPI alloc]init] requestSMSCodeWithPhoneNUmber:self.phoneTextField.text successBlock:^(NSDictionary *responseDic) {
        SS(strongSelf, weakSelf);
        NSString *status = [NSString stringWithFormat:@"%@",responseDic[@"status"]];
        if (status.integerValue == 200) {
            [strongSelf startTime];
            strongSelf.verficationCode = responseDic[@"data"];
            strongSelf.verificationCodeTextField.text = responseDic[@"data"];
        }

    } failedBlock:^(NSString *errorString) {
        
    }];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
}

+(void)pushToRegisterViewControllerWithFromViewCOntroller:(UIViewController *)fromViewController{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:RegisterStoryboardName bundle:nil];
    RegisterViewController *vc = [storyboard instantiateViewControllerWithIdentifier:RegisterViewControllerID];
    [fromViewController.navigationController pushViewController:vc animated:YES];

}
@end
