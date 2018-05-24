//
//  MTUrlRequestHander.h
//  One2payMerchant
//
//  Created by Jing Ye on 26/01/2018.
//  Copyright © 2018 mol. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, NetworkEnvironmentType) {
    NetworkEnvironmentType_Test  = 0,
    NetworkEnvironmentType_Production
};
/* default Network environment,if want to switch,set here */
#define DefaultNetworkEnvironmentType NetworkEnvironmentType_Test

@interface MTUrlRequestHander : NSObject

+ (NSString *)urlStringWithBussniessName:(NSString *)bussinessName;

@end
