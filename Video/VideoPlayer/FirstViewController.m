//
//  FirstViewController.m
//  Video
//
//  Created by LYL on 15/7/13.
//  Copyright (c) 2015年 jdong. All rights reserved.
//

#import "FirstViewController.h"
#import "KRVideoPlayerController.h"
#import "HMSegmentedControl.h"
#import "VideoCacheViewController.h"
//#import "TableViewController.h"
#import "CourseAPI.h"//网络
#import "AppDelegate.h"
#import "Course.h"//数据模型

#import "CourseCell.h"
#import "MBProgressHUD+MJ.h"
#import "UIImageView+WebCache.h"
#import "UIStringDrawing+Extension.h"

#define UIScreenHeight   [UIScreen mainScreen].bounds.size.height
#define UIScreenWidth    [UIScreen mainScreen].bounds.size.width
#define MYColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

static FirstViewController *sigleton = nil;

@interface FirstViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) KRVideoPlayerController *videoController;
@property (nonatomic, strong) HMSegmentedControl *segmentedControl4;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *array;//最终刷新列表的数组


@property (nonatomic, assign) NSInteger index;//当前的播放进度

@property (nonatomic, strong) NSArray *testVideo;

@property (nonatomic ,strong) UIButton *next;
@property (nonatomic ,strong) UIButton *pre;

@property (nonatomic,strong) UILabel *descLabel;


@property (nonatomic,strong) UIImageView *adview ;

@property (nonatomic ,strong) CourseCell *preCell;

@end

@implementation FirstViewController


+ (instancetype)firstViewControllerWith:(Courseslist *)courses
{
    FirstViewController *first = [[FirstViewController alloc] init];
    first.courses = courses;
    return first;
}

/**
 *  数据的懒加载
 */
- (NSMutableArray *)array
{
    if (_array == nil) {
        // 初始化
        _array = [NSMutableArray array];
    }
    return _array;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
    
    //    NSURL *videoURL = [[NSBundle mainBundle] URLForResource:@"minion_01.mp4" withExtension:nil];
    //        NSURL *videoURL = [NSURL URLWithString:@"http://bcs.duapp.com/njnuzs/media/zsxcp_MP4_AVC_AAC_1280x720_20150105145230.mp4"];
    //    [self playVideoWithURL:self.testVideo[_index]];
    
//    Course *course = self.array[_index];
//    NSURL *videoURL = [NSURL URLWithString:course.CourseURL];
//    [self playVideoWithURL:videoURL];
//    
//    [self getData];
    
    NSString *corseID = [[NSUserDefaults standardUserDefaults] stringForKey:@"playVideo"];
    if (![corseID isEqualToString:@""]) {
        self.array = [NSMutableArray array];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *cachesDir = [paths objectAtIndex:0];
        NSString *path = [NSString stringWithFormat:@"file://%@/%@.mp4",cachesDir,corseID];
        [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"playVideo"];
        [self playVideoWithURL:[NSURL URLWithString:path]];
        
        Course *course = [Course CourseWithID:corseID];
        if (course != nil) {
            [self.array addObject:course];
        }
        [self.tableView reloadData];
        
        [self playVideoWithURL:[NSURL URLWithString:path]];
        
        [self.adview removeFromSuperview];
    }else{
        if (IsObjectEmpty(self.array)) {
            return;
        }
        
        Course *course = self.array[_index];
        NSURL *videoURL = [NSURL URLWithString:course.CourseURL];
        [self playVideoWithURL:videoURL];
        
        [self getData];
    }
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _index = 0;
    // 初始化delegate的控制器属性，防止被释放
    //    AppDelegate *appdele = (AppDelegate*)[UIApplication sharedApplication];
    //    appdele.first = self;
    
    //    NSURL *url1 = [NSURL URLWithString:@"http://almond.qiniudn.com/origin/LB011.mp4"];
    //    NSURL *videoURL = [[NSBundle mainBundle] URLForResource:@"minion_01.mp4" withExtension:nil];
    //
    //    self.testVideo = @[videoURL,url1];

    
    
    
    self.view.backgroundColor = MYColor(235, 235, 235);
    // Do any additional setup after loading the view.
    
    
    [self setUpNav];
    
    [self setUpSegmegent];
    
    [self setPlayControl];
    
    [self getData];
    //
    
    
}


- (void)setUpNav
{
    UIImage *myImg = [[UIImage imageNamed:@"ic_period_download"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithImage:myImg style:UIBarButtonItemStyleDone target:self action:@selector(pushToDownload)];
    self.navigationItem.rightBarButtonItem = right;
    
    UIImage *Img = [[UIImage imageNamed:@"ic_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithImage:Img style:UIBarButtonItemStyleDone target:self action:@selector(pop)];
    
    
    self.navigationController.navigationBar.barTintColor = MYColor(50, 107, 255);
    self.navigationItem.leftBarButtonItem = left;
    
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(190, 0, 100, 44)];
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"生涯课程";
    self.navigationItem.titleView = titleLabel;
}
- (void)pop
{
    [self.navigationController popViewControllerAnimated:YES];
    [self.videoController pauseButtonClick];
}
// 推出下载页面
- (void)pushToDownload
{
    NSLog(@"pushToDownload");
    [self.navigationController pushViewController:[[VideoCacheViewController alloc] init] animated:YES];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //播放器在window上，必须在跳转页面的时候 移除掉
    [self.videoController dismiss];
    
    [self.adview removeFromSuperview];
    
    //reloadData后 cell上的进度条会更新
    [self.tableView reloadData];
}
- (void)playVideoWithURL:(NSURL *)url
{
    if (!self.videoController) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        _videoController = [[KRVideoPlayerController alloc] initWithFrame:CGRectMake(0, 64, width, width*(9.0/16.0))];
        
        __weak typeof(self)weakSelf = self;
        [self.videoController setDimissCompleteBlock:^{
            weakSelf.videoController = nil;
        }];
        [self.videoController showInWindow];
        
    }
    self.videoController.contentURL = url;
    
    [self setUpAD];
//
}

- (void)nextVideo
{
    if (self.array.count == 1 || self.array == nil) {
        return;
    }
    
    Course *course = self.array[++_index];
    NSURL *videoURL = [NSURL URLWithString:course.CourseURL];
    [self playVideoWithURL:videoURL];
    if (_index == self.array.count - 1) {
        self.next.enabled = NO;
    }
    if (_index != 0) {
        self.pre.enabled = YES;
    }
    
    CGFloat labelHeight = [self calHeightWithText:course.desc font:[UIFont systemFontOfSize:20] limitWidth:UIScreenWidth];
    self.descLabel.frame = CGRectMake(UIScreenWidth, 0, UIScreenWidth, labelHeight);
    
    NSIndexPath *indexpath = [NSIndexPath indexPathForItem:_index inSection:0];
    CourseCell *currcell = (CourseCell *)[self.tableView cellForRowAtIndexPath:indexpath];
    self.preCell.playing.hidden = YES;
    self.preCell = currcell;
    currcell.playing.hidden = NO;
    
    
    //test code
    //    [self playVideoWithURL:self.testVideo[++_index]];
    //
    //    if (_index == self.testVideo.count - 1) {
    //        self.next.enabled = NO;
    //    }
    //    if (_index != 0) {
    //        self.pre.enabled = YES;
    //    }
    
    
}
- (void)prevVideo
{
    if (self.array.count == 1 || self.array == nil) {
        return;
    }
    Course *course = self.array[--_index];
    NSURL *videoURL = [NSURL URLWithString:course.CourseURL];
    [self playVideoWithURL:videoURL];
    
    if (_index == 0) {
        self.pre.enabled = NO;
    }
    if (_index != self.array.count - 1) {
        self.next.enabled = YES;
    }
    
    CGFloat labelHeight = [self calHeightWithText:course.desc font:[UIFont systemFontOfSize:20] limitWidth:UIScreenWidth];
    self.descLabel.frame = CGRectMake(UIScreenWidth, 0, UIScreenWidth, labelHeight);
    
    NSIndexPath *indexpath = [NSIndexPath indexPathForItem:_index inSection:0];
    CourseCell *currcell = (CourseCell *)[self.tableView cellForRowAtIndexPath:indexpath];
    self.preCell.playing.hidden = YES;
    self.preCell = currcell;
    currcell.playing.hidden = NO;
    //test code
    //    [self playVideoWithURL:self.testVideo[--_index]];
    //
    //    if (_index == 0) {
    //        self.pre.enabled = NO;
    //    }
    //    if (_index != self.testVideo.count - 1) {
    //        self.next.enabled = YES;
    //    }
}

//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    NSURL *videoURL = [[NSBundle mainBundle] URLForResource:@"minion_01.mp4" withExtension:nil];
//    [self playVideoWithURL:videoURL];
//}

- (void)getData
{
    CourseAPI *api = [[CourseAPI alloc] init];
    [MBProgressHUD showMessage:@"加载中.."];
    if (IsObjectEmpty(self.courses)) {
        [MBProgressHUD hideHUD];
        return;
    }
    [api getCourseViewWithUrl:self.courses.CoursesURL completion:^(BOOL success, NSArray *object){
        [MBProgressHUD hideHUD];
        if (success) {
            NSLog(@"course data: %@", object);
            if (object.count == 0) {
                [MBProgressHUD showError:@"未获取到数据"];
                return ;
            }
            // ui actions
            NSMutableArray *temp = [NSMutableArray array];
            for (NSDictionary *dict in object) {
                Course *course = [Course courseWithDict:dict];
                [temp addObject:course];
            }
            _array = temp;
            
            [self.tableView reloadData];
        } else {
            // 提示网络异常
            [MBProgressHUD showError:@"网络异常"];
        }
        if (!IsObjectEmpty(self.array)) {
            Course *first = self.array[_index];
            CGFloat labelHeight = [self calHeightWithText:first.desc font:[UIFont systemFontOfSize:20] limitWidth:UIScreenWidth];
            UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(UIScreenWidth, 0, UIScreenWidth, labelHeight)];
            [self setApperanceForLabel:label2];
            
            label2.text = first.desc;
            [self.scrollView addSubview:label2];
            self.descLabel = label2;
        }
        
        
        if (self.array.count == 1) {
            self.pre.enabled = NO;
            self.next.enabled = NO;
        }else if (self.array.count == 2)
        {
            self.pre.enabled = NO;
            
        }
        
        
        
    }];
}
- (void)setUpAD
{
    if (IsObjectEmpty(self.array)) {
        return;
    }
    if (self.adview == nil) {
        //[[KRVideoPlayerController alloc] initWithFrame:CGRectMake(0, 64, width, width*(9.0/16.0))];
        UIImageView *adview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, UIScreenWidth, UIScreenWidth*(9.0/16.0))];
        Course *coure = self.array[0];
        adview.userInteractionEnabled = YES;
        NSURL *url = [NSURL URLWithString:coure.icon];
        [adview sd_setImageWithURL:url];
        
        UIButton *bigPlay = [UIButton buttonWithType:UIButtonTypeCustom];
        [bigPlay setImage:[UIImage imageNamed:@"VKVideoPlayer_play_big"] forState:UIControlStateNormal];
        bigPlay.frame = CGRectMake(0, 0, UIScreenWidth, UIScreenWidth*(9.0/16.0));
        [bigPlay addTarget:self action:@selector(clikeBigPlay) forControlEvents:UIControlEventTouchUpInside];
        
        [adview addSubview:bigPlay];
//        [self.view addSubview:adview];
        UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
        if (!keyWindow) {
            keyWindow = [[[UIApplication sharedApplication] windows] firstObject];
        }
        [keyWindow addSubview:adview];
        
        self.adview = adview;
    }

}

- (void)clikeBigPlay
{
    [self.adview removeFromSuperview];
//    self.adview.hidden = YES;
    
    [self.videoController playButtonClick];
}
/*
 
 NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
 NSString *cachesDir = [paths objectAtIndex:0];
 
 NSString *path = [cachesDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp4",CourseID]];
 
 */


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (IsObjectEmpty(self.array)) {
        return 0;
    }else
    {
        return self.array.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (IsObjectEmpty(self.array)) {
        return nil;
    }
    
    static NSString *ID = @"CourseCell";
    CourseCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    //    if (cell == nil) {
    //        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    //    }
    Course *corse = self.array[indexPath.row];
    
    //如果有值，说明缓存过，替换成本地的url
    if ([Course CourseWithID:corse.ID]) {
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *cachesDir = [paths objectAtIndex:0];
        NSString *path = [NSString stringWithFormat:@"file://%@/%@.mp4",cachesDir,corse.ID];
        
        corse.CourseURL = path;
    }
    cell.course = corse;
    if (indexPath.row == 0) {
        cell.playing.hidden = NO;
        self.preCell = cell;
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.adview.hidden = YES;
    
    CourseCell *currcell = (CourseCell *)[tableView cellForRowAtIndexPath:indexPath];
    self.preCell.playing.hidden = YES;
    self.preCell = currcell;
    currcell.playing.hidden = NO;
    
    if (self.array) {
        _index = indexPath.row;
        Course *course = self.array[_index];
        NSURL *videoURL = [NSURL URLWithString:course.CourseURL];
        [self playVideoWithURL:videoURL];
    }else
    {
        NSLog(@"数据数组为空");
        return;
    }

}

/*
 
 file:///Users/lyl/Library/Developer/CoreSimulator/Devices/6FD6288A-743F-4A53-9A21-86E613493354/data/Containers/Bundle/Application/77745291-4B48-437E-AE4A-41902C994138/Video.app/minion_01.mp4
 file:///Users/lyl/Library/Developer/CoreSimulator/Devices/6FD6288A-743F-4A53-9A21-86E613493354/data/Containers/Bundle/Application/A1FD9F80-462C-4B87-B329-274A76AF22E1/Video.app/minion_01.mp4
 file:///Users/lyl/Library/Developer/CoreSimulator/Devices/6FD6288A-743F-4A53-9A21-86E613493354/data/Containers/Bundle/Application/0B2D2063-F208-44AC-895E-073E6BFE1FF7/Video.app/minion_01.mp4
 */

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat pageWidth = scrollView.frame.size.width;
    NSInteger page = scrollView.contentOffset.x / pageWidth;
    
    [self.segmentedControl4 setSelectedSegmentIndex:page animated:YES];
}

- (void)setUpSegmegent {
    
    self.segmentedControl4 = [[HMSegmentedControl alloc] initWithFrame:CGRectMake(0, 64+UIScreenWidth*(9.0/16.0), UIScreenWidth, 50)];
    self.segmentedControl4.sectionTitles = @[@"目录", @"详情"];
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
        [weakSelf.scrollView scrollRectToVisible:CGRectMake(UIScreenWidth * index, 0, UIScreenWidth, 200) animated:YES];
    }];
    
    [self.view addSubview:self.segmentedControl4];
    
    CGFloat height = UIScreenHeight - 160 - UIScreenWidth*(9.0/16.0);
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 124+UIScreenWidth*(9.0/16.0), UIScreenWidth, height)];
    self.scrollView.backgroundColor = MYColor(235, 235, 235);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.contentSize = CGSizeMake(UIScreenWidth * 2, height);
    self.scrollView.delegate = self;
    [self.scrollView scrollRectToVisible:CGRectMake(0, 0, UIScreenWidth, height) animated:NO];
    [self.view addSubview:self.scrollView];
    // 创建tableView
    //    UITableView *videoTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight - 124 - UIScreenWidth*(9.0/16.0))];
    UITableView *videoTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, height)];
    videoTableView.backgroundColor = MYColor(235, 235, 235);
    videoTableView.delegate = self;
    videoTableView.dataSource = self;
    videoTableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    [self.scrollView addSubview:videoTableView];
    self.tableView = videoTableView;
    self.tableView.rowHeight = 65;
    //xib创建的cell必须要注册一下
    [self.tableView registerNib:[UINib nibWithNibName:@"CourseCell" bundle:nil] forCellReuseIdentifier:@"CourseCell"];
    
    
    
    //    UIWebView *web = [[UIWebView alloc] init];
    //    [web loa];
    
}
- (void)setApperanceForLabel:(UILabel *)label {
    label.backgroundColor = [UIColor clearColor];
    //    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:20.0f];
    label.lineBreakMode = NSLineBreakByCharWrapping;
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentLeft;
}


// 上一个，下一个
- (void)setPlayControl
{
    UIButton *next = [[UIButton alloc] init];
    CGFloat nextX = 0;
    CGFloat nextY = UIScreenHeight - 35;
    CGFloat nextW = 35;
    CGFloat nextH = 30;
    next.frame = CGRectMake(nextX, nextY, nextW, nextH);
    [next setImage:[UIImage imageNamed:@"ic_media_next_has"] forState:UIControlStateNormal];
    [next setImage:[UIImage imageNamed:@"ic_media_next_no"] forState:UIControlStateDisabled];
    [next addTarget:self action:@selector(nextVideo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:next];
    self.next = next;
    
    UIButton *pre = [[UIButton alloc] init];
    CGFloat preX = 2 * nextH;
    CGFloat preY = UIScreenHeight - 35;
    CGFloat preW = 35;
    CGFloat preH = 30;
    pre.frame = CGRectMake(preX, preY, preW, preH);
    [pre setImage:[UIImage imageNamed:@"ic_media_prev_has"] forState:UIControlStateNormal];
    [pre setImage:[UIImage imageNamed:@"ic_media_prev_no"] forState:UIControlStateDisabled];
    [pre addTarget:self action:@selector(prevVideo) forControlEvents:UIControlEventTouchUpInside];
//    pre.enabled = NO;
    [self.view addSubview:pre];
    self.pre = pre;
    
}



- (float)calHeightWithText:(NSString *)text font:(UIFont *)font limitWidth:(float)limitWidth
{
    
    NSDictionary *attribute = @{NSFontAttributeName: font};
    
    CGSize retSize = [text boundingRectWithSize:CGSizeMake(limitWidth, MAXFLOAT)
                                        options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                     attributes:attribute
                                        context:nil].size;
    
    return ceil(retSize.height);
}
//#pragma mark - 单列相关的方法
//+ (FirstViewController *)shareInstance
//{
//    if (sigleton == nil)
//    {
//        @synchronized(self)
//        {
//            sigleton = [[FirstViewController alloc] init];
//        }
//    }
//
//    return sigleton;
//}
//
//// 限制当前对象创建多实例
//#pragma mark - sengleton setting
//+ (id)allocWithZone:(NSZone *)zone
//{
//    @synchronized(self)
//    {
//        if (sigleton == nil)
//        {
//            sigleton = [super allocWithZone:zone];
//        }
//    }
//    return sigleton;
//}
//
//+ (id)copyWithZone:(NSZone *)zone
//{
//    return self;
//}

//- (void)viewWillAppear:(BOOL)animated
//{
//    [self.tableView reloadData];
//}
@end
