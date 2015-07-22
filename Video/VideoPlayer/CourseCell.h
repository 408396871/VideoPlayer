//
//  CourseCell.h
//  Video
//
//  Created by LYL on 15/7/14.
//  Copyright (c) 2015年 jdong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Course;

@protocol CourseCellDelegate <NSObject>

@optional
- (void)clickButton:(Course *)course;

@end

@interface CourseCell : UITableViewCell
@property (nonatomic,strong) Course *course;

@property (nonatomic, weak) id<CourseCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIImageView *playing;
@end
