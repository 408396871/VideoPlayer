//
//  CourseAPI.m
//  jysd-iOS
//
//  Created by humin on 15/7/12.
//  Copyright (c) 2015年 jysd. All rights reserved.
//

#import "CourseAPI.h"

#define kUrlCourseList @"/course/list"

@implementation CourseAPI

- (void)findCourseListWithCompletion:(RequestCompletionBlock)completion
{
    NSString *url = [kJysdHost stringByAppendingString:kUrlCourseList];
    [self requestJSONWithUrl:url param:@{@"access_token":@"89df1d6dbcdf13dc748de13f9a182ea8abb67630"} method:AFRequestMethodGET completion:completion];
}

- (void)getCourseViewWithUrl:(NSString *)url completion:(RequestCompletionBlock)completion
{
    [self requestJSONWithUrl:url param:@{@"access_token":@"89df1d6dbcdf13dc748de13f9a182ea8abb67630"} method:AFRequestMethodGET completion:completion];
}

@end
