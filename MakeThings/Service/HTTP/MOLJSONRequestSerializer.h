//
//  MOLHttpRequestSerializer.h
//  MLLNetWorkService
//
//  Created by chester on 7/31/14.
//  Copyright © 2015 mac. All rights reserved.d.
//
#import "AFURLRequestSerialization.h"

/**
 *  Request Serializer for meilele
 */
@interface MOLHttpRequestSerializer : AFHTTPRequestSerializer

//@property (nonatomic) NSURLRequestCachePolicy cachePolicy;

@end

@interface MOLJSONRequestSerializer : AFJSONRequestSerializer

@end
