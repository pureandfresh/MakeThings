//
//  BaseNetworkService.m
//  MLLNetWorkService
//
//  Created by chester on 7/31/14.
//  Copyright © 2015 mac. All rights reserved.d.
//

#import "BaseNetworkService.h"
#import "MOLCustomURLCache.h"
#import "ResponseInfo.h"
#import <objc/runtime.h>

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#define SS(strongSelf,weakSelf) __strong __typeof(weakSelf)strongSelf = weakSelf;

#define FailDebugInfoKey @"NSDebugDescription"

static char errorKey;

@interface BaseNetworkService ()


@property (nonatomic) NSMutableArray <id<ResponseInfoProtocol>> *currentWorkingTasks;
@end

@implementation BaseNetworkService

- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        
        MOLJSONResponseSerializer *jsonResponseSerializer = [MOLJSONResponseSerializer
                                                                 serializerWithReadingOptions:NSJSONReadingAllowFragments];
        MOLHttpRequestSerializer *httpRequestSerializer = [MOLHttpRequestSerializer serializer];
        
        _sessoinManager = [[AFHTTPSessionManager alloc] init];
        _sessoinManager.requestSerializer = httpRequestSerializer;
        _sessoinManager.responseSerializer = jsonResponseSerializer;

        //添加当前API对象正工作中的Task
        _currentWorkingTasks = [NSMutableArray array];
        
  
  /*
        //====== Apple ATS:备用，别删除 -
        
        //验证客户端的证书
        NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"https" ofType:@"cer"];
        NSData * certData =[NSData dataWithContentsOfFile:cerPath];
        NSSet *certs = [NSSet setWithObjects:certData, nil];
        
        //无条件信任服务器证书
        AFSecurityPolicy *securityPolicy1 = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        
        //使用公钥验证模式（2）
        //AFSecurityPolicy *securityPolicy2 = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey];
        
        //使用证书验证模式（3）
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];

        // 设置证书用于证书验证模式(2-3)
        [securityPolicy setPinnedCertificates:certs];
        
        
        // 是否允许,NO-- 不允许无效的证书，不允许自建证书，必须满足CA证书（NO），允许则(YES，便于调试)
        // 注意，这里为NO时，即便PinningMode为None，也依然需要是CA证书才能通过验证。
        //所以如果要做自签名，这里需要开启无效通过标记，且使用证书/公钥验证模式。
   
        [securityPolicy setAllowInvalidCertificates:NO];
        securityPolicy.validatesDomainName = YES;    //要验证域名一致性(需要调试)
        
        _sessoinManager.securityPolicy = securityPolicy;
        
        //====== Apple ATS:备用，别删除 ======
   */
    
    }
    
    return self;
}

- (void*)getKey{
    return &errorKey;
}

#pragma mark - Get Method

- (NSURLRequest *)GET:(NSString *)urlString
           parameters:(NSDictionary *)parameters
              success:(MNSCompletionBlock)success
              failure:(MNSFailureBlock)failure {
#if Open_Request_Cache
    _sessoinManager.requestSerializer.cachePolicy = NSURLRequestReturnCacheDataElseLoad;
#endif
    
    return [self GET:urlString
          parameters:parameters
            hitCache:nil
            interval:CustomURLCacheExpirationInterval
    withRefreshCache:NO
        successBlock:success
        failureBlock:failure];
}

- (NSURLRequest *)GET:(NSString *)urlString
             hitCache:(void (^)(BOOL isHit))hitCache
           parameters:(NSDictionary *)parameters
              success:(MNSCompletionBlock)success
              failure:(MNSFailureBlock)failure {
    
    return [self GET:urlString
            hitCache:hitCache
            interval:CustomURLCacheExpirationInterval
          parameters:parameters
             success:success
             failure:failure];
}

- (NSURLRequest *)GET:(NSString *)urlString
             hitCache:(void (^)(BOOL isHit))hitCache
             interval:(NSTimeInterval)expirationInterval
           parameters:(NSDictionary *)parameters
              success:(MNSCompletionBlock)success
              failure:(MNSFailureBlock)failure {
#if Open_Request_Cache
    _sessoinManager.requestSerializer.cachePolicy = NSURLRequestReturnCacheDataElseLoad;
#endif
    
    return [self GET:urlString
          parameters:parameters
            hitCache:hitCache
            interval:expirationInterval
    withRefreshCache:NO
        successBlock:success
        failureBlock:failure];
}

- (NSURLRequest *)GET:(NSString *)urlString
            withCache:(BOOL)useCache
           parameters:(NSDictionary *)parameters
              success:(MNSCompletionBlock)success
              failure:(MNSFailureBlock)failure {
    return [self GET:urlString
           withCache:useCache
            interval:CustomURLCacheExpirationInterval
          parameters:parameters
             success:success
             failure:failure];
}

- (NSURLRequest *)GET:(NSString *)urlString
            withCache:(BOOL)useCache
             interval:(NSTimeInterval)expirationInterval
           parameters:(NSDictionary *)parameters
              success:(MNSCompletionBlock)success
              failure:(MNSFailureBlock)failure {
    
    if (useCache)
        _sessoinManager.requestSerializer.cachePolicy = NSURLRequestReturnCacheDataElseLoad;
    else
        _sessoinManager.requestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;

    return [self GET:urlString
          parameters:parameters
            hitCache:nil
            interval:expirationInterval
    withRefreshCache:NO
        successBlock:success
        failureBlock:failure];
}

- (NSURLRequest *)GET:(NSString *)urlString
     withRefreshCache:(BOOL)beRefreshCache
           parameters:(NSDictionary *)parameters
              success:(MNSCompletionBlock)success
              failure:(MNSFailureBlock)failure {
    
    if (!beRefreshCache) {
        //如果不refresh，这里就是一次性请求的，且不会冲cache
        return [self GET:urlString withCache:NO parameters:parameters success:success failure:failure];
    } else {
        return [self GET:urlString parameters:parameters hitCache:nil interval:CustomURLCacheExpirationInterval withRefreshCache:beRefreshCache successBlock:success failureBlock:failure];
    }
}

- (NSURLRequest *)GET:(NSString *)urlString
           parameters:(NSDictionary *)parameters
             hitCache:(void (^)(BOOL isHit))hitCache
             interval:(NSTimeInterval)expirationInterval
     withRefreshCache:(BOOL)beRefreshCache
         successBlock:(MNSCompletionBlock)success
         failureBlock:(MNSFailureBlock)failure {
    
    if (!urlString) {
        if (failure) {
            failure(Error_Argument,nil);
        }
        return nil;
    }
    return [self customGetMethodWithURLString:urlString
                                   parameters:parameters
                                     hitCache:hitCache
                                     interval:expirationInterval
                             withRefreshCache:beRefreshCache
                                 successBlock:success
                                 failureBlock:failure];
}

- (NSURLRequest *)GET:(NSString *)urlString
                 JSON:(id)JSON
             hitCache:(void (^)(BOOL isHit))hitCache
             interval:(NSTimeInterval)expirationInterval
     withRefreshCache:(BOOL)beRefreshCache
         successBlock:(MNSCompletionBlock)success
         failureBlock:(MNSFailureBlock)failure {
    if (!urlString) {
        if (failure) {
            failure(Error_Argument,nil);
        }
        return nil;
    }
    
    return [self customGetMethodWithURLString:urlString
                                   parameters:JSON
                                     hitCache:hitCache
                                     interval:expirationInterval
                             withRefreshCache:beRefreshCache
                                 successBlock:success
                                 failureBlock:failure];
}


#pragma mark - private method
/**
 *  拼装Request
 */
- (NSMutableURLRequest *)requestWithMethod:(NSString *)method
                                 URLString:(NSString *)URLString
                                parameters:(id)parameters
                                     error:(NSError *__autoreleasing *)error {
    
    NSString *urlstring = [NSURL URLWithString:URLString
                                 relativeToURL:_sessoinManager.baseURL].absoluteString;
    if (!urlstring) {
        urlstring = URLString;
    }
    
    return [_sessoinManager.requestSerializer requestWithMethod:method
                                                      URLString:urlstring
                                                     parameters:parameters
                                                          error:error];
}

/**
 *  自定义GET请求
 */
- (NSURLRequest *)customGetMethodWithURLString:(NSString *)urlString
                                    parameters:(NSDictionary *)parameters
                                      hitCache:(void (^)(BOOL isHit))hitCache
                                      interval:(NSTimeInterval)expirationInterval
                              withRefreshCache:(BOOL)beRefreshCache
                                  successBlock:(MNSCompletionBlock)success
                                  failureBlock:(MNSFailureBlock)failure {
    NSError *serializationError = nil;
    
    //修改HRS
    MOLHttpRequestSerializer *httpRequestSerializer = [MOLHttpRequestSerializer serializer];
    _sessoinManager.requestSerializer = httpRequestSerializer;
    
    NSMutableURLRequest *request = [self requestWithMethod:@"GET"
                                                 URLString:urlString
                                                parameters:parameters
                                                     error:&serializationError];
    
    if (serializationError) {
        if (failure) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu"
            dispatch_async(_sessoinManager.completionQueue ?: dispatch_get_main_queue(), ^{
                //failure(nil, serializationError);
                failure(serializationError.localizedDescription,nil);
            });
#pragma clang diagnostic pop
        }
        
        return nil;
    }
    
    BOOL __block responseFromCache = YES;
    
    void (^successWrapper)(id<ResponseInfoProtocol> responseInfo, id responseObject) = ^(id<ResponseInfoProtocol> responseInfo, id responseObject) {
        if (success) {
            success(responseObject,responseInfo);
        }
    };
    
    void (^requestFailureBlock)(id<ResponseInfoProtocol> responseInfo, NSError *error) = ^(id<ResponseInfoProtocol> responseInfo, NSError *error) {
        NSLog(@"ERROR: %@", error);
       // DDLogVerbose(@"ERROR: %@", error);
        if (failure) {
            if (error.code == NSURLErrorCancelled) {
                return ;
            }

            objc_setAssociatedObject(responseInfo, &errorKey, error, OBJC_ASSOCIATION_RETAIN);
            if ([error.userInfo objectForKey:NSLocalizedDescriptionKey]) {
                failure([error.userInfo objectForKey:NSLocalizedDescriptionKey], responseInfo);
            } else if ([error.userInfo objectForKey:FailDebugInfoKey]) {
                failure([error.userInfo objectForKey:FailDebugInfoKey], responseInfo);
            }
        }
    };
    
    [MOLCustomURLCache setExpirationInterval:request interval:expirationInterval];
    
    if (openDebug) {
       DDLogVerbose(@"***Debug*** request:--------%@-------",request.URL);
    }

    if (beRefreshCache) {
        [[MOLCustomURLCache shareMeileleURLCache] removeCachedResponseForRequest:request];
    }
    
    if (hitCache) {
        hitCache([[MOLCustomURLCache shareMeileleURLCache] isHit:request]);
    }
 
    WS(weakSelf)
    __block NSURLSessionDataTask *dataTask = [_sessoinManager dataTaskWithRequest:request
                                                           uploadProgress:nil
                                                         downloadProgress:nil
                                                        completionHandler:^(NSURLResponse * __unused response, id responseObject, NSError *error) {
                                                            
                                                            ResponseInfo *resInfo = [[ResponseInfo alloc] initWithSessionTask:dataTask];
                                                            
                                                            if (error) {
                                                                if (requestFailureBlock) {
                                                                    requestFailureBlock(resInfo, error);
                                                                }
                                                            } else {
                                                                if (successWrapper) {
                                                                    successWrapper(resInfo, responseObject);
                                                                }
                                                            }
                                                            
                                                            SS(strongSelf, weakSelf)
                                                            if (strongSelf) {
                                                                [strongSelf removeTask:resInfo];
                                                            }
                                                        }];
    
    [_sessoinManager setDataTaskWillCacheResponseBlock:^NSCachedURLResponse * _Nonnull(NSURLSession * _Nonnull session, NSURLSessionDataTask * _Nonnull dataTask, NSCachedURLResponse * _Nonnull proposedResponse) {
        responseFromCache = NO;
        return proposedResponse;
    }];
    
    [self authChanllengeWithSessionMananger:_sessoinManager];
    
    [dataTask resume];
    
    //添加task对象
    ResponseInfo *resInfo = [[ResponseInfo alloc] initWithSessionTask:dataTask];
    [self addTask:resInfo];
    
    NSURLRequest *rtRequest = dataTask.originalRequest;
    return rtRequest;
}


// TLS握手自定义回调过程，按需删减
- (void)authChanllengeWithSessionMananger:(AFHTTPSessionManager *)sessionMananger{

    /*
    WS(weakSelf)
    [sessionMananger setSessionDidReceiveAuthenticationChallengeBlock:^NSURLSessionAuthChallengeDisposition(NSURLSession * _Nonnull session, NSURLAuthenticationChallenge * _Nonnull challenge, NSURLCredential *__autoreleasing  _Nullable * _Nullable credential) {
        
        NSURLSessionAuthChallengeDisposition disposition = NSURLSessionAuthChallengePerformDefaultHandling;

        __autoreleasing NSURLCredential *_credential = nil;
        if([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
            if ([weakSelf.sessoinManager.securityPolicy evaluateServerTrust:challenge.protectionSpace.serverTrust forDomain:challenge.protectionSpace.host]) {
                _credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
                if (_credential) {
                    disposition = NSURLSessionAuthChallengeUseCredential;
                } else {
                    disposition = NSURLSessionAuthChallengePerformDefaultHandling;
                }
            } else {
                disposition = NSURLSessionAuthChallengeRejectProtectionSpace;
            }
        }
        else if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodClientCertificate]) {
            
            SecIdentityRef identity = NULL;
            SecTrustRef trust = NULL;
            NSString *p12 = [[NSBundle mainBundle] pathForResource:@"client"ofType:@"p12"];
            NSFileManager *fileManager =[NSFileManager defaultManager];
            
            if(![fileManager fileExistsAtPath:p12])
            {
                DDLogVerbose(@"client.p12:not exist");
            }
            else
            {
                NSData *PKCS12Data = [NSData dataWithContentsOfFile:p12];
                if ([weakSelf extractIdentity:&identity andTrust:&trust fromPKCS12Data:PKCS12Data])
                {
                    SecCertificateRef certificate = NULL;
                    SecIdentityCopyCertificate(identity, &certificate);
                    const void*certs[] = {certificate};
                    CFArrayRef certArray =CFArrayCreate(kCFAllocatorDefault, certs,1,NULL);
                    
                    _credential = [NSURLCredential credentialWithIdentity:identity
                                                             certificates:(__bridge  NSArray*)certArray
                                                              persistence:NSURLCredentialPersistencePermanent];
                    
                    disposition =NSURLSessionAuthChallengeUseCredential;
                }
            }
        }
        else
            disposition = NSURLSessionAuthChallengePerformDefaultHandling;
        
        *credential = _credential;
        return disposition;
    }];
     */
}

/*
-(BOOL)extractIdentity:(SecIdentityRef*)outIdentity andTrust:(SecTrustRef *)outTrust fromPKCS12Data:(NSData *)inPKCS12Data {
    OSStatus securityError = errSecSuccess;
    
    NSDictionary*optionsDictionary = [NSDictionary dictionaryWithObject:@""
                                                                 forKey:(__bridge id)kSecImportExportPassphrase];
    
    CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
    securityError = SecPKCS12Import((__bridge CFDataRef)inPKCS12Data,(__bridge CFDictionaryRef)optionsDictionary,&items);
    
    if(securityError == 0) {
        CFDictionaryRef myIdentityAndTrust =CFArrayGetValueAtIndex(items,0);
        const void*tempIdentity =NULL;
        tempIdentity= CFDictionaryGetValue (myIdentityAndTrust,kSecImportItemIdentity);
        *outIdentity = (SecIdentityRef)tempIdentity;
        const void*tempTrust =NULL;
        tempTrust = CFDictionaryGetValue(myIdentityAndTrust,kSecImportItemTrust);
        *outTrust = (SecTrustRef)tempTrust;
    } else {
        DDLogVerbose(@"Failedwith error code %d",(int)securityError);
        return NO;
    }
    return YES;
}
*/

#pragma mark - Post Method
/**
 *  Post URL-Form-Encoded data as parameter
 */
- (NSURLRequest *)POST:(NSString *)urlString
            parameters:(NSDictionary *)parameters
               success:(MNSCompletionBlock)success
               failure:(MNSFailureBlock)failure {
    
    if (!urlString) {
        if (failure) {
            failure(Error_Argument,nil);
        }
        return nil;
    }
    
    //修改HRS
    MOLHttpRequestSerializer *httpRequestSerializer = [MOLHttpRequestSerializer serializer];
    _sessoinManager.requestSerializer = httpRequestSerializer;
    _sessoinManager.requestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    
    WS(weakSelf)
    
    NSURLSessionTask *aTask = [_sessoinManager POST:urlString parameters:parameters
                                          progress:nil
                                           success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                               NSLog(@"response %@",responseObject);

                                               ResponseInfo *resInfo = [[ResponseInfo alloc] initWithSessionTask:task];
                                               
                                               success(responseObject,resInfo);
                                               SS(strongSelf, weakSelf)
                                               if (strongSelf && task) {
                                                   [strongSelf removeTask:resInfo];
                                               }
                                           } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                               
                                               ResponseInfo *resInfo = [[ResponseInfo alloc] initWithSessionTask:task];
                                               
                                               NSString* errResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
                                               DDLogVerbose(@"========= error message!===== in %s",__FUNCTION__);
                                               NSLog(@"kkkkk%@",errResponse);

                                               if (failure && error) {
                                                   if (error.code == NSURLErrorCancelled) {
                                                       return ;
                                                   }
                                                   if ([error.userInfo objectForKey:NSLocalizedDescriptionKey]) {
                                                       failure([error.userInfo objectForKey:NSLocalizedDescriptionKey],resInfo);
                                                   } else if([error.userInfo objectForKey:FailDebugInfoKey]){
                                                       failure([error.userInfo objectForKey:FailDebugInfoKey],resInfo);
                                                   }
                                               }
                                               SS(strongSelf, weakSelf)
                                               if (strongSelf && task) {
                                                   [strongSelf removeTask:resInfo];
                                               }
                                           }];
    [self authChanllengeWithSessionMananger:_sessoinManager];
    return aTask.originalRequest;
}

/**
 *  Post JSON as parameter
 */
- (NSURLRequest *)POST:(NSString *)urlString
                  JSON:(id)parameters
               success:(MNSCompletionBlock)success
               failure:(MNSFailureBlock)failure {
    
    if (!urlString) {
        if (failure) {
            failure(Error_Argument,nil);
        }
        return nil;
    }

    //修改se
    MOLJSONRequestSerializer *jsonSerializer = [MOLJSONRequestSerializer serializer];
    _sessoinManager.requestSerializer = jsonSerializer;
    WS(weakSelf)
    NSURLSessionDataTask *aTask = [_sessoinManager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        ResponseInfo *resInfo = [[ResponseInfo alloc] initWithSessionTask:task];
        
        success(responseObject,resInfo);
        
        SS(strongSelf, weakSelf)
        if (strongSelf&&task) {
            [strongSelf removeTask:resInfo];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ResponseInfo *resInfo = [[ResponseInfo alloc] initWithSessionTask:task];
        if (failure && error) {
            if (error.code == NSURLErrorCancelled) {
                return ;
            }
            if ([error.userInfo objectForKey:NSLocalizedDescriptionKey]) {
                failure([error.userInfo objectForKey:NSLocalizedDescriptionKey],resInfo);
            } else if([error.userInfo objectForKey:FailDebugInfoKey]){
                failure([error.userInfo objectForKey:FailDebugInfoKey],resInfo);
            }
        }
        
        SS(strongSelf, weakSelf)
        if (strongSelf&&task) {
            [strongSelf removeTask:resInfo];
        }
    }];
    
    ResponseInfo *resInfo = [[ResponseInfo alloc] initWithSessionTask:aTask];
    [self addTask:resInfo];
    [self authChanllengeWithSessionMananger:_sessoinManager];
    return aTask.originalRequest;
}

// POST param and file with http stream
- (NSURLRequest *)POST:(NSString *)urlString
            parameters:(nullable id)parameters
              progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
constructingBodyWithBlock:(nullable void (^)(id<AFMultipartFormData> _Nonnull))block
               success:(MNSCompletionBlock)success
               failure:(MNSFailureBlock)failure {

    if (!urlString) {
        if (failure) {
            failure(Error_Argument,nil);
        }
        return nil;
    }
    
    //修改se
    MOLJSONRequestSerializer *jsonSerializer = [MOLJSONRequestSerializer serializer];
    _sessoinManager.requestSerializer = jsonSerializer;
    
    WS(weakSelf)
    NSURLSessionDataTask *aTask = [_sessoinManager POST:urlString parameters:parameters constructingBodyWithBlock:block progress:uploadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        ResponseInfo *resInfo = [[ResponseInfo alloc] initWithSessionTask:task];
        
        success(responseObject,resInfo);
        
        SS(strongSelf, weakSelf)
        if (strongSelf&&task) {
            [strongSelf removeTask:resInfo];
        }
            
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ResponseInfo *resInfo = [[ResponseInfo alloc] initWithSessionTask:task];
        if (failure && error) {
            if (error.code == NSURLErrorCancelled) {
                return ;
            }
            if ([error.userInfo objectForKey:NSLocalizedDescriptionKey]) {
                failure([error.userInfo objectForKey:NSLocalizedDescriptionKey],resInfo);
            } else if([error.userInfo objectForKey:FailDebugInfoKey]){
                failure([error.userInfo objectForKey:FailDebugInfoKey],resInfo);
            }
        }
        
        SS(strongSelf, weakSelf)
        if (strongSelf&&task) {
            [strongSelf removeTask:resInfo];
        }
    }];
    
    ResponseInfo *resInfo = [[ResponseInfo alloc] initWithSessionTask:aTask];
    [self addTask:resInfo];
    
    [self authChanllengeWithSessionMananger:_sessoinManager];
    return aTask.originalRequest;
}


/**
 *  Cancel requests
 */
- (void)cancelRequests {
    
    for (id<ResponseInfoProtocol> responseInfo in _currentWorkingTasks) {
        DDLogVerbose(@"***Debug*** Cancel URL : %@",responseInfo.request);
        [responseInfo cancel];
    }
    [_currentWorkingTasks removeAllObjects];
}

/**
 *   Cancel Specific ResponseInfo
 */
- (void)cancelRequestWithResponseInfo:(id<ResponseInfoProtocol>)responseInfo
{
    [responseInfo cancel];
    [_currentWorkingTasks removeObject:responseInfo];
}

/**
 删除给定responseInfo下的cache
 */
- (void)removeCachedResponseWithResponseInfo:(id<ResponseInfoProtocol>)responseInfo{
    [self removeCachedResponseForRequest:[responseInfo request]];
}

/**
 *  给定Request删除Response
 */
- (void)removeCachedResponseForRequest:(NSURLRequest *)request {
    [[MOLCustomURLCache shareMeileleURLCache] removeCachedResponseForRequest:request];
}

/**
 添加任务
 @param task 需要被添加的任务
 */
- (void)addTask:(id<ResponseInfoProtocol>)responseInfo {
    dispatch_async(dispatch_get_main_queue(), ^{
        [_currentWorkingTasks addObject:responseInfo];
    });
}

/**
 删除任务
 @param task 需要被删除的任务
 */
- (void)removeTask:(id<ResponseInfoProtocol>)responseInfo {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [_currentWorkingTasks removeObject:responseInfo];
    });
}


@end
