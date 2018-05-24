//
//  LoginViewController.h
//  MakeThings
//
//  Created by Jing Ye on 25/04/2018.
//  Copyright © 2018 aiwen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTBaseViewController.h"

@interface LoginViewController : MTBaseViewController

+(void)pushToLoginViewControllerWithFromViewController:(UIViewController *)fromViewController;

+(void)presentToLoginViewControllerWithFromViewController:(UIViewController *)fromViewController;
@end
