//
//  VideoDownloadCell.h
//  Video
//
//  Created by jdong on 15-7-14.
//  Copyright (c) 2015年 jdong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Course;
@protocol VideoDownloadCellDelegate <NSObject>
- (void)didDownload:(Course *)course;
@optional

@end
@interface VideoDownloadCell : UITableViewCell
@property (nonatomic,strong) Course *course;


+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, weak) id<VideoDownloadCellDelegate> delegate;
@end
