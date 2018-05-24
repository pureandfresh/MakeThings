//
//  UserInfoPortraitCell.m
//  MakeThings
//
//  Created by Jing Ye on 21/05/2018.
//  Copyright © 2018 aiwen. All rights reserved.
//

#import "UserInfoPortraitCell.h"

@implementation UserInfoPortraitCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.portraitImageview.layer.cornerRadius = self.portraitImageview.frame.size.height/2;
    self.portraitImageview.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
