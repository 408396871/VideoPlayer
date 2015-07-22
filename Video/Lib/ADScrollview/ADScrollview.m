//
//  ADScrollview.m
//  04-图片轮播器
//
//  Created by lyl on 15-7-6.
//  Copyright (c) 2015年 itcast. All rights reserved.
//
#define imgcount 5
#import "ADScrollview.h"
#import "UIImageView+WebCache.h"
#import "FirstViewController.h"

@interface ADScrollview ()<UIScrollViewDelegate>
//
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UILabel *bannnerTitle;

/**
 *  定时器
 */
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation ADScrollview
/**
 *  快速创建 xib
 */
+ (instancetype)NewADScrollview
{
    //从 xib 里面读取
    return [[[NSBundle mainBundle] loadNibNamed:@"ADScrollview" owner:nil options:nil] lastObject];
}
-(void)awakeFromNib
{
    // 0.隐藏水平滚动条
    self.scrollView.showsHorizontalScrollIndicator = NO;
    
    // 1.分页
    self.scrollView.pagingEnabled = YES;
    //    self.scrollView.delegate = self;
    
}
- (void)letUsRock
{
    if (!self.pics) {
        NSLog(@"图片数组不可为空");
        return;
    }
    
    if (self.pics.count != self.picsUrls.count) {
        NSLog(@"图片数量和广告数量不对应");
//        return;
    }
    // 2.设置pageControl的总页数
    self.pageControl.numberOfPages = self.pics.count;
    
    self.bannnerTitle.text = self.titleArray[0];
    
    // 3.添加定时器(每隔2秒调用一次self 的nextImage方法)
    [self addTimer];
}

/**
 *  不要再 init 或者 awakeFromNib 涉及到 frame，值是不准确的，需要在下面的方法里面设置
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 0.一些固定的尺寸参数
    CGFloat imageW = self.scrollView.frame.size.width;
    CGFloat imageH = self.scrollView.frame.size.height;
    CGFloat imageY = 0;
    
    // 1.添加5张图片到scrollView中
    for (int i = 0; i < self.pics.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.userInteractionEnabled = YES;
        // 没有广告url就不需要创建点击事件了
        if (self.picsUrls) {
            // 绑定 tag
            imageView.tag = i;
            // 绑定点击事件
            [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPic:)]];
        }
        
        // 设置frame
        CGFloat imageX = i * imageW;
        imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
        
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [imageView setClipsToBounds:YES];
        // 设置图片
        //        NSString *name = [NSString stringWithFormat:@"img_0%d", i + 1];
        //        imageView.image = [UIImage imageNamed:@"jetpacktocat"];// 替换成 SDWebimage
        
        [imageView sd_setImageWithURL:self.pics[i] placeholderImage:[UIImage imageNamed:@"img_01"]];
        
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.scrollView addSubview:imageView];
    }
    // 2.设置内容尺寸
    CGFloat contentW = self.pics.count * imageW;
    self.scrollView.contentSize = CGSizeMake(contentW, 0);
    
}
/**
 *  图片的点击事件
 */
- (void)tapPic:(UIGestureRecognizer *)gesture
{
    
    UIImageView *img = (UIImageView *)gesture.view;
    
    Courseslist *urlString = self.picsUrls[img.tag];
    // 这种打开网页的方式 需要是 http 开头的 http://site.baidu.com/
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
    
    if ([self.delegate respondsToSelector:@selector(didClikePics:)]) {
        [self.delegate didClikePics:urlString];
    }
}

/**
 *  添加定时器
 */
- (void)addTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

/**
 *  移除定时器
 */
- (void)removeTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)nextImage
{
    // 1.增加pageControl的页码
    NSInteger page = 0;
    if (self.pageControl.currentPage == self.pics.count - 1) {
        page = 0;
        self.bannnerTitle.text = self.titleArray[0];
    } else {
        page = self.pageControl.currentPage + 1;
    }
    
    // 2.计算scrollView滚动的位置
    CGFloat offsetX = page * self.scrollView.frame.size.width;
    CGPoint offset = CGPointMake(offsetX, 0);
    [self.scrollView setContentOffset:offset animated:YES];
}

#pragma mark - 代理方法
/**
 *  当scrollView正在滚动就会调用
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 根据scrollView的滚动位置决定pageControl显示第几页
    CGFloat scrollW = scrollView.frame.size.width;
    int page = (scrollView.contentOffset.x + scrollW * 0.5) / scrollW;
    self.pageControl.currentPage = page;
    self.bannnerTitle.text = self.titleArray[page];
}

/**
 *  开始拖拽的时候调用
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    // 停止定时器(一旦定时器停止了,就不能再使用)
    [self removeTimer];
}

/**
 *  停止拖拽的时候调用
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    // 开启定时器
    [self addTimer];
}





@end
