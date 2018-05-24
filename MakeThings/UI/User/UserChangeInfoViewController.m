//
//  UserChangeInfoViewController.m
//  MakeThings
//
//  Created by Jing Ye on 23/05/2018.
//  Copyright © 2018 aiwen. All rights reserved.
//

#import "UserChangeInfoViewController.h"

@interface UserChangeInfoViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (nonatomic,copy) NSString *contentString;

@end

@implementation UserChangeInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)setupUI{
    self.title = @"设置名字";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self
                                                                           action:@selector(leftButtonClicked)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonClicked)];
}


- (void)leftButtonClicked{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)rightButtonClicked{
    //todo
    
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    return YES;
}

+(void)presentToUserChangeInfoViewControllerWithContentString:(NSString *)contentString fromViewController:(UIViewController *)viewController{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:UserStoryboard bundle:nil];
    UINavigationController *navi = [storyboard instantiateViewControllerWithIdentifier:UserChangeInfoViewControllerNavi];
    UserChangeInfoViewController *vc = [storyboard instantiateViewControllerWithIdentifier:UserChangeInfoViewControllerID];
    vc.contentString = contentString;
    [viewController presentViewController:navi animated:YES completion:nil];

    
}

@end
