//
//  CourseAPI.h
//  jysd-iOS
//
//  Created by humin on 15/7/12.
//  Copyright (c) 2015年 jysd. All rights reserved.
//

#import "BaseAFAPI.h"

@interface CourseAPI : BaseAFAPI

/**
 * 获得课程项目列表
 */
- (void)findCourseListWithCompletion:(RequestCompletionBlock)completion;

/**
 * 获得课程项目下的视频列表
 */
- (void)getCourseViewWithUrl:(NSString *)url completion:(RequestCompletionBlock)completion;

@end
