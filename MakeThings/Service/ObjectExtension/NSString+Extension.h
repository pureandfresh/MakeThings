//
//  NSString+Extension.h
//  MolPoints_test
//
//  Created by Jing Ye on 21/6/2017.
//  Copyright © 2017 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)



/*  得到字符串的md5值   */
- (NSString *)md5String;

/*  得到客户端当前的时间：yyyy-MM-ddTHH:mm:ssZ   */
+ (NSString *)getClientNowTime;

/*   获取设备的物理地址   */
+ (NSString *)getMacAddress;

+(NSString*)deviceString;
@end

