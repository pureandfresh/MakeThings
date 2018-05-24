//
//  UserInfoCommonCell.m
//  MakeThings
//
//  Created by Jing Ye on 21/05/2018.
//  Copyright © 2018 aiwen. All rights reserved.
//

#import "UserInfoCommonCell.h"

@implementation UserInfoCommonCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)updateUserInfoCommonCellWithModel:(UserInfoDetailModel *)model{
    self.categoryLabel.text = model.title;
    self.contentLabel.text = model.content;
    self.arrowButton.hidden = model.isHidenArrow;
}

@end
