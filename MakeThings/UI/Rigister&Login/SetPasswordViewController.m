//
//  SetPasswordViewController.m
//  MakeThings
//
//  Created by Jing Ye on 26/04/2018.
//  Copyright © 2018 aiwen. All rights reserved.
//

#import "SetPasswordViewController.h"
#import "SupplementInfoViewController.h"
#import "MTAplicationUser.h"

@interface SetPasswordViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *nextStepButton;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation SetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nextStepButton.layer.cornerRadius = 5;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)nextStepButtonClicked:(id)sender {
    [MTAplicationUser sharedAplicationUser].password = self.passwordTextField.text;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:RegisterStoryboardName bundle:nil];
    SupplementInfoViewController *vc  = [storyboard instantiateViewControllerWithIdentifier:SupplementInfoViewControllerID];
    [self.navigationController pushViewController:vc animated:YES];

}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


@end
