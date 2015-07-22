//
//  Course.h
//  Video
//
//  Created by LYL on 15/7/14.
//  Copyright (c) 2015年 jdong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Course : NSObject
/**
 *   ID
 */
@property (nonatomic, copy) NSString *ID;
/**
 *  parentId
 */
@property (nonatomic, copy) NSString *parentId;
/**
 *  课程地址.mp4
 */
@property (nonatomic, copy) NSString *CourseURL;
/**
 *  课程缩略图
 */
@property (nonatomic, copy) NSString *icon;
/**
 *  课程名称
 */
@property (nonatomic, copy) NSString *name;
/**
 *  课程描述
 */
@property (nonatomic, copy) NSString *desc;
/**
 *  课时
 */
@property (nonatomic, copy) NSString *duration;
/**
 *  1是已下载，0是正在下载,只存储触发过下载事件的模型,只用于从本地读数据时判断
 */
@property (nonatomic, copy) NSString *isDownload;
/**
 *  1为下载完成
 */
@property (nonatomic, copy) NSString *progress;
/**
 *  下载量
 */
@property (nonatomic, copy) NSString *currentLength;


- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)courseWithDict:(NSDictionary *)dict;

+ (Course *)CourseWithID:(NSString *)CourseID;
+ (void)saveCourseData:(Course *)Course;
+ (BOOL)removeCourseWithID:(NSString *)CourseID;
//删除本地所有视频
+ (void)removeAllCourse;
@end
