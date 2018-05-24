//
//  UserDetailModel.h
//  MakeThings
//
//  Created by Jing Ye on 10/05/2018.
//  Copyright © 2018 aiwen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDetailModel : NSObject
@property (nonatomic,copy) NSString *nickName;
@property (nonatomic,copy) NSString *focusNumber;
@property (nonatomic,copy) NSString *fansNumber;
@property (nonatomic,copy) NSString *dynamicNumber;
@property (nonatomic) NSArray *itemModelArray;

- (instancetype)initUserDetailModelWithDictionary:(NSDictionary *)dictionary;
- (void)updateUserDetailModelWithDictionary:(NSDictionary *)dictionary;
@end

@interface UserItemModel : NSObject
@property (nonatomic,copy) NSString *ItemTitle;

- (instancetype)initUserItemModelWithTitle:(NSString *)title;
@end
