//
//  VideoCacheViewController.m
//  Video
//
//  Created by dongjiang on 15/7/13.
//  Copyright (c) 2015年 jdong. All rights reserved.
//

#import "VideoCacheViewController.h"
#import "HMSegmentedControl.h"
#import "VideoCacheCell.h"
#import "VideoDownloadCell.h"
#import "Course.h"
#import "UIStringDrawing+Extension.h"
#import "FirstViewController.h"

#define UIScreenHeight   [UIScreen mainScreen].bounds.size.height
#define UIScreenWidth    [UIScreen mainScreen].bounds.size.width
#define MYColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
@interface VideoCacheViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,VideoDownloadCellDelegate,VideoCacheCellDelegate>
@property (nonatomic, strong) HMSegmentedControl *segmentedControl4;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic,strong)UITableView * tableViewDidDownload;
@property (nonatomic,strong)UITableView * tableViewNotDownloadArray;
@property(nonatomic,strong)NSMutableDictionary *fileDownloaderDictionary;

@property (nonatomic,strong)NSMutableArray * didDownloadArray;
@property (nonatomic,strong)NSMutableArray * notDownloadArray;
@end

@implementation VideoCacheViewController

static VideoCacheViewController *instance = nil;

//单例
+(instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance = [[VideoCacheViewController alloc] init];
    });
    
    return instance;
}






- (void)viewDidLoad {
    [super viewDidLoad];
    //50 107 255
    
    self.view.backgroundColor = MYColor(235, 235, 235);
    
    [self setUpNav];
    
    [self setUpSegmegent];
    
//    [self.tableView registerNib:[UINib nibWithNibName:@"VideoCacheCell" bundle:nil] forCellReuseIdentifier:@"VideoCacheCell"];
    
//    Course *course = [Course CourseWithID:@"12"];
//    
//    NSLog(@"%@",course.ID);
    
    
    
    
    
   
}

- (void)viewWillAppear:(BOOL)animated
{
    [self updateData];
}

- (void)updateData{
    NSArray *array = [[NSUserDefaults standardUserDefaults] arrayForKey:@"CourseIDList"];
    
    [_didDownloadArray removeAllObjects];
    [_notDownloadArray removeAllObjects];
    _didDownloadArray = [NSMutableArray array];
    _notDownloadArray = [NSMutableArray array];
    
    if ([NSString isNotNull:array]) {
        for (NSString *courseID in array) {
            //判断已下载、未下载
            Course *course = [Course CourseWithID:courseID];
            
            if (course.isDownload != nil) {
                if ([course.isDownload isEqualToString:@"1"]) {
                    
                    [_didDownloadArray addObject:course];
                }else if ([course.isDownload isEqualToString:@"0"]) {
                    
                    [_notDownloadArray addObject:course];
                }
            }
        }
    }
    
    NSLog(@"%@",array);

}


- (void)setUpNav
{
    UIImage *myImg = [[UIImage imageNamed:@"ic_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithImage:myImg style:UIBarButtonItemStyleDone target:self action:@selector(pop)];
    
    
    self.navigationController.navigationBar.barTintColor = MYColor(50, 107, 255);
    self.navigationItem.leftBarButtonItem = left;
    
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(190, 0, 100, 44)];
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"下载中心";
    self.navigationItem.titleView = titleLabel;
    
}
- (void)pop
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)setUpSegmegent {
    self.segmentedControl4 = [[HMSegmentedControl alloc] initWithFrame:CGRectMake(0, 64, UIScreenWidth, 50)];
    self.segmentedControl4.sectionTitles = @[@"已离线", @"正在离线"];
    self.segmentedControl4.selectedSegmentIndex = 0;
    self.segmentedControl4.selectionIndicatorHeight = 2.0f;
    self.segmentedControl4.backgroundColor = [UIColor clearColor];
    self.segmentedControl4.titleTextAttributes = @{NSForegroundColorAttributeName : MYColor(72, 72, 72)};
    self.segmentedControl4.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : MYColor(101, 149, 251)};
    self.segmentedControl4.selectionIndicatorColor = MYColor(101, 149, 251);
    self.segmentedControl4.selectionStyle = HMSegmentedControlSelectionStyleBox;
    self.segmentedControl4.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    
    __weak typeof(self) weakSelf = self;
    [self.segmentedControl4 setIndexChangeBlock:^(NSInteger index) {
        [weakSelf.scrollView scrollRectToVisible:CGRectMake(UIScreenWidth * index, 0, UIScreenWidth,  UIScreenHeight - 124 ) animated:YES];
    }];
    
    [self.view addSubview:self.segmentedControl4];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 124+0, UIScreenWidth, UIScreenHeight - 124 + 0)];
    self.scrollView.backgroundColor = MYColor(235, 235, 235);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.contentSize = CGSizeMake(UIScreenWidth * 2, UIScreenHeight - 124);
    self.scrollView.delegate = self;
    [self.scrollView scrollRectToVisible:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight - 124+0) animated:NO];
    [self.view addSubview:self.scrollView];
    // 创建tableView
    UITableView *videoTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight - 124 )];
    videoTableView.backgroundColor = MYColor(235, 235, 235);
    videoTableView.delegate = self;
    videoTableView.dataSource = self;
    videoTableView.tag = 10001;
    videoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.scrollView addSubview:videoTableView];
    self.tableViewDidDownload = videoTableView;
    
//    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(UIScreenWidth, 0, UIScreenWidth, 210)];
//    [self setApperanceForLabel:label2];
//    label2.text = @"Local";
//    [self.scrollView addSubview:label2];
    
    
    UITableView *videoTableView2 = [[UITableView alloc] initWithFrame:CGRectMake(UIScreenWidth, 0, UIScreenWidth, UIScreenHeight - 124 )];
    videoTableView2.backgroundColor = MYColor(235, 235, 235);
    videoTableView2.delegate = self;
    videoTableView2.dataSource = self;
    videoTableView2.tag = 10002;
    videoTableView2.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.scrollView addSubview:videoTableView2];
    self.tableViewNotDownloadArray = videoTableView2;
}

- (void)setApperanceForLabel:(UILabel *)label {
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    label.backgroundColor = color;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:21.0f];
    label.textAlignment = NSTextAlignmentCenter;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 10001) {
        return 80;
    }else{
        return 70;
    }
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 10001) {
        return _didDownloadArray.count;
    }else{
        return _notDownloadArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView.tag == 10001) {
        
        Course *course = _didDownloadArray[indexPath.row];
        
        VideoCacheCell *cell = [VideoCacheCell cellWithTableView:tableView Course:course];
        
        cell.delegate = self;
        
        return cell;
    }else{
        
        Course *course = _notDownloadArray[indexPath.row];
        
        VideoDownloadCell *cell = [VideoDownloadCell cellWithTableView:tableView];
        
        cell.course = course;
        cell.delegate = self;
        
        return cell;
    }
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 10001) {
        Course *course = _didDownloadArray[indexPath.row];
        [[NSUserDefaults standardUserDefaults]setObject:course.ID forKey:@"playVideo"];
//        [self.navigationController popViewControllerAnimated:YES];
        
        FirstViewController *fir = [[FirstViewController alloc] init];
        [self.navigationController pushViewController:fir animated:YES];
    }
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat pageWidth = scrollView.frame.size.width;
    NSInteger page = scrollView.contentOffset.x / pageWidth;
    
    [self.segmentedControl4 setSelectedSegmentIndex:page animated:YES];
}

- (void)didDownload:(Course *)course
{
//    for (Course *oldCourse in _didDownloadArray) {
//        if (oldCourse.ID == course.ID) {
//            [_didDownloadArray removeObject:oldCourse];
//        }
//    }
    [_notDownloadArray removeObject:course];
    [self updateData];
    [self.tableViewDidDownload reloadData];
    [self.tableViewNotDownloadArray reloadData];
}

- (void)deletBtn:(Course *)course
{
    [_didDownloadArray removeObject:course];
    [self updateData];
    [self.tableViewNotDownloadArray reloadData];
    [self.tableViewDidDownload reloadData];
}
@end
