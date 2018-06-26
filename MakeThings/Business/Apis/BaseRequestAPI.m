//
//  BaseRequestAPI.m
//  MakeThings
//
//  Created by Jing Ye on 06/05/2018.
//  Copyright © 2018 aiwen. All rights reserved.
//

#import "BaseRequestAPI.h"
#import "LoginViewController.h"

@implementation BaseRequestAPI

- (void)postWithUrlString:(NSString *)urlString
               parameters:(NSDictionary *)parameters
             successBlock:(void(^)(NSDictionary *responseDic))success
              failedBlock:(void(^)(NSString *errorString))failed{
    
    [self POST:urlString parameters:parameters success:^(id responseData, id<ResponseInfoProtocol> responseInfo) {
        if (![responseData[@"status"] isKindOfClass:[NSNull class]]) {
            NSString *status = [NSString stringWithFormat:@"%@",responseData[@"status"]];
            if (status.integerValue == -2) {
                // session expired
                [self handleUserSessionExpired];
            }
        }
        if (success) {
            success(responseData);
        }
    } failure:^(NSString *errorString, id<ResponseInfoProtocol> responseInfo) {
        if (failed) {
            failed(errorString);
        }
    }];
}

- (void)handleUserSessionExpired{
    [LoginViewController presentToLoginViewControllerWithFromViewController:[self getCurrentViewController]];

}
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
