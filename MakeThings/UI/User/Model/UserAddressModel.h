//
//  UserAddressModel.h
//  MakeThings
//
//  Created by Jing Ye on 28/05/2018.
//  Copyright © 2018 aiwen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserAddressModel : NSObject

@property (nonatomic,copy) NSString *region;
@property (nonatomic,copy) NSString *detailAddress;
@property (nonatomic,copy) NSString *contactName;
@property (nonatomic,copy) NSString *addressID;
@property (nonatomic,copy) NSString *contactPhone;
@property (nonatomic,copy) NSString *isDefaultAddress;
@property (nonatomic) NSDate *createTime;


- (instancetype)initUserAddressModelWithDictionary:(NSDictionary *)dictionary;
@end
