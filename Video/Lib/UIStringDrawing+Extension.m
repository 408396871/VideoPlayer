//
//  UIImage+Extension.m
//  
//
//  Created by apple on 14-4-2.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "UIStringDrawing+Extension.h"

@implementation NSString (Extension)
/**
 *
 */
- (CGSize)sizeWithFont:(UIFont *)font constrainedWithWidth:(CGFloat)width
{
    NSAttributedString *attributedText =
    [[NSAttributedString alloc]
     initWithString:self
     attributes:@
     {
     NSFontAttributeName: font
     }];
    CGRect rect = [attributedText boundingRectWithSize:(CGSize){width, CGFLOAT_MAX}
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    return rect.size;
}


+ (BOOL)isNotNull:(id)object
{
    // 对应返回的数组   "data":,
    if (object) {
        // 有值就继续向下判断
    }else{
        return 0;
    }
    
    if (object == nil) {
        return 0;
    }
    
    if ([object isKindOfClass:[NSNull class]]) {
        return 0;
    }
    if ([object isKindOfClass:[NSString class]]) {
        if ([object isEqualToString:@""]) {
            return 0;
        }
        if ([object length] == 0 ) {
            return 0;
        }
    }
    // 对应返回的数组   "data":[]
    if ([object isKindOfClass:[NSArray class]]) {
        if ([object isEqualToArray:@[]]) {
            return 0;
        }
    }
    if ([object isKindOfClass:[NSDictionary class]]) {
        
        if ([object isEqualToDictionary:@{}]) {
            return 0;
        }
    }
    
    
    return 1;
}




@end
