//
//  Course.m
//  Video
//
//  Created by LYL on 15/7/14.
//  Copyright (c) 2015年 jdong. All rights reserved.
//

#import "Course.h"

@implementation Course
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.ID = dict[@"id"];
        self.parentId = dict[@"parentId"];
        self.CourseURL = dict[@"url"];
        self.icon = dict[@"icon"];
        self.name = dict[@"name"];
        self.desc = dict[@"desc"];
        self.duration = dict[@"duration"];
    }
    return self;
}

+ (instancetype)courseWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

/**
 *  从文件中解析对象的时候调
 */
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.ID = [decoder decodeObjectForKey:@"id"];
        self.parentId = [decoder decodeObjectForKey:@"parentId"];
        self.CourseURL = [decoder decodeObjectForKey:@"CourseURL"];
        self.icon = [decoder decodeObjectForKey:@"icon"];
        self.name = [decoder decodeObjectForKey:@"name"];
        self.desc = [decoder decodeObjectForKey:@"desc"];
        self.duration = [decoder decodeObjectForKey:@"duration"];
        self.isDownload = [decoder decodeObjectForKey:@"isDownload"];
        self.progress = [decoder decodeObjectForKey:@"progress"];
        self.currentLength = [decoder decodeObjectForKey:@"currentLength"];
    }
    return self;
}

/**
 *  将对象写入文件的时候调用
 */
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.ID forKey:@"id"];
    [encoder encodeObject:self.parentId forKey:@"parentId"];
    [encoder encodeObject:self.CourseURL forKey:@"CourseURL"];
    [encoder encodeObject:self.icon forKey:@"icon"];
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.desc forKey:@"desc"];
    [encoder encodeObject:self.duration forKey:@"duration"];
    [encoder encodeObject:self.isDownload forKey:@"isDownload"];
    [encoder encodeObject:self.progress forKey:@"progress"];
    [encoder encodeObject:self.currentLength forKey:@"currentLength"];
}


+ (void)saveCourseData:(Course *)Course
{
    
    // .存储模型数据
    [NSKeyedArchiver archiveRootObject:Course toFile:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:Course.ID]];
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] arrayForKey:@"CourseIDList"]];
    if (array == nil) {
        array = [NSMutableArray array];
    }
    
    [array addObject:Course.ID];
    
    NSMutableSet *set = [NSMutableSet setWithArray:array];
    
    
    [[NSUserDefaults standardUserDefaults]setObject:[set allObjects] forKey:@"CourseIDList"];

}
+ (Course *)CourseWithID:(NSString *)CourseID
{
    // 取出存储的数据
    Course *account = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:CourseID]];
    
    return account;
    
}

+ (BOOL)removeCourseWithID:(NSString *)CourseID
{
    NSMutableArray *array = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] arrayForKey:@"CourseIDList"]];
    [array removeObject:CourseID];
    [[NSUserDefaults standardUserDefaults]setObject:array forKey:@"CourseIDList"];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesDir = [paths objectAtIndex:0];
    NSString *path = [NSString stringWithFormat:@"%@/%@.mp4",cachesDir,CourseID];
    
    NSFileManager *mgr = [[NSFileManager alloc] init];
    
    [mgr removeItemAtPath:path error:nil];
    
   return [NSKeyedArchiver archiveRootObject:nil toFile:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:CourseID]];
}


+ (void)removeAllCourse
{
    NSMutableArray *array = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] arrayForKey:@"CourseIDList"]];
    
    for (NSString *CourseID in array) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *cachesDir = [paths objectAtIndex:0];
        NSString *path = [NSString stringWithFormat:@"%@/%@.mp4",cachesDir,CourseID];
        
        NSFileManager *mgr = [[NSFileManager alloc] init];
        
        [mgr removeItemAtPath:path error:nil];
    }
}

@end
