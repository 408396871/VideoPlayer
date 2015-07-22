//
//  MJFileDownloader.m
//  预习-04-大文件下载
//
//  Created by MJ Lee on 14-6-27.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "MJFileDownloader.h"

@interface MJFileDownloader() <NSURLConnectionDataDelegate>
@property (assign, nonatomic) long long totalLength;
@property (assign, nonatomic) long long currentLength;
@property (strong, nonatomic) NSFileHandle *writeHandle;
@property (strong, nonatomic) NSURLConnection *conn;

@property (copy, nonatomic) NSString *url;
@property (copy, nonatomic) NSString *destPath;

@property (nonatomic,strong) Course *course;
@property (nonatomic,assign) BOOL isHaveCurrentLength;

@end

@implementation MJFileDownloader
{
    NSOperationQueue *queue;
    NSBlockOperation *operation;
}
- (instancetype)initWithURL:(NSString *)url destPath:(NSString *)destPath
{
    if (self = [super init]) {
        self.url = url;
        self.destPath = destPath;
    }
    return self;
}
- (instancetype)initWithURL:(NSString *)url destPath:(NSString *)destPath course:(Course*)course
{
    if (self = [super init]) {
        self.url = url;
        self.destPath = destPath;
        self.course = course;
    }
    
    queue = [[NSOperationQueue alloc] init];
    return self;
}


- (void)start
{
    
    // 创建请求
    NSURL *url = [NSURL URLWithString:self.url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
//    NSURLResponse *response = nil;
//#warning 这里要用异步请求
//    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];

    _downloading = YES;
    
    if (self.currentLength == 0) { // 刚开始下载
        
    } else if (self.currentLength < self.totalLength) { // 继续下载
        NSString *value = [NSString stringWithFormat:@"bytes=%zd-", self.currentLength];
        [request setValue:value forHTTPHeaderField:@"Range"];
    }
    
    // 发送请求
    self.conn = [NSURLConnection connectionWithRequest:request delegate:self];
    
    
    self.course.isDownload = @"0";
    [Course saveCourseData:self.course];
}

- (void)pause
{
    _downloading = NO;
    double progress = (double)self.currentLength / self.totalLength;
    self.course.isDownload = @"0";
    self.course.progress = [NSString stringWithFormat:@"%f",progress];
    [Course saveCourseData:self.course];
    
    [self.conn cancel];
    self.conn = nil;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    _downloading = NO;
    
    self.conn = nil;
    
    if (self.progressHandler2) {
        
        self.progressHandler2(YES);
        
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{

    if (self.currentLength > self.totalLength || self.totalLength == 0){
        if (self.progressHandler) {
            self.course.isDownload = @"1";
            [Course saveCourseData:self.course];
            self.progressHandler(1.0);
            return;
        }
    }
    
    
    if (!_isHaveCurrentLength) {
        Course *course = [Course CourseWithID:self.course.ID];
        NSLog(@"%lld",[course.currentLength longLongValue]);
        if ([course.progress floatValue] != 0 && [course.progress floatValue] < 1.0) {
            self.currentLength = [course.currentLength longLongValue];
        }
        _isHaveCurrentLength = YES;
    }
    
    self.currentLength += data.length;
    [self.writeHandle seekToEndOfFile];
    [self.writeHandle writeData:data];
    
    
    if (self.currentLength == self.totalLength) {
        
        if (self.progressHandler3) {
            
            self.course.isDownload = @"1";
            self.course.currentLength = [NSString stringWithFormat:@"%lld",_currentLength];
            [Course saveCourseData:self.course];
            self.progressHandler3(YES);
            
            
        }
        return;
    }
    

    if (self.progressHandler && self.course != nil) {
        double progress = (double)self.currentLength / self.totalLength;
        self.progressHandler(progress);
        
        
        
        
        operation = [NSBlockOperation blockOperationWithBlock:^{
//            NSLog(@"%@-----------%@",[NSString stringWithFormat:@"%f",progress],[NSThread currentThread]);
            if (progress < 1.0)
            {
                self.course.progress = [NSString stringWithFormat:@"%f",progress];
                self.course.currentLength = [NSString stringWithFormat:@"%lld",_currentLength];
                [Course saveCourseData:self.course];
            }
        }];
        
        
        queue.maxConcurrentOperationCount = 1;
        [queue addOperation:operation];
    }

}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (self.currentLength < self.totalLength) return;
    
    [self.writeHandle closeFile];
    self.writeHandle = nil;
    
    self.course.isDownload = @"1";
    [Course saveCourseData:self.course];
    
    //下载完成
    if (self.progressHandler3) {
        self.progressHandler3(YES);
        
    }
    
    //下载完成
    if (self.progressHandler3) {
        self.course.isDownload = @"1";
        [Course saveCourseData:self.course];
        self.progressHandler3(YES);
        
    }
    
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
//    NSLog(@"%@",response);
    if (self.totalLength) return;
    
    // 1.获得文件的总长度
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    self.totalLength = [httpResponse.allHeaderFields[@"Content-Length"] longLongValue];
    
    // 2.创建新的文件
    NSFileManager *mgr = [NSFileManager defaultManager];
    [mgr createFileAtPath:self.destPath contents:nil attributes:nil];
    
    // 3.创建写入句柄
    self.writeHandle = [NSFileHandle fileHandleForWritingAtPath:self.destPath];
}
@end
