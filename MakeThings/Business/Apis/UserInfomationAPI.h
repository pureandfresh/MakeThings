//
//  UserInfomationAPI.h
//  MakeThings
//
//  Created by Jing Ye on 15/05/2018.
//  Copyright © 2018 aiwen. All rights reserved.
//

#import "BaseRequestAPI.h"

@interface UserInfomationAPI : BaseRequestAPI


/*   请求用户粉丝数 关注数等  */

- (void)requestUserStatisticWithUserId:(NSString *)userId
                          successBlock:(void(^)(NSDictionary *responseDic))success
                           failedBlock:(void(^)(NSString *errorString))failed;

/*    获取收货地址列表    */
- (void)requestUserAddressListWithContact:(NSString *)contactName
                              phoneNumber:(NSString *)phoneNumber
                                   region:(NSString *)region
                          detailedAddress:(NSString *)detailedAddress
                                isDefault:(NSString *)isDefault
                                   userID:(NSString *)userID
                             successBlock:(void(^)(NSDictionary *responseDic))success                            failedBlock:(void(^)(NSString *errorString))failed;

/*    新增收货地址    */
- (void)UserAddNewAddressWithContact:(NSString *)contactName
                         phoneNumber:(NSString *)phoneNumber
                              region:(NSString *)region
                     detailedAddress:(NSString *)detailedAddress
                           isDefault:(NSString *)isDefault
                        successBlock:(void(^)(NSDictionary *responseDic))success                            failedBlock:(void(^)(NSString *errorString))failed;
/*    修改收货地址    */
- (void)userModifyTheAddressWithContacts:(NSString *)contactName
                        phoneNumber:(NSString *)phoneNumber
                             region:(NSString *)region
                    detailedAddress:(NSString *)detailedAddress
                               isDefault:(NSString *)isDefault
                                  UserID:(NSString *)UserID
                       successBlock:(void(^)(NSDictionary *responseDic))success                            failedBlock:(void(^)(NSString *errorString))failed;
/*    删除收货地址    */

- (void)UserDeleteTheAddressWithID:(NSString *)id successBlock:(void(^)(NSDictionary *responseDic))success                            failedBlock:(void(^)(NSString *errorString))failed;






@end
