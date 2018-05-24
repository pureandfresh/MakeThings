//
//  MTAplicationUser.h
//  MakeThings
//
//  Created by Jing Ye on 07/05/2018.
//  Copyright © 2018 aiwen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTAplicationUser : NSObject


/*   user info  */

@property (nonatomic,copy) NSString * _Nullable nickName;
@property (nonatomic,copy) NSString * _Nullable password;
@property (nonatomic,copy) NSString * _Nonnull phoneNumber;
@property (nonatomic,copy) NSString * _Nullable headPortrait;
@property (nonatomic,copy) NSString * _Nullable verificationCode;
@property (nonatomic,copy) NSString * _Nullable token;
@property (nonatomic,copy) NSString * _Nullable userID;
@property (nonatomic,copy) NSString * _Nullable sender;

+(instancetype _Nullable )sharedAplicationUser;

- (void)updateMTAplicationUserWithDictionary:(NSDictionary *_Nullable)dictionary;
- (MTAplicationUser *_Nullable)getLatestLoginUser;
- (void)saveLoginUserInfo:(MTAplicationUser *_Nullable)user;

@end
