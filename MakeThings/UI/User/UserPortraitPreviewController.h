//
//  UserPortraitPreviewController.h
//  MakeThings
//
//  Created by Jing Ye on 22/05/2018.
//  Copyright © 2018 aiwen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTBaseViewController.h"

@interface UserPortraitPreviewController : MTBaseViewController


+ (void)pushToUserPortraitPreviewControllerWithImage:(UIImage *)portraitImage fromViewController:(UIViewController *)controller;
@end
