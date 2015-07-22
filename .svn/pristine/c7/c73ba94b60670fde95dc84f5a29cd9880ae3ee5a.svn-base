//
//  DemoUseApi.m
//  jysd-iOS
//
//  Created by humin on 15/7/12.
//  Copyright (c) 2015年 jysd. All rights reserved.
//

#import "DemoUseApi.h"
#import "CourseAPI.h"

@implementation DemoUseApi

- (void)userCourseListApiWithCompletion:(RequestCompletionBlock)completion
{
    CourseAPI *api = [[CourseAPI alloc] init];
    [api findCourseListWithCompletion:^(BOOL success, NSDictionary *object){
        if (success) {
            NSArray *courses = object[@"course_list"];
            NSLog(@"course: %@", courses);
            // ui actions
        } else {
            // 提示网络异常
        }
    }];
}

- (void)userCourseViewApiWithUrl:(NSString *)url completion:(RequestCompletionBlock)completion
{
    CourseAPI *api = [[CourseAPI alloc] init];
    [api getCourseViewWithUrl:url completion:^(BOOL success, NSArray *object){
        if (success) {
            NSLog(@"course data: %@", object);
            // ui actions
        } else {
            // 提示网络异常
        }
    }];
}

@end
