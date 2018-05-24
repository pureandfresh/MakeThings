//
//  UserPortraitCell.m
//  MakeThings
//
//  Created by Jing Ye on 10/05/2018.
//  Copyright © 2018 aiwen. All rights reserved.
//

#import "UserPortraitCell.h"

@interface UserPortraitCell()
@property (weak, nonatomic) IBOutlet UIImageView *portraitImageView;
@property (weak, nonatomic) IBOutlet UILabel *FoucusNumberLabel;

@property (weak, nonatomic) IBOutlet UILabel *fansNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@end


@implementation UserPortraitCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.portraitImageView.layer.cornerRadius = self.portraitImageView.frame.size.height/2;
    self.portraitImageView.layer.masksToBounds = YES;

}

- (void)updateUserPortraitCellWithModel:(UserDetailModel *)model{
    _FoucusNumberLabel.text = model.focusNumber.length ? model.focusNumber :@"";
    _fansNumberLabel.text = model.fansNumber.length ? model.fansNumber :@"";
    _nickNameLabel.text = model.nickName.length ? model.nickName :@"";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
