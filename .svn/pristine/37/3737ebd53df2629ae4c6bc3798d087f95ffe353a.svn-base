//
//  LYProgressView.m
//  Video
//
//  Created by LYL on 15/7/16.
//  Copyright (c) 2015年 jdong. All rights reserved.
//

#import "LYProgressView.h"
#define MYColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
@interface LYProgressView()
@property (strong, nonatomic) UILabel *popLabel;
@end

@implementation LYProgressView

#pragma mark - initialization

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}
#pragma mark - private

- (void)setup
{
    [self addSubview:self.popLabel];
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [self updatePopUpView];
}
- (void)updatePopUpView
{
    self.popLabel.text = [NSString stringWithFormat:@"%2.0f%%",self.progress*100];
    // 计算label的frame
    CGRect bounds = self.bounds;
    CGFloat xPos = (CGRectGetWidth(bounds) * self.progress);//progress是个百分比，乘以自己的宽度就是x的坐标
    //宽度和高度可以自由调整
    CGRect popUpRect = CGRectMake(xPos, -7,30, 15);
    
    [self.popLabel setFrame:popUpRect];
}

- (UILabel *)popLabel
{
    if (!_popLabel) {
        _popLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _popLabel.backgroundColor = [UIColor whiteColor];//需要和背景保持一致，才会有遮挡的效果
        _popLabel.textAlignment = NSTextAlignmentCenter;
        [_popLabel setFont:[UIFont systemFontOfSize:10]];
        [_popLabel setTextColor:MYColor(50, 107, 255)];//自己调整
    }
    return _popLabel;
}


@end
