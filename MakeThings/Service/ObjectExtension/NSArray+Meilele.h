//
//  NSArray+Meilele.h
//  MeileleMallHD
//
//  Created by cailu on 14-9-4.
//  Copyright (c) 2014年 Meilele iOS Dev Team. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Meilele)

+ (BOOL)isValid:(id)obj;

+ (BOOL)isNotValid:(id)obj;

+ (BOOL)isEmpty:(id)obj;

+ (BOOL)isNotEmpty:(id)obj;

- (NSString *)join:(NSString *)delimiter;
@end
