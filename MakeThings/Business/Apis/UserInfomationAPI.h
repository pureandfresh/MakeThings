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


@end
