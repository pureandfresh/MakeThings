//
//  UserInfoDetailModel.m
//  MakeThings
//
//  Created by Jing Ye on 21/05/2018.
//  Copyright © 2018 aiwen. All rights reserved.
//

#import "UserInfoDetailModel.h"

@implementation UserInfoDetailModel

- (instancetype)initUserInfoDetailModelWithTitle:(NSString *)title
                                         content:(NSString *)content
                                            type:(UserInfoRowType)type{
    
    self = [super init];
    self.title = title;
    self.content = content;
    self.isHidenArrow = NO;
    self.type = type;
    
    return self;
}

@end
