//
//  AccountRelatedAPI.m
//  MakeThings
//
//  Created by Jing Ye on 06/05/2018.
//  Copyright © 2018 aiwen. All rights reserved.
//

#import "AccountRelatedAPI.h"
#import "MTUrlRequestHander.h"
#import "RequestUrlPathDefine.h"

@implementation AccountRelatedAPI

- (void)requestSMSCodeWithPhoneNUmber:(NSString *)phoneNumber
                         successBlock:(void(^)(NSDictionary *responseDic))success
                          failedBlock:(void(^)(NSString *errorString))failed{
    
    NSDictionary *parameter = @{@"phone":phoneNumber,
                                @"codeType":@"register"
                                };
    [self POST:[MTUrlRequestHander urlStringWithBussniessName:SendSMSPath] parameters:parameter success:^(id responseData, id<ResponseInfoProtocol> responseInfo) {
        if (success) {
            success(responseData);
        }
    } failure:^(NSString *errorString, id<ResponseInfoProtocol> responseInfo) {
        if (failed) {
            failed(errorString);
        }
    }];
    
}

- (void)userRegisterWithPhone:(NSString *)phoneNumber
                      SMSCode:(NSString *)SMSCode
                     password:(NSString *)password
                         name:(NSString *)name
                 successBlock:(void(^)(NSDictionary *responseDic))success
                  failedBlock:(void(^)(NSString *errorString))failed{
    
    NSDictionary *parameters = @{@"phone":phoneNumber,
                                 @"code":SMSCode,
                                 @"password":password,
                                 @"name":name
                                 };
    
    [self POST:[MTUrlRequestHander urlStringWithBussniessName:RegisterPath] parameters:parameters success:^(id responseData, id<ResponseInfoProtocol> responseInfo) {
        if (success) {
            success(responseData);
        }
    } failure:^(NSString *errorString, id<ResponseInfoProtocol> responseInfo) {
        if (failed) {
            failed(errorString);
        }
    }];
}

- (void)userLoginWithPhoneNumber:(NSString *)phoneNumber
                        password:(NSString *)password                  successBlock:(void(^)(NSDictionary *responseDic))success
                     failedBlock:(void(^)(NSString *errorString))failed{
    NSDictionary *parameters = @{@"phone":phoneNumber,
                                 @"password":password
                                 };
    [self POST:[MTUrlRequestHander urlStringWithBussniessName:LoginPath] parameters:parameters success:^(id responseData, id<ResponseInfoProtocol> responseInfo) {
        if (success) {
            success(responseData);
        }
    } failure:^(NSString *errorString, id<ResponseInfoProtocol> responseInfo) {
        if (failed) {
            failed(errorString);
        }
    }];
}



@end
