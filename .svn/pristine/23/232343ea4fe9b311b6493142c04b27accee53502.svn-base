//
//  ADScrollview.h
//  04-图片轮播器
//
//  Created by lyl on 15-7-6.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Courseslist.h"

@protocol ADScrollviewDelegate <NSObject>

- (void)didClikePics:(Courseslist *)courseList;

@end


@interface ADScrollview : UIView
// 创建
+ (instancetype)NewADScrollview;

//图片数组
@property (nonatomic,strong) NSArray * pics;
//title数组
@property (nonatomic,strong) NSArray * titleArray;
//广告urls，需要是 http:// .....
@property (nonatomic,strong) NSArray * picsUrls;

// 启动轮播图，必须在数组赋值完毕，也就是最后调用
- (void)letUsRock;



@property (nonatomic,weak) id<ADScrollviewDelegate> delegate;

@end
