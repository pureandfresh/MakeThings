//
//  UserInfoAddressCell.m
//  MakeThings
//
//  Created by Jing Ye on 24/05/2018.
//  Copyright © 2018 aiwen. All rights reserved.
//

#import "UserInfoAddressCell.h"
#import "UserAddressModel.h"

@implementation UserInfoAddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)updateUserInfoAddressCellWithModel:(UserAddressModel *)model{
    self.nameLabel.text = model.contactName;
    self.addressLabel.text = [NSString stringWithFormat:@"%@%@",model.region,model.detailAddress];
}
- (IBAction)editButtonClicked:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(userInfoAddressCellDidClickedEditButton:)]) {
        [self.delegate userInfoAddressCellDidClickedEditButton:self];
    }
}

@end
