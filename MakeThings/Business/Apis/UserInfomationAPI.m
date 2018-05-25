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
    
    [self POST:[MTUrlRequestHander urlStringWithBussniessName:userStatisticsPath] parameters:parameter success:^(id responseData, id<ResponseInfoProtocol> responseInfo) {
        if (success) {
            success(responseData);
        }
    } failure:^(NSString *errorString, id<ResponseInfoProtocol> responseInfo) {
        if (failed) {
            failed(errorString);
        }
    }];
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
    [self POST:[MTUrlRequestHander urlStringWithBussniessName:AddNewAddress] parameters:parameters success:^(id responseData, id<ResponseInfoProtocol> responseInfo) {
        
    } failure:^(NSString *errorString, id<ResponseInfoProtocol> responseInfo) {
        
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

@end
