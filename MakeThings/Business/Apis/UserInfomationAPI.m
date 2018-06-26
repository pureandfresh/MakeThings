//
//  UserInfomationAPI.m
//  MakeThings
//
//  Created by Jing Ye on 15/05/2018.
//  Copyright © 2018 aiwen. All rights reserved.
//

#import "UserInfomationAPI.h"
#import "MTUrlRequestHander.h"
#import "RequestUrlPathDefine.h"

@implementation UserInfomationAPI



- (void)requestUserStatisticWithUserId:(NSString *)userId
                          successBlock:(void(^)(NSDictionary *responseDic))success
                           failedBlock:(void(^)(NSString *errorString))failed{
    
    NSDictionary *parameter = @{@"id":userId};
    
    [self postWithUrlString:[MTUrlRequestHander urlStringWithBussniessName:userStatisticsPath] parameters:parameter successBlock:^(NSDictionary *responseDic) {
        if (success) {
            success(responseDic);
        }
    } failedBlock:^(NSString *errorString) {
        if (failed) {
            failed(errorString);
        }
    }];
    
//    [self POST:[MTUrlRequestHander urlStringWithBussniessName:userStatisticsPath] parameters:parameter success:^(id responseData, id<ResponseInfoProtocol> responseInfo) {
//        if (success) {
//            success(responseData);
//        }
//    } failure:^(NSString *errorString, id<ResponseInfoProtocol> responseInfo) {
//        if (failed) {
//            failed(errorString);
//        }
//    }];
}

- (void)requestUserAddressListWithContact:(NSString *)contactName
                              phoneNumber:(NSString *)phoneNumber
                                   region:(NSString *)region
                          detailedAddress:(NSString *)detailedAddress
                                isDefault:(NSString *)isDefault
                                   userID:(NSString *)userID
                             successBlock:(void(^)(NSDictionary *responseDic))success                            failedBlock:(void(^)(NSString *errorString))failed{
    
    NSDictionary *parameters = @{@"contacts":contactName,
                                  @"phone":phoneNumber,
                                  @"region":region,
                                  @"detailedAddress":detailedAddress,
                                  @"isDefault":isDefault,
                                  @"id":userID
                                  };
    [self POST:[MTUrlRequestHander urlStringWithBussniessName:ObtainAllAddress] parameters:parameters success:^(id responseData, id<ResponseInfoProtocol> responseInfo) {
        if (success) {
            success(responseData);
        }
    } failure:^(NSString *errorString, id<ResponseInfoProtocol> responseInfo) {
        if (failed) {
            failed(errorString);
        }
    }];
}



- (void)UserAddNewAddressWithContact:(NSString *)contactName
                         phoneNumber:(NSString *)phoneNumber
                              region:(NSString *)region
                     detailedAddress:(NSString *)detailedAddress
                           isDefault:(NSString *)isDefault
                        successBlock:(void(^)(NSDictionary *responseDic))success                            failedBlock:(void(^)(NSString *errorString))failed{
    
    NSDictionary *parameters = @{@"contacts":contactName,
                                 @"phone":phoneNumber,
                                 @"region":region,
                                 @"detailedAddress":detailedAddress,
                                 @"isDefault":isDefault
                                 };
    
    [self POST:[MTUrlRequestHander urlStringWithBussniessName:AddNewAddress] parameters:parameters
       success:^(id responseData, id<ResponseInfoProtocol> responseInfo) {
           if (success) {
               success(responseData);
           }
       } failure:^(NSString *errorString, id<ResponseInfoProtocol> responseInfo) {
           if (failed) {
               failed(errorString);
           }
       }];
}

- (void)userDeleteAddressByContacts:(NSString *)contactName
                        phoneNumber:(NSString *)phoneNumber
                             region:(NSString *)region
                    detailedAddress:(NSString *)detailedAddress
                          isDefault:(NSString *)isDefault
                       successBlock:(void(^)(NSDictionary *responseDic))success                            failedBlock:(void(^)(NSString *errorString))failed{
    
    NSDictionary *parameters = @{@"contacts":contactName,
                                 @"phone":phoneNumber,
                                 @"region":region,
                                 @"detailedAddress":detailedAddress,
                                 @"isDefault":isDefault
                                 };
    [self POST: [MTUrlRequestHander urlStringWithBussniessName:AddNewAddress]parameters:parameters success:^(id responseData, id<ResponseInfoProtocol> responseInfo) {
        if (success) {
            success(responseData);
        }
    } failure:^(NSString *errorString, id<ResponseInfoProtocol> responseInfo) {
        if (failed) {
            failed(errorString);
        }
    }];
}

- (void)userChangeInfoWithHeadImgUrl:(NSString *)headImgUrl
                                name:(NSString *)name
                              gender:(NSString *)gender
                             address:(NSString *)address
                           signature:(NSString *)signature
                                 age:(NSString *)age
                              idcard:(NSString *)idcard
                        successBlock:(void(^)(NSDictionary *responseDic))success                            failedBlock:(void(^)(NSString *errorString))failed{
    NSDictionary *parameters = @{@"headImgUrl":headImgUrl,
                                 @"name":name,
                                 @"gender":gender,
                                 @"address":address,
                                 @"signature":signature,
                                 @"age":age,
                                 @"idcard":idcard
                                 };
    [self POST:[MTUrlRequestHander urlStringWithBussniessName:AddNewAddress] parameters:parameters success:^(id responseData, id<ResponseInfoProtocol> responseInfo) {
        if (success) {
            success(responseData);
        }
    } failure:^(NSString *errorString, id<ResponseInfoProtocol> responseInfo) {
        if (failed) {
            failed(errorString);
        }
    }];
}

- (void)userForgetPasswordWithPhoneNumber:(NSString *)phoneNumber
                                 password:(NSString *)password
                                     code:(NSString *)code
                             successBlock:(void(^)(NSDictionary *responseDic))success                            failedBlock:(void(^)(NSString *errorString))failed{
    NSDictionary *parameters = @{
                                 @"phone":phoneNumber,
                                 @"password":password,
                                 @"code":code
                          };
    
    [self POST:[MTUrlRequestHander urlStringWithBussniessName:AddNewAddress] parameters:parameters success:^(id responseData, id<ResponseInfoProtocol> responseInfo) {
        if (success) {
            success(responseData);
        }
    } failure:^(NSString *errorString, id<ResponseInfoProtocol> responseInfo) {
        if (failed) {
            failed(errorString);
        }
    }];
    
}


- (void)userChangePasswordWithPhoneNumber:(NSString *)phoneNumber
                                password:(NSString *)password
                             oldPassword:(NSString *)oldPassword
                            successBlock:(void(^)(NSDictionary *responseDic))success                            failedBlock:(void(^)(NSString *errorString))failed{
    NSDictionary *parameters = @{
                                 @"phone":phoneNumber,
                                 @"password":password,
                                 @"oldPassword":oldPassword
                                 };
    
    [self POST:[MTUrlRequestHander urlStringWithBussniessName:AddNewAddress] parameters:parameters success:^(id responseData, id<ResponseInfoProtocol> responseInfo) {
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
