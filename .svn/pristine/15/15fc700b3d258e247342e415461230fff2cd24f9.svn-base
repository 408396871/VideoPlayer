//
//  DownloadCenter.h
//  Video
//
//  Created by dongjiang on 15/7/15.
//  Copyright (c) 2015年 jdong. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, NetworkStatus) {
    NW_UnknowNetwork = -1,//不知名网络
    NW_WithoutNetwork = 0,//没有网络
    NW_WifiNetwork = 1,   //WIFI网络
    NW_Network = 2, //数据流量网络
};


@class MJFileDownloader,Course;
@interface DownloadCenter : NSObject

@property(nonatomic,strong)NSMutableDictionary *fileDownloaderDictionary;
@property(nonatomic, assign) NetworkStatus networkStatus;

+ (instancetype)shareInstance;
+ (MJFileDownloader *)MJFileDownloaderWithID:(NSString *)CourseID;
//+ (MJFileDownloader *)MJFileDownloadWithURL:(NSString *)url CourseID:(NSString *)CourseID;
+ (MJFileDownloader *)MJFileDownloadWith:(Course *)course;
+ (MJFileDownloader *)MJFileDownloaderWithCourse:(Course *)course;
+ (void)removeFileDownloaderWithCourse:(Course *)course;
@end
