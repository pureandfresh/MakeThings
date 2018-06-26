//
//  UserInfoAddressCell.h
//  MakeThings
//
//  Created by Jing Ye on 24/05/2018.
//  Copyright © 2018 aiwen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UserAddressModel;
@class UserInfoAddressCell;
@protocol UserInfoAddressCellDelegate<NSObject>

-(void)userInfoAddressCellDidClickedEditButton:(UserInfoAddressCell *)cell;

@end


@interface UserInfoAddressCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIButton *editButton;

@property (weak,nonatomic) id<UserInfoAddressCellDelegate> delegate;

- (void)updateUserInfoAddressCellWithModel:(UserAddressModel *)model;
@end
