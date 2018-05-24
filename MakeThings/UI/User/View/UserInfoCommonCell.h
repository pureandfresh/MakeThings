//
//  UserInfoCommonCell.h
//  MakeThings
//
//  Created by Jing Ye on 21/05/2018.
//  Copyright © 2018 aiwen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfoDetailModel.h"

@interface UserInfoCommonCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *arrowButton;

- (void)updateUserInfoCommonCellWithModel:(UserInfoDetailModel *)model;
@end
