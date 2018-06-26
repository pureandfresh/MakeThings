//
//  UIViewController+Extention.m
//  MakeThings
//
//  Created by Jing Ye on 29/05/2018.
//  Copyright © 2018 aiwen. All rights reserved.
//

#import "UIViewController+Extention.h"

@implementation UIViewController (Extention)

- (UIViewController*)getCurrentViewController{
    UIViewController* vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (1)
    {
        if ([vc isKindOfClass:[UITabBarController class]]) {
            vc = ((UITabBarController*)vc).selectedViewController;
        }
        if ([vc isKindOfClass:[UINavigationController class]]) {
            vc = ((UINavigationController*)vc).visibleViewController;
        }
        if (vc.presentedViewController) {
            vc = vc.presentedViewController;
        }else{
            break;
        }
    }
    return vc;
}
@end
