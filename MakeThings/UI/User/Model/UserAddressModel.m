//
//  UserAddressModel.m
//  MakeThings
//
//  Created by Jing Ye on 28/05/2018.
//  Copyright © 2018 aiwen. All rights reserved.
//

#import "UserAddressModel.h"
#import "NSDate+DateTools.h"

@implementation UserAddressModel
- (instancetype)initUserAddressModelWithDictionary:(NSDictionary *)dictionary{
    if (!dictionary || ![dictionary isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    self = [super init];
    if (self) {
        self.region = dictionary[@"region"];
        self.detailAddress = dictionary[@"detailedAddress"];
        self.addressID = dictionary[@"id"];
        self.contactName = dictionary[@"contacts"];
        self.isDefaultAddress = dictionary[@"isDefault"];
        self.contactPhone = dictionary[@"phone"];
        
    }
    return self;
}

@end
