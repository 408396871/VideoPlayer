//
//  CourseCell.m
//  Video
//
//  Created by LYL on 15/7/14.
//  Copyright (c) 2015年 jdong. All rights reserved.
//

#import "CourseCell.h"
#import "Course.h"
#import "DownloadCenter.h"
#import "UIImageView+WebCache.h"
#import "UIStringDrawing+Extension.h"
#import "MJFileDownloader.h"
@interface CourseCell()<NSURLConnectionDataDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *durtionLabel;
@property (weak, nonatomic) IBOutlet UIButton *downloadBtn;
@property (strong, nonatomic) MJFileDownloader *fileDownloader;
- (IBAction)clickBtton:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;


@end
@implementation CourseCell

- (void)awakeFromNib {
    // Initialization code

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCourse:(Course *)course
{
    _course = course;
    
    if (!IsStringEmpty(course.name)) {
        self.titleLabel.text = course.name;
    }
    if (!IsStringEmpty(course.duration)) {
        self.durtionLabel.text = course.duration;
    }
    
    
    Course *cacheCourse = [Course CourseWithID:self.course.ID];
    self.progressView.progress = [cacheCourse.progress floatValue];
    
    self.fileDownloader = [DownloadCenter MJFileDownloaderWithCourse:self.course];
    
    if ([cacheCourse.isDownload isEqualToString:@"1"]) {
        self.downloadBtn.enabled = NO;
        [self.downloadBtn setImage:[UIImage imageNamed:@"ic_download_finish"] forState:UIControlStateNormal];
    }
    
    
    if ([cacheCourse.isDownload isEqualToString:@"0"]) {
        self.progressView.hidden = NO;
        self.progressView.progress = [cacheCourse.progress floatValue];
        
        if (self.fileDownloader.isDownloading) {
            //正在下载
            [self.downloadBtn setImage:[UIImage imageNamed:@"pauseDownload"] forState:UIControlStateNormal];
        } else {
            //暂停下载
            [self.downloadBtn setImage:[UIImage imageNamed:@"ic_period_download"] forState:UIControlStateNormal];
        }
    }
    
    
}


- (IBAction)clickBtton:(UIButton *)button {
    
    
//    self.fileDownloader = [DownloadCenter MJFileDownloaderWithCourse:self.course];
    
//    self.fileDownloader = [DownloadCenter MJFileDownloadWith:self.course];
    
    Course *cacheCourse = [Course CourseWithID:self.course.ID];
    
    
    if ([cacheCourse.isDownload isEqualToString:@"0"] || cacheCourse == nil) {
        self.progressView.hidden = NO;
        
        if (self.fileDownloader.isDownloading) {
            //正在下载
            
            [self.downloadBtn setImage:[UIImage imageNamed:@"ic_period_download"] forState:UIControlStateNormal];
            [self.fileDownloader pause];
        } else {
            //暂停下载
            [self.downloadBtn setImage:[UIImage imageNamed:@"pauseDownload"] forState:UIControlStateNormal];
            [self.fileDownloader start];
        }
        
    }
    
    __weak typeof(self) weakself = self;
    self.fileDownloader.progressHandler = ^(double progress){
        weakself.progressView.progress = progress;
        
    };
    
    self.fileDownloader.progressHandler3 = ^(BOOL isComplete){
        weakself.downloadBtn.enabled = NO;
        [weakself.downloadBtn setImage:[UIImage imageNamed:@"ic_download_finish"] forState:UIControlStateNormal];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *cachesDir = [paths objectAtIndex:0];
        NSString *path = [NSString stringWithFormat:@"file://%@/%@.mp4",cachesDir,weakself.course.ID];
        
        weakself.course.CourseURL = path;
        weakself.progressView.hidden = YES;
    };
}
@end
