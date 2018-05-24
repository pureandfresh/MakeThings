//
//  UserInfoCheckGenderCell.h
//  MakeThings
//
//  Created by Jing Ye on 23/05/2018.
//  Copyright © 2018 aiwen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UserInfoGenderModel;
@interface UserInfoCheckGenderCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *genderLabel;
@property (weak, nonatomic) IBOutlet UIImageView *checkImageView;

- (void)updateCellWithModel:(UserInfoGenderModel *)model;

@end


@interface UserInfoGenderModel : NSObject
@property (nonatomic,copy) NSString *genderString;
@property (nonatomic,assign) BOOL isSelected;

- (instancetype)initUserInfoGenderModelWithGenderString:(NSString *)genderString;

@end
