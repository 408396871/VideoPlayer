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
#import "TableViewController.h"

#define UIScreenHeight   [UIScreen mainScreen].bounds.size.height
#define UIScreenWidth    [UIScreen mainScreen].bounds.size.width
#define MYColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]


@interface FirstViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) KRVideoPlayerController *videoController;
@property (nonatomic, strong) HMSegmentedControl *segmentedControl4;
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation FirstViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSURL *videoURL = [[NSBundle mainBundle] URLForResource:@"minion_01.mp4" withExtension:nil];
    //    NSURL *videoURL = [NSURL URLWithString:@"http://streams.videolan.org/streams/mp4/Mr_MrsSmith-h264_aac.mp4"];
    [self playVideoWithURL:videoURL];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MYColor(235, 235, 235);
    // Do any additional setup after loading the view.

    
    [self setUpNav];
    
    [self setUpSegmegent];
    
    
}
- (void)setUpNav
{
    UIImage *myImg = [[UIImage imageNamed:@"ic_period_download"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithImage:myImg style:UIBarButtonItemStyleDone target:self action:@selector(pushToDownload)];
    self.navigationItem.rightBarButtonItem = right;
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
    //adada
    
}

- (void)setUpSegmegent {
    self.segmentedControl4 = [[HMSegmentedControl alloc] initWithFrame:CGRectMake(0, 64+UIScreenWidth*(9.0/16.0), UIScreenWidth, 50)];
    self.segmentedControl4.sectionTitles = @[@"Worldwide", @"Local"];
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
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 124+UIScreenWidth*(9.0/16.0), UIScreenWidth, UIScreenHeight - 124 + UIScreenWidth*(9.0/16.0))];
    self.scrollView.backgroundColor = MYColor(235, 235, 235);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.contentSize = CGSizeMake(UIScreenWidth * 2, UIScreenHeight - 124+UIScreenWidth*(9.0/16.0));
    self.scrollView.delegate = self;
    [self.scrollView scrollRectToVisible:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight - 124+UIScreenWidth*(9.0/16.0)) animated:NO];
    [self.view addSubview:self.scrollView];
    // 创建tableView
    UITableView *videoTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight - 124 - UIScreenWidth*(9.0/16.0))];
    videoTableView.backgroundColor = MYColor(235, 235, 235);
    videoTableView.delegate = self;
    videoTableView.dataSource = self;
    videoTableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    [self.scrollView addSubview:videoTableView];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(UIScreenWidth, 0, UIScreenWidth, 210)];
    [self setApperanceForLabel:label2];
    label2.text = @"Local";
    [self.scrollView addSubview:label2];
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



//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    NSURL *videoURL = [[NSBundle mainBundle] URLForResource:@"minion_01.mp4" withExtension:nil];
//    [self playVideoWithURL:videoURL];
//}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"movie";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = @"test";
    return cell;
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat pageWidth = scrollView.frame.size.width;
    NSInteger page = scrollView.contentOffset.x / pageWidth;
    
    [self.segmentedControl4 setSelectedSegmentIndex:page animated:YES];
}
@end
