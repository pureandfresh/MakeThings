//
//  MOLHttpRequestSerializer.m
//  MLLNetWorkService
//
//  Created by chester on 7/31/14.
//  Copyright © 2015 mac. All rights reserved.d.
//

#import "MOLJSONRequestSerializer.h"
#import "NSString+Extension.h"
#import "MTAplicationUser.h"

@implementation MOLHttpRequestSerializer

- (id)init {
    self = [super init];
    
    if (self) {
        self.cachePolicy = NSURLRequestUseProtocolCachePolicy;
        
        [self setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

    }
    
    return self;
}

- (NSMutableURLRequest *)requestWithMethod:(NSString *)method URLString:(NSString *)URLString parameters:(NSDictionary *)parameters error:(NSError *__autoreleasing *)error {
    if (!URLString) {
        DDLogVerbose(@"=========MOL ERROR IN Build Request!===== in %s",__FUNCTION__);
        return nil;
    }
    NSError * error1;

    NSMutableURLRequest *req = [super requestWithMethod:method URLString:URLString parameters:parameters error:error];
    
    if (parameters) {
        req.HTTPBody = [NSJSONSerialization dataWithJSONObject:parameters
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error1];
    }
    

    MTAplicationUser *loginUser = [[MTAplicationUser sharedAplicationUser] getLatestLoginUser];
    [req setValue:loginUser.token forHTTPHeaderField:@"token"];

    [req setCachePolicy:self.cachePolicy];
    NSLog(@"allHTTPHeaderFields%@,url%@ %@",req.allHTTPHeaderFields,URLString,parameters);
    return req;
}

@end



@implementation MOLJSONRequestSerializer



@end

