//
//  UserPortraitCell.h
//  MakeThings
//
//  Created by Jing Ye on 10/05/2018.
//  Copyright © 2018 aiwen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserDetailModel.h"

@interface UserPortraitCell : UITableViewCell


- (void)updateUserPortraitCellWithModel:(UserDetailModel *)model;
@end
