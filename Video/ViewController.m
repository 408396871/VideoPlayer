//
//  ViewController.m
//  Video
//
//  Created by jdong on 15-7-13.
//  Copyright (c) 2015年 jdong. All rights reserved.
//

#import "ViewController.h"
#import "CourseAPI.h"



#import "FirstViewController.h"
#import "VideoCacheViewController.h"

#import "CoursesListController.h"
#import "LYProgressView.h"

@interface ViewController ()
- (IBAction)pushToNext:(UIButton *)sender;

@property (nonatomic,strong) UILabel *popView;

@property (nonatomic,strong) LYProgressView *prog;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LYProgressView *prog = [[LYProgressView alloc] initWithFrame:CGRectMake(10, 100, 300, 50)];
    prog.progress = 0;
    [self.view addSubview:prog];
    self.prog = prog;
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timeGo:) userInfo:nil repeats:YES];
    
//    [self saveImage:[UIImage imageNamed:@"test"] WithName:@"123.png"];
}

- (void)timeGo:(NSTimer *)timer
{
    if (self.prog.progress == 1.0) {
        [timer invalidate];
    }
//    self.prog.progress += 0.01;
    
    [self.prog setProgress:self.prog.progress +0.01 animated:YES];
}

- (void)updateValue:(UISlider *)slider{
    UIImageView *imageView = [slider.subviews objectAtIndex:2];
    
    CGRect theRect = [self.view convertRect:imageView.frame fromView:imageView.superview];
    
//    [_popView setFrame:CGRectMake(theRect.origin.x+theRect.size.width/2, theRect.origin.y, _popView.frame.size.width, _popView.frame.size.height)];
    
    _popView.center = CGPointMake(theRect.origin.x+theRect.size.width, theRect.origin.y + theRect.size.height/2);
    _popView.bounds = CGRectMake(0, 0, _popView.frame.size.width, _popView.frame.size.height);
    
    NSInteger v = slider.value+0.5;
    [_popView setText:[NSString stringWithFormat:@"%ld%%",(long)v]];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pushToNext:(UIButton *)sender {
    //    FirstViewController *first = [[FirstViewController alloc] init];
    CoursesListController *first = [[CoursesListController alloc] init];
    [self.navigationController pushViewController:first animated:YES];
    
}
/**
 *  保存图片到document
 */
- (void)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName
{
    NSData* imageData = UIImagePNGRepresentation(tempImage);
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];
    // Now we get the full path to the file
    NSString* fullPathToFile = [documentsDirectory stringByAppendingPathComponent:imageName];
    // and then we write it out
    [imageData writeToFile:fullPathToFile atomically:NO];
}
@end
