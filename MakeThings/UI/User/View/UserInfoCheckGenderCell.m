//
//  UserInfoCheckGenderCell.m
//  MakeThings
//
//  Created by Jing Ye on 23/05/2018.
//  Copyright © 2018 aiwen. All rights reserved.
//

#import "UserInfoCheckGenderCell.h"

@implementation UserInfoCheckGenderCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)updateCellWithModel:(UserInfoGenderModel *)model{
    self.genderLabel.text = model.genderString;
    self.checkImageView.hidden = !model.isSelected;
}


@end

@implementation UserInfoGenderModel

- (instancetype)initUserInfoGenderModelWithGenderString:(NSString *)genderString{
    self = [super init];
    if (self) {
        self.genderString = genderString;
        self.isSelected = NO;
    }
    return self;
}


@end

