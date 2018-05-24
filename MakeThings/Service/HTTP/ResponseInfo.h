//
//  ResponseInfo.h
//  MLLCustomer
//
//  Created by chester on 2016/9/23.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpResponseProtocol.h"
#import <AFNetworking/AFNetworking.h>

/**
 网络返回response信息
 */
@interface ResponseInfo : NSObject<ResponseInfoProtocol>

- (instancetype)initWithSessionTask:(NSURLSessionDataTask *)task;

//内部获取
@property(nonatomic, readonly) NSURLSessionDataTask *myTask;

@end
