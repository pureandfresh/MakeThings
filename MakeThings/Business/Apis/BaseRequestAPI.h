//
//  BaseRequestAPI.h
//  MakeThings
//
//  Created by Jing Ye on 06/05/2018.
//  Copyright © 2018 aiwen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseNetworkService.h"

@protocol BaseRequestAPIDelegate <NSObject>

- (void)userSessionExpired;


@end


@interface BaseRequestAPI : BaseNetworkService
@property (nonatomic,assign) id<BaseRequestAPIDelegate> delegate;

/*   为了统一处理response中某个code对应的场景  */
- (void)postWithUrlString:(NSString *)urlString
               parameters:(NSDictionary *)parameters
             successBlock:(void(^)(NSDictionary *responseDic))success
              failedBlock:(void(^)(NSString *errorString))failed;
@end
