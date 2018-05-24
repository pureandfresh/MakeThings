      //
//  MTAplicationUser.m
//  MakeThings
//
//  Created by Jing Ye on 07/05/2018.
//  Copyright © 2018 aiwen. All rights reserved.
//

#import "MTAplicationUser.h"

static NSString *const userInfoKey = @"loginUserInfoKey";
@implementation MTAplicationUser



+(instancetype)sharedAplicationUser {
    static dispatch_once_t onceToken;
    static MTAplicationUser *_sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[MTAplicationUser alloc]init];
        
    });
    return _sharedInstance;
    
}


- (void)updateMTAplicationUserWithDictionary:(NSDictionary *)dictionary{
    if (!dictionary) {
        return;
    }
    self.phoneNumber = dictionary[@"phone"];
    self.headPortrait = dictionary[@"headImg"];
    self.token = dictionary[@"token"];
    self.nickName = dictionary[@"name"];
    self.userID = dictionary[@"id"];
    
    
}

- (void)saveLoginUserInfo:(MTAplicationUser *)user{

    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:user];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:userInfoKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (MTAplicationUser *)getLatestLoginUser{
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:userInfoKey];
    if (!data) {
        return nil;
    }
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        self.nickName = [coder decodeObjectForKey:@"nickName"];
        self.password = [coder decodeObjectForKey:@"password"];
        self.phoneNumber = [coder decodeObjectForKey:@"phoneNumber"];
        self.headPortrait = [coder decodeObjectForKey:@"headPortrait"];
        self.verificationCode = [coder decodeObjectForKey:@"verificationCode"];
        self.token = [coder decodeObjectForKey:@"token"];
        self.userID = [coder decodeObjectForKey:@"userID"];
        self.sender = [coder decodeObjectForKey:@"sender"];

    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.nickName forKey:@"nickName"];
    [coder encodeObject:self.password forKey:@"password"];
    [coder encodeObject:self.phoneNumber forKey:@"phoneNumber"];
    [coder encodeObject:self.headPortrait forKey:@"headPortrait"];
    [coder encodeObject:self.verificationCode forKey:@"verificationCode"];
    [coder encodeObject:self.token forKey:@"token"];
    [coder encodeObject:self.userID forKey:@"userID"];
    [coder encodeObject:self.sender forKey:@"sender"];

}


@end
