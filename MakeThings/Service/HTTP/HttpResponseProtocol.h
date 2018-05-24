//
//  HttpResponseProtocol.h
//  MLLCustomer
//
//  Created by chester on 2016/9/23.
//  Copyright © 2016年 mac. All rights reserved.
//

/**
 服务器返回数据信息协议
 */
@protocol ResponseInfoProtocol <NSObject>

@required
- (NSURLRequest *)request;
- (NSDictionary *)responseHeader;
- (void)cancel;

@optional
- (NSHTTPURLResponse *)response;

@end
