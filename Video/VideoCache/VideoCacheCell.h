//
//  VideoCacheCell.h
//  Video
//
//  Created by jdong on 15-7-14.
//  Copyright (c) 2015年 jdong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Course;
@protocol VideoCacheCellDelegate <NSObject>
- (void)deletBtn:(Course *)course;
@optional

@end
@interface VideoCacheCell : UITableViewCell
@property (nonatomic,strong) Course *course;

+ (instancetype)cellWithTableView:(UITableView *)tableView Course:(Course *)course;
@property (nonatomic, weak) id<VideoCacheCellDelegate> delegate;
@end
