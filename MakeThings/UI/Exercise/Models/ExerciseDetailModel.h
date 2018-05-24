//
//  ExerciseDetailModel.h
//  MakeThings
//
//  Created by Jing Ye on 08/01/2018.
//  Copyright © 2018 aiwen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExerciseDetailModel : NSObject
@property (nonatomic,copy) NSString *userName;
@property (nonatomic,copy) NSString *imageUrl;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *commentAmount;
@property (nonatomic,copy) NSString *readAmount;

- (instancetype)initExerciseDetailModelWithDictionary:(NSDictionary *)dictionary;
@end
