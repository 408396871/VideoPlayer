//
//  CoursesListController.m
//  Video
//
//  Created by LYL on 15/7/14.
//  Copyright (c) 2015年 jdong. All rights reserved.
//

#import "CoursesListController.h"

#import "CourseAPI.h"
#import "Courseslist.h"
#import "FirstViewController.h"

#import "CourseListCell.h"
#import "ADScrollview.h"
#import "VideoCacheViewController.h"

#import "MBProgressHUD+MJ.h"

#define UIScreenHeight   [UIScreen mainScreen].bounds.size.height
#define UIScreenWidth    [UIScreen mainScreen].bounds.size.width

#define MYColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
@interface CoursesListController ()<ADScrollviewDelegate>
@property(nonatomic,strong)NSMutableArray *array;

@property(nonatomic,strong)ADScrollview *ad;

@end

@implementation CoursesListController
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


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    


    //xib创建的cell必须要注册一下
    [self.tableView registerNib:[UINib nibWithNibName:@"CourseListCell" bundle:nil] forCellReuseIdentifier:@"CourseListCell"];
    //去掉自带分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //设置cell的高度
    self.tableView.rowHeight = 70;
    [self getData];
    
    [self setUpNav];
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
}
// 推出下载页面
- (void)pushToDownload
{
    NSLog(@"pushToDownload");
    [self.navigationController pushViewController:[[VideoCacheViewController alloc] init] animated:YES];
}
- (void)getData {
    CourseAPI *api = [[CourseAPI alloc] init];
    [MBProgressHUD showMessage:@"加载中.."];
    [api findCourseListWithCompletion:^(BOOL success, NSDictionary *object){
        [MBProgressHUD hideHUD];
        if (success) {
            NSArray *courses = object[@"course_list"];
            NSLog(@"course: %@", object);
            NSMutableArray *temp = [NSMutableArray array];
            for (NSDictionary *dict in courses) {
                Courseslist *course = [Courseslist courseslistWithDict:dict];
                [temp addObject:course];
            }
            _array = temp;
            // 轮播图
            NSArray *bannners = object[@"course_recommend"];
            NSMutableArray *banModel = [NSMutableArray array];
            NSMutableArray *tempBan = [NSMutableArray array];
            NSMutableArray *titles = [NSMutableArray array];
            for (NSDictionary *dict in bannners) {
                NSString *bannnerURL = dict[@"icon"];
                NSString *title = dict[@"name"];
                [tempBan addObject:bannnerURL];
                [titles addObject:title];
                
                Courseslist *ban = [Courseslist courseslistWithDict:dict];
                [banModel addObject:ban];

            }
//            for (NSDictionary *dict in bannners) {
//                Courseslist *ban = [Courseslist courseslistWithDict:dict];
//                [tempBan addObject:ban];
//            }
            
            ADScrollview *ad = [ADScrollview NewADScrollview];
            ad.delegate = self;
            ad.frame = CGRectMake(0, 0, UIScreenWidth, 130);
            
            ad.pics = tempBan;//图片数组
            ad.titleArray = titles;//name数组
            
            ad.picsUrls = banModel;
            
            self.tableView.tableHeaderView = ad;
            // 启动轮播图
            [ad letUsRock];

            
            [self.tableView reloadData];
        } else {
            // 提示网络异常
            [MBProgressHUD showError:@"网络异常"];
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"CourseListCell";
    CourseListCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//    if (cell == nil) {
//        cell = [[CourseListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
//    }
    Courseslist *corse = self.array[indexPath.row];
    cell.course = corse;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Courseslist *course = self.array[indexPath.row];
    FirstViewController *first = [FirstViewController firstViewControllerWith:course];
//    FirstViewController *first = [FirstViewController shareInstance];
//    first.courses = course;
    [self.navigationController pushViewController:first animated:YES];
}

- (void)didClikePics:(Courseslist *)courseList
{
    FirstViewController *first = [FirstViewController firstViewControllerWith:courseList];
    //    FirstViewController *first = [FirstViewController shareInstance];
    //    first.courses = course;
    [self.navigationController pushViewController:first animated:YES];
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
