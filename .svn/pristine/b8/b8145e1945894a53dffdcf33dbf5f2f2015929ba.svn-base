//
//  CourseListCell.m
//  Video
//
//  Created by LYL on 15/7/14.
//  Copyright (c) 2015年 jdong. All rights reserved.
//

#import "CourseListCell.h"

#import "UIImageView+WebCache.h"
#import "UIStringDrawing+Extension.h"

@interface CourseListCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;

@end

@implementation CourseListCell

- (void)awakeFromNib {
    // Initialization code
//    self.titleLabel.backgroundColor = [UIColor redColor];
//    self.desLabel.backgroundColor = [UIColor redColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCourse:(Courseslist *)course
{
    _course = course;
    
    if (!IsStringEmpty(course.icon)) {
        [self.iconView sd_setImageWithURL:[NSURL URLWithString:course.icon] placeholderImage:[UIImage imageNamed:@""]];
    }
    if (!IsStringEmpty(course.name)) {
        self.titleLabel.text = course.name;
    }
    if (!IsStringEmpty(course.duration)) {
        self.desLabel.text = course.duration;
    }
    
}



@end
