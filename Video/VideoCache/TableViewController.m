//
//  TableViewController.m
//  Sample
//
//  Created by Ignacio Romero Z. on 1/26/15.
//  Copyright (c) 2015 DZN Labs. All rights reserved.
//

#import "TableViewController.h"
#import "DZNSegmentedControl.h"

#define DEBUG_APPERANCE     NO
#define kBakgroundColor     [UIColor colorWithRed:0/255.0 green:87/255.0 blue:173/255.0 alpha:1.0]
#define kTintColor          [UIColor colorWithRed:20/255.0 green:200/255.0 blue:255/255.0 alpha:1.0]
#define kHairlineColor      [UIColor colorWithRed:0/255.0 green:36/255.0 blue:100/255.0 alpha:1.0]
#define MYColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
@interface TableViewController () <DZNSegmentedControlDelegate>
@property (nonatomic, strong) DZNSegmentedControl *control;
@property (nonatomic, strong) NSArray *menuItems;
@end

@implementation TableViewController

//+ (void)initialize
//{
//#if DEBUG_APPERANCE
//    
//    [[DZNSegmentedControl appearance] setBackgroundColor:kBakgroundColor];
//    [[DZNSegmentedControl appearance] setTintColor:kTintColor];
//    [[DZNSegmentedControl appearance] setHairlineColor:kHairlineColor];
//    
//    [[DZNSegmentedControl appearance] setFont:[UIFont fontWithName:@"EuphemiaUCAS" size:15.0]];
//    [[DZNSegmentedControl appearance] setSelectionIndicatorHeight:2.5];
//    [[DZNSegmentedControl appearance] setAnimationDuration:0.125];
//    
//    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor], NSFontAttributeName: [UIFont systemFontOfSize:18.0]}];
//    
//#endif
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _menuItems = @[[@"已离线" uppercaseString], [@"正在离线" uppercaseString]];
    
    self.tableView.tableHeaderView = self.control;
    self.tableView.tableFooterView = [UIView new];
    
    self.view.backgroundColor = MYColor(235, 235, 235);
    
//    [self setUpNav];
}


- (void)setUpNav
{
    UIImage *myImg = [[UIImage imageNamed:@"ic_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithImage:myImg style:UIBarButtonItemStyleDone target:self action:@selector(pool)];
    
    
    self.navigationController.navigationBar.barTintColor = MYColor(50, 107, 255);
    self.navigationItem.leftBarButtonItem = left;
    
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(190, 0, 100, 44)];
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"下载中心";
    self.navigationItem.titleView = titleLabel;
    
}

- (void)pool
{
    [self.navigationController popViewControllerAnimated:YES];
}
//- (void)loadView
//{
//    [super loadView];
//    
//    self.title = NSStringFromClass([DZNSegmentedControl class]);
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addSegment:)];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshSegments:)];
//}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    self.navigationController.navigationBar.translucent = NO;
//    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
//    self.navigationController.navigationBar.clipsToBounds = YES;
//    
//    [self updateControlCounts];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (DZNSegmentedControl *)control
{
    if (!_control)
    {
        _control = [[DZNSegmentedControl alloc] initWithItems:self.menuItems];
        _control.delegate = self;
        _control.selectedSegmentIndex = 1;
        _control.bouncySelectionIndicator = YES;
        _control.height = 64.0f;
        
        //        _control.height = 120.0f;
        //        _control.width = 300.0f;
        //        _control.showsGroupingSeparators = YES;
        //        _control.inverseTitles = YES;
        //        _control.backgroundColor = [UIColor lightGrayColor];
        //        _control.tintColor = [UIColor purpleColor];
        //        _control.hairlineColor = [UIColor purpleColor];
        //        _control.showsCount = NO;
        //        _control.autoAdjustSelectionIndicatorWidth = NO;
        //        _control.selectionIndicatorHeight = _control.intrinsicContentSize.height;
        //        _control.adjustsFontSizeToFitWidth = YES;
        
        [_control addTarget:self action:@selector(didChangeSegment:) forControlEvents:UIControlEventValueChanged];
    }
    return _control;
}


#pragma mark - UITableViewDataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.textLabel.textColor = [UIColor darkGrayColor];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ #%d", [[self.control titleForSegmentAtIndex:self.control.selectedSegmentIndex] capitalizedString], (int)indexPath.row+1];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 30.0;
//}


#pragma mark - UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


//#pragma mark - ViewController Methods
//
//- (void)addSegment:(id)sender
//{
//    NSUInteger newSegment = self.control.numberOfSegments;
//    
//    [self.control setTitle:[@"Favorites" uppercaseString] forSegmentAtIndex:self.control.numberOfSegments];
//    [self.control setCount:@((arc4random()%10000)) forSegmentAtIndex:newSegment];
//}
//
//- (void)refreshSegments:(id)sender
//{
//    [self.control removeAllSegments];
//    
//    [self.control setItems:self.menuItems];
//    [self updateControlCounts];
//}
//
//- (void)updateControlCounts
//{
//    [self.control setCount:@((arc4random()%10000)) forSegmentAtIndex:0];
//    [self.control setCount:@((arc4random()%10000)) forSegmentAtIndex:1];
////    [self.control setCount:@((arc4random()%10000)) forSegmentAtIndex:2];
//    
//#if DEBUG_APPERANCE
//    [self.control setTitleColor:kHairlineColor forState:UIControlStateNormal];
//#endif
//}

- (void)didChangeSegment:(DZNSegmentedControl *)control
{
    [self.tableView reloadData];
}


#pragma mark - UIBarPositioningDelegate Methods

- (UIBarPosition)positionForBar:(id <UIBarPositioning>)view
{
    return UIBarPositionBottom;
}

@end
