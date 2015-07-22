//
//  MJFileDownloader.h
//  预习-04-大文件下载
//
//  Created by MJ Lee on 14-6-27.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Course.h"
@interface MJFileDownloader : NSObject

- (instancetype)initWithURL:(NSString *)url destPath:(NSString *)destPath;

- (instancetype)initWithURL:(NSString *)url destPath:(NSString *)destPath course:(Course*)course;

@property (readonly, nonatomic, getter = isDownloading) BOOL downloading;
@property (copy, nonatomic) void (^progressHandler)(double progress);
//是否故障暂停
@property (copy, nonatomic) void (^progressHandler2)(BOOL isErrorPause);

//是否下载完
@property (copy, nonatomic) void (^progressHandler3)(BOOL isComplete);

- (void)start;
- (void)pause;
@end
