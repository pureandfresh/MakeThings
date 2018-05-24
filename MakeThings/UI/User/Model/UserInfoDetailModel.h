//
//  UserInfoDetailModel.h
//  MakeThings
//
//  Created by Jing Ye on 21/05/2018.
//  Copyright © 2018 aiwen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoDetailModel : NSObject
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *content;
@property (nonatomic,assign) BOOL isHidenArrow;
@property (nonatomic,assign) UserInfoRowType type;

- (instancetype)initUserInfoDetailModelWithTitle:(NSString *)title
                                         content:(NSString *)content
                                            type:(UserInfoRowType)type;
@end
