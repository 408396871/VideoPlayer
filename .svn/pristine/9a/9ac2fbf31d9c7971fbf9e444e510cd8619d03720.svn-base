//
//  VideoDownloadCell.m
//  Video
//
//  Created by jdong on 15-7-14.
//  Copyright (c) 2015年 jdong. All rights reserved.
//

#import "VideoDownloadCell.h"
#import "MJFileDownloader.h"
#import "DownloadCenter.h"
#import "Course.h"
#import "UIStringDrawing+Extension.h"

#define MJURL(path) [@"http://localhost:8080/job/job1/ws" stringByAppendingPathComponent:path]

@interface VideoDownloadCell()<NSURLConnectionDataDelegate>
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
- (IBAction)start:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *mybutton;
@property (weak, nonatomic) IBOutlet UILabel *title;

@property (strong, nonatomic) MJFileDownloader *fileDownloader;
@end
@implementation VideoDownloadCell

- (void)awakeFromNib {
    
    
}


+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"VideoDownloadCell";
    VideoDownloadCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        // 从xib中加载cell
        cell = [[[NSBundle mainBundle] loadNibNamed:@"VideoDownloadCell" owner:nil options:nil] lastObject];
    }
    return cell;
}


- (void)setCourse:(Course *)course
{
    _course = course;
    
    
    if (!IsStringEmpty(course.name)) {
        self.title.text = course.name;
    }
    
    //如果下载中心页面已经建立下载链接，则不必重复建立
    Course *cacheCourse = [Course CourseWithID:self.course.ID];
    if (cacheCourse == nil) {//未下载过
        
    }else{
        //下载过，不清楚释是否完成
        self.fileDownloader = [DownloadCenter MJFileDownloaderWithCourse:self.course];
        
        
        
        Course *cacheCourse = [Course CourseWithID:self.course.ID];
        if ([cacheCourse.isDownload isEqualToString:@"1"]) {//已下载
            
        }else if([cacheCourse.isDownload isEqualToString:@"0"])//正在下载
        {
            if (self.fileDownloader.isDownloading) {
                //正在下载
                [self.mybutton setTitle:@"暂停" forState:UIControlStateNormal];
            } else {
                //暂停下载
                [self.mybutton setTitle:@"开始" forState:UIControlStateNormal];
            }
            self.progressView.progress = [cacheCourse.progress floatValue];
            __weak typeof(self) weakself = self;
            self.fileDownloader.progressHandler = ^(double progress){
                weakself.progressView.progress = progress;
                if (progress == 1.0) {
                    course.isDownload = @"1";
                    [Course saveCourseData:course];
                    if ([weakself.delegate respondsToSelector:@selector(didDownload:)]) {
                        [weakself.delegate didDownload:course];
                    }
                }
                
            };
            
            
            self.fileDownloader.progressHandler3 = ^(BOOL isComplete){
                course.isDownload = @"1";
                [Course saveCourseData:course];
                if ([weakself.delegate respondsToSelector:@selector(didDownload:)]) {
                    [weakself.delegate didDownload:course];
                }
                
            };
            
        }
        
        
    }
    
    
}






- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)start:(UIButton *)button {
    if (self.fileDownloader.isDownloading) {
        [button setTitle:@"开始" forState:UIControlStateNormal];
        [self.fileDownloader pause];
    } else {
        
        [button setTitle:@"暂停" forState:UIControlStateNormal];
        [self.fileDownloader start];
    }
    
    
//    //如果下载中心页面已经建立下载链接，则不必重复建立
//    if ([DownloadCenter MJFileDownloaderWithID:self.course.ID] == nil) {//未下载
//        self.fileDownloader = [DownloadCenter MJFileDownloadWith:self.course];
//    }
//    
//    if (button.selected) {//选中的时候是正在下载的状态，点击按钮就是暂停
//        [self.fileDownloader pause];
//        button.selected = NO;
//    }else//未选中状态就显示 下载
//    {
//        //1 存储模型
//        self.course.isDownload = @"0";
//        [Course saveCourseData:self.course];
//        //2 建立下载链接
//        [self.fileDownloader start];
//        button.selected = YES;
//        
//        __weak typeof(self) weakself = self;
//        self.fileDownloader.progressHandler = ^(double progress){
//            weakself.progressView.progress = progress;
//            if (progress == 1.0) {
//                [button setTitle:@"完成" forState:UIControlStateNormal];
//                //                weakself.course.isDownload = @"1";
//                //                [Course saveCourseData:weakself.course];
//            }
//        };
//    }

    
    
}


@end
