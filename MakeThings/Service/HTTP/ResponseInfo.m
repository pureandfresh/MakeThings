//
//  ResponseInfo.m
//  MLLCustomer
//
//  Created by chester on 2016/9/23.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ResponseInfo.h"

@interface ResponseInfo ()
@property (nonatomic) NSURLSessionDataTask *task;
@end


@implementation ResponseInfo


- (instancetype)initWithSessionTask:(NSURLSessionDataTask *)task
{
    self = [super init];
    if (self) {
        self.task = task;
    }
    return self;
}

// ======= 协议 ======= //

- (NSURLRequest *)request{
    if (self.task) {
        return self.task.originalRequest;
    }
    
    return [NSURLRequest requestWithURL:[NSURL URLWithString:@""]];
}

- (NSDictionary *)responseHeader
{
    if (self.task) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)self.task.response;
        return response.allHeaderFields;
    }
    
    return [NSDictionary dictionaryWithObjectsAndKeys:@"", nil];
}

- (void)cancel {
    if (self.task) {
        [self.task cancel];
    }
}

- (NSHTTPURLResponse *)response{
    return [self.task response];
}


@end
