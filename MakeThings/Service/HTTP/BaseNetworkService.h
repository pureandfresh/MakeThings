//
//  BaseNetworkService.h
//  MLLNetWorkService
//
//  Created by chester on 7/31/14.
//  Copyright © 2015 mac. All rights reserved.d.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "MOLJSONRequestSerializer.h"
#import "MOLJSONResponseSerializer.h"
#import "HttpResponseProtocol.h"

// default open cache
#define Open_Request_Cache  1

#define Error_NoData            @"无数据"
#define Error_Argument          @"参数错误"
#define Error_DataParse         @"数据解析错误"


//BaseNetworkService调试模式
static BOOL openDebug = YES;

typedef void(^MNSCompletionBlock)(id responseData, id<ResponseInfoProtocol> responseInfo);
typedef void(^MNSFailureBlock)(NSString *errorString, id<ResponseInfoProtocol> responseInfo);

/**
 *  Base networking frame work
 */
@interface BaseNetworkService : NSObject

- (void*)getKey;

@property (nonatomic) AFHTTPSessionManager *sessoinManager;

- (NSURLRequest *)GET:(NSString *)urlString
           parameters:(NSDictionary *)parameters
              success:(MNSCompletionBlock)success
              failure:(MNSFailureBlock)failure;

- (NSURLRequest *)GET:(NSString *)urlString
             hitCache:(void (^)(BOOL isHit))hitCache
           parameters:(NSDictionary *)parameters
              success:(MNSCompletionBlock)success
              failure:(MNSFailureBlock)failure;

- (NSURLRequest *)GET:(NSString *)urlString
             hitCache:(void (^)(BOOL isHit))hitCache
             interval:(NSTimeInterval)expirationInterval
           parameters:(NSDictionary *)parameters
              success:(MNSCompletionBlock)success
              failure:(MNSFailureBlock)failure;

- (NSURLRequest *)GET:(NSString *)urlString
            withCache:(BOOL)useCache
           parameters:(NSDictionary *)parameters
              success:(MNSCompletionBlock)success
              failure:(MNSFailureBlock)failure;

- (NSURLRequest *)GET:(NSString *)urlString
            withCache:(BOOL)useCache
             interval:(NSTimeInterval)expirationInterval
           parameters:(NSDictionary *)parameters
              success:(MNSCompletionBlock)success
              failure:(MNSFailureBlock)failure;

- (NSURLRequest *)GET:(NSString *)urlString
     withRefreshCache:(BOOL)beRefreshCache
           parameters:(NSDictionary *)parameters
              success:(MNSCompletionBlock)success
              failure:(MNSFailureBlock)failure;

- (NSURLRequest *)GET:(NSString *)urlString
           parameters:(NSDictionary *)parameters
             hitCache:(void (^)(BOOL isHit))hitCache
             interval:(NSTimeInterval)expirationInterval
     withRefreshCache:(BOOL)beRefreshCache
         successBlock:(MNSCompletionBlock)success
         failureBlock:(MNSFailureBlock)failure;


//GET JSON
- (NSURLRequest *)GET:(NSString *)urlString
                 JSON:(id)JSON
             hitCache:(void (^)(BOOL isHit))hitCache
             interval:(NSTimeInterval)expirationInterval
     withRefreshCache:(BOOL)beRefreshCache
         successBlock:(MNSCompletionBlock)success
         failureBlock:(MNSFailureBlock)failure;

// URL-Form-Encoded Post(Post Value)
- (NSURLRequest *)POST:(NSString *)urlString
            parameters:(NSDictionary *)parameters
               success:(MNSCompletionBlock)success
               failure:(MNSFailureBlock)failure;

// Post JSON
- (NSURLRequest *)POST:(NSString *)urlString
                  JSON:(id)parameters
               success:(MNSCompletionBlock)success
               failure:(MNSFailureBlock)failure;

// POST param and file with http stream
// in AFMultipartFormData Protocol we insert the file data and the content type
- (NSURLRequest *)POST:(NSString *)URLString
            parameters:(nullable id)parameters
              progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
constructingBodyWithBlock:(nullable void (^)(id<AFMultipartFormData> _Nonnull))block
               success:(nullable MNSCompletionBlock)success
               failure:(nullable MNSFailureBlock)failure;


/**
 *  Cancel ALL network requests
 */
- (void)cancelRequests;


/**
 Cancel Specific Task

 @param task Task needed to be cancel
 */
- (void)cancelRequestWithResponseInfo:(_Nonnull id<ResponseInfoProtocol>)responseInfo;

/**
 *  便捷方法，获取operation的request用于对应Request删除
 */
- (void)removeCachedResponseWithResponseInfo:(_Nonnull id<ResponseInfoProtocol>)responseInfo;

/**
 *  给定Request删除Response
 */
- (void)removeCachedResponseForRequest:(NSURLRequest * _Nonnull)request;

@end


