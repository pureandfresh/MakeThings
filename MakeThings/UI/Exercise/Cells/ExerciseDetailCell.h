//
//  ExerciseDetailCell.h
//  MakeThings
//
//  Created by Jing Ye on 08/01/2018.
//  Copyright © 2018 aiwen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ExerciseDetailModel;

@interface ExerciseDetailCell : UITableViewCell

- (void)updateExerciseDetailCellWithModel:(ExerciseDetailModel *)model;
@end
