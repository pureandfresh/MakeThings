//
//  MTUrlRequestHander.m
//  One2payMerchant
//
//  Created by Jing Ye on 26/01/2018.
//  Copyright © 2018 mol. All rights reserved.
//

#import "MTUrlRequestHander.h"



#define kBaseUrlDefineFileName @"MTRequestBaseUrl.plist"
#define kAccountUrlDefineFileName @"UserMoudleUrlPath.plist"

#define kBaseUrlKeyTest @"test_environment"

#define kVersionStringKey @"version_string"

static NSMutableDictionary *appURLConfigureData = nil;
static NSMutableDictionary *baseURLConfigureData = nil;

static NSArray *networkEnvironmentStringValues = nil;

@implementation MTUrlRequestHander

+(void)initialize{
    if (!networkEnvironmentStringValues) {
        networkEnvironmentStringValues = @[@"test",@"production"];
    }
    if (!baseURLConfigureData) {
        NSString *baseUrlDefinePlistPath = [[NSBundle mainBundle] pathForResource:kBaseUrlDefineFileName ofType:nil];
        baseURLConfigureData = [[NSMutableDictionary alloc] initWithContentsOfFile:baseUrlDefinePlistPath];
        
    }
 
    if (!appURLConfigureData) {
        NSString *accountUrlDefinePlistPath = [[NSBundle mainBundle] pathForResource:kAccountUrlDefineFileName ofType:nil];
        appURLConfigureData = [[NSMutableDictionary alloc] initWithContentsOfFile:accountUrlDefinePlistPath];
        
    }
}

+ (NSString *)urlStringWithBussniessName:(NSString *)bussinessName{
    return [MTUrlRequestHander urlStringWithBussniessName:bussinessName andEnvironmentType:DefaultNetworkEnvironmentType];
}

+ (NSString *)urlStringWithBussniessName:(NSString *)bussinessName andEnvironmentType:(NetworkEnvironmentType)environmentType{
    NSString *baseUrlKey;
    if (environmentType == NetworkEnvironmentType_Test) {
        baseUrlKey = kBaseUrlKeyTest;
    }else{

    }
    NSString *baseUrlString = [NSString stringWithFormat:@"%@%@",baseURLConfigureData[baseUrlKey],baseURLConfigureData[kVersionStringKey]];
    NSString *businessPath = appURLConfigureData[bussinessName];
    return [NSString stringWithFormat:@"%@%@",baseUrlString,businessPath];
}

@end
