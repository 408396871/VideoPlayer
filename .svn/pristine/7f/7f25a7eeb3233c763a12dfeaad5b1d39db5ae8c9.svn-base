//
//  VideoCacheCell.m
//  Video
//
//  Created by jdong on 15-7-14.
//  Copyright (c) 2015年 jdong. All rights reserved.
//

#import "VideoCacheCell.h"
#import "Course.h"
#import "DownloadCenter.h"
#import "UIStringDrawing+Extension.h"
#import "UIImageView+WebCache.h"

@interface VideoCacheCell()
@property (weak, nonatomic) IBOutlet UIButton *deletBtn;
- (IBAction)click:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *titile;
@property (weak, nonatomic) IBOutlet UIImageView *icon;

@end
@implementation VideoCacheCell

- (void)awakeFromNib {
    // Initialization code
}

+ (instancetype)cellWithTableView:(UITableView *)tableView Course:(Course *)course
{
    static NSString *ID = @"VideoCacheCell";
    VideoCacheCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        // 从xib中加载cell
        cell = [[[NSBundle mainBundle] loadNibNamed:@"VideoCacheCell" owner:nil options:nil] lastObject];
    }
    
    cell.course = course;
    
    if (!IsStringEmpty(course.name)) {
        cell.titile.text = course.name;
    }
    if (!IsStringEmpty(course.icon)) {
        [cell.icon sd_setImageWithURL:[NSURL URLWithString:course.icon] placeholderImage:[UIImage imageNamed:@""]];
    }
    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)click:(id)sender {
    
    [Course removeCourseWithID:self.course.ID];
    
    [DownloadCenter removeFileDownloaderWithCourse:self.course];
    
    //调用代理方法，从tableview里移除
    if ([self.delegate respondsToSelector:@selector(deletBtn:)]) {
        [self.delegate deletBtn:self.course];
    }
}


@end
