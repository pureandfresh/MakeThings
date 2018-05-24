//
//  AccountRelatedAPI.h
//  MakeThings
//
//  Created by Jing Ye on 06/05/2018.
//  Copyright © 2018 aiwen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseRequestAPI.h"
@interface AccountRelatedAPI : BaseRequestAPI

/* SMS */
- (void)requestSMSCodeWithPhoneNUmber:(NSString *)phoneNumber
                         successBlock:(void(^)(NSDictionary *responseDic))success
                          failedBlock:(void(^)(NSString *errorString))failed;

/* register */
- (void)userRegisterWithPhone:(NSString *)phoneNumber
                      SMSCode:(NSString *)SMSCode
                     password:(NSString *)password
                         name:(NSString *)name
                 successBlock:(void(^)(NSDictionary *responseDic))success
                  failedBlock:(void(^)(NSString *errorString))failed;

/* login */
- (void)userLoginWithPhoneNumber:(NSString *)phoneNumber
                        password:(NSString *)password                  successBlock:(void(^)(NSDictionary *responseDic))success
                     failedBlock:(void(^)(NSString *errorString))failed;



@end
