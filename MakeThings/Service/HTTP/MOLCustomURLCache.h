//
//  MOLCustomURLCache.h
//  MeileleMallHD
//
//  Created by chester on 8/4/14.
//  Copyright © 2015 mac. All rights reserved.d.
//

#import <Foundation/Foundation.h>

#define CustomURLCacheExpirationInterval 216000               //缓存持续时间，秒为单位
#define MemoryCapacity                   10                   //缓存 用于内存的容量限制，M为单位
#define DiskCapacity                     2000                 //缓存 用于磁盘的容量限制，M为单位
#define kExpirationInterval              @"ExpirationInterval"//cookie和userinfo中的KEY
@interface MOLCustomURLCache : NSURLCache
+ (void)useCustomURLCache;

+ (instancetype)shareMeileleURLCache;

/**
 *  是否命中缓存
 *
 *  @param request
 *
 *  @return 
 */
- (BOOL)isHit:(NSURLRequest *)request;

/**
 *  设置cookie里的cache有效时间
 *
 *  @param request            请求
 *  @param expirationInterval 超时时间（秒）
 */
+ (void)setExpirationInterval:(NSMutableURLRequest *)request interval:(NSTimeInterval)expirationInterval;
@end
