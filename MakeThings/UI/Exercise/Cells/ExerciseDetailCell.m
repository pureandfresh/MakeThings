//
//  ExerciseDetailCell.m
//  MakeThings
//
//  Created by Jing Ye on 08/01/2018.
//  Copyright © 2018 aiwen. All rights reserved.
///Users/jingye/Desktop/MakeThings/MakeThings/UI/Exercise

#import "ExerciseDetailCell.h"
#import "ExerciseDetailModel.h"
#import "UIImageView+WebCache.h"

@interface ExerciseDetailCell()
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

@end
@implementation ExerciseDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)updateExerciseDetailCellWithModel:(ExerciseDetailModel *)model{
    
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:[UIImage imageNamed:@"placeholder_image"]];
    self.titleLabel.text = model.title;
    self.userNameLabel.text = model.userName;
    self.commentLabel.text = [NSString stringWithFormat:@"%@评论/%@阅读",model.commentAmount,model.readAmount];
    
}


@end
