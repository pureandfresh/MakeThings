//
//  UserDetailModel.m
//  MakeThings
//
//  Created by Jing Ye on 10/05/2018.
//  Copyright © 2018 aiwen. All rights reserved.
//

#import "UserDetailModel.h"

@implementation UserDetailModel


- (instancetype)initUserDetailModelWithDictionary:(NSDictionary *)dictionary{
    if (!dictionary || ![dictionary isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    self = [super init];
    self.fansNumber = dictionary[@"fansNumber"];
    self.dynamicNumber = dictionary[@"dynamicNumber"];
    self.focusNumber = dictionary[@"attentionNumber"];
    
    return self;
}

- (void)updateUserDetailModelWithDictionary:(NSDictionary *)dictionary{
    if (!dictionary || ![dictionary isKindOfClass:[NSDictionary class]]) {
        return ;
    }
    self.fansNumber = [NSString stringWithFormat:@"%@",dictionary[@"fansNumber"]];
    self.dynamicNumber = [NSString stringWithFormat:@"%@",dictionary[@"dynamicNumber"]];
    self.focusNumber = [NSString stringWithFormat:@"%@",dictionary[@"attentionNumber"]];
    

}


@end


@implementation UserItemModel
- (instancetype)initUserItemModelWithTitle:(NSString *)title{
    if (!title) {
        return nil;
    }
    self = [super init];
    if (self){
        self.ItemTitle = title;
    }
    return self;
}

@end
