//
//  InitialViewController.m
//  MakeThings
//
//  Created by Jing Ye on 11/05/2018.
//  Copyright © 2018 aiwen. All rights reserved.
//

#import "InitialViewController.h"
#import "LoginViewController.h"
#import "MainTabBarViewController.h"
#import "MTAplicationUser.h"
#import "UserViewController.h"

@interface InitialViewController ()

@end

@implementation InitialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self checkInfo];
    
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)checkInfo{
   MTAplicationUser *user = [[MTAplicationUser sharedAplicationUser] getLatestLoginUser];
    if (!user) {
        [LoginViewController pushToLoginViewControllerWithFromViewController:self];
    }else{
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:MainStoryboard bundle:nil];
        MainTabBarViewController *vc = [storyboard instantiateViewControllerWithIdentifier:MainTabBarViewControllerID];
        [self.navigationController pushViewController:vc animated:YES];

    }
}




@end
