//
//  Courseslist.m
//  Video
//
//  Created by LYL on 15/7/14.
//  Copyright (c) 2015年 jdong. All rights reserved.
//

#import "Courseslist.h"

@implementation Courseslist
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.ID = dict[@"id"];
        self.CoursesURL = dict[@"url"];
        self.icon = dict[@"icon"];
        self.name = dict[@"name"];
        self.desc = dict[@"desc"];
        self.duration = dict[@"duration"];
    }
    return self;
}

+ (instancetype)courseslistWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
@end
