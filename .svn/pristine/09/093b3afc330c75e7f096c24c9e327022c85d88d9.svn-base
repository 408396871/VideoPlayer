
//
//  DownloadCenter.m
//  Video
//
//  Created by dongjiang on 15/7/15.
//  Copyright (c) 2015年 jdong. All rights reserved.
//

#import "DownloadCenter.h"
#import "MJFileDownloader.h"
#import "UIStringDrawing+Extension.h"
#define MJURL(path) [@"http://localhost:8080/job/job1/ws" stringByAppendingPathComponent:path]

#import "AFNetworkReachabilityManager.h"

@interface DownloadCenter()<UIAlertViewDelegate>

@end
@implementation DownloadCenter
static DownloadCenter *instance = nil;

//单例
+(instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance = [[DownloadCenter alloc] init];
        instance.fileDownloaderDictionary = [NSMutableDictionary dictionary];
        [instance openNetworkStatusMonitor];
    });
    
    return instance;
}

+ (MJFileDownloader *)MJFileDownloaderWithID:(NSString *)CourseID;
{
    DownloadCenter *downloadCenter = [DownloadCenter shareInstance];
    if (IsStringEmpty(CourseID)) {
        return nil;
    }
    return downloadCenter.fileDownloaderDictionary[CourseID];
}

+ (MJFileDownloader *)MJFileDownloaderWithCourse:(Course *)course;
{
    DownloadCenter *downloadCenter = [DownloadCenter shareInstance];
    if (IsStringEmpty(course.ID)) {
        return nil;
    }
    
    if (downloadCenter.fileDownloaderDictionary[course.ID] != nil) {
        return downloadCenter.fileDownloaderDictionary[course.ID];
    }
    return [DownloadCenter MJFileDownloadWith:course];
}

//+ (MJFileDownloader *)MJFileDownloadWithURL:(NSString *)url CourseID:(NSString *)CourseID
//{
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
//    NSString *cachesDir = [paths objectAtIndex:0];
//    
//    NSString *path = [cachesDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.zip",CourseID]];
//    MJFileDownloader *fileDownloader = [[MJFileDownloader alloc] initWithURL:MJURL(@"video1.zip") destPath: path];
//    
//    DownloadCenter *shareInstance = [DownloadCenter shareInstance];
//    shareInstance.fileDownloaderDictionary[CourseID] = fileDownloader;
//
//    return fileDownloader;
//}

+ (MJFileDownloader *)MJFileDownloadWith:(Course *)course
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesDir = [paths objectAtIndex:0];
    
    NSString *path = [cachesDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp4",course.ID]];
    MJFileDownloader *fileDownloader = [[MJFileDownloader alloc] initWithURL:course.CourseURL destPath: path course:course];
    
    
    DownloadCenter *shareInstance = [DownloadCenter shareInstance];
    shareInstance.fileDownloaderDictionary[course.ID] = fileDownloader;
    
    return fileDownloader;
    
    
    
}

-(void)openNetworkStatusMonitor
{
    
    AFNetworkReachabilityManager *afNetworkReachabilityManager = [AFNetworkReachabilityManager sharedManager];
    [afNetworkReachabilityManager startMonitoring];  //开启网络监视器
    
    [afNetworkReachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:{
                //DDLogInfo(@"网络不通");
                self.networkStatus = NW_WithoutNetwork;
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"网络变化" message:@"当前不是wifi环境，确定继续播放" delegate: self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                alert.tag = 1;
                [alert show];
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWiFi:{
                //DDLogInfo(@"网络通过WIFI连接");
                self.networkStatus = NW_WifiNetwork;
                break;
            }
                
            case AFNetworkReachabilityStatusReachableViaWWAN:{
                
                //DDLogInfo(@"网络通过流量连接");
                self.networkStatus = NW_Network;
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"网络变化" message:@"当前不是wifi环境，确定继续下载" delegate: self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                alert.tag = 1;
                [alert show];
                break;
            }
            default:
                break;
        }
        
        
    }];
}



#pragma mark --UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 2) {
        switch (buttonIndex) {
            case 0:
                //            NSLog(@"Cancel Button Pressed");
                break;
            case 1:
                //停止所有下载
                [self stop];
                break;
            default:
                break;
        }
    }
}

- (void)stop
{
    for (MJFileDownloader *mj in self.fileDownloaderDictionary) {
        [mj pause];
    }
}


+ (void)removeFileDownloaderWithCourse:(Course *)course
{
    DownloadCenter *shareInstance = [DownloadCenter shareInstance];
    [shareInstance.fileDownloaderDictionary removeObjectForKey:course.ID];
}
@end
