//
//  UIImage+Extension.h
//  01-QQ聊天布局
//
//  Created by apple on 14-4-2.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface NSString (Extension)
/**
 *  动态算出字符串的size
 */
- (CGSize)sizeWithFont:(UIFont *)font constrainedWithWidth:(CGFloat)width;
/**
 *  判断对象是否为空。不为空返回1
 *  包括 nil、NULL、@“”、空数组
 */
+ (BOOL)isNotNull:(id)object;




@end
/**
 *  判断一个对象是否为空
 *
 *  @param thing 对象
 *
 *  @return 返回结果
 */
static inline BOOL IsObjectEmpty(id thing){
    return thing == nil ||
    ([thing isEqual:[NSNull null]]) ||
    ([thing respondsToSelector:@selector(length)] && [(NSData *)thing length] == 0) ||
    ([thing respondsToSelector:@selector(count)]  && [(NSArray *)thing count] == 0);
}
/**
 *  判断一个字符串是否为空
 *
 *  @param string 字符串
 *
 *  @return 返回结果
 */
static inline BOOL IsStringEmpty(NSString *string){
    
    if (string == nil || string == NULL) {
        return YES;
    }
    
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    if ([string isEqualToString:@"<null>"]) {
        return YES;
    }
    
    if ([string isEqualToString:@"(null)"]) {
        return YES;
    }
    
    if ([string isEqualToString:@"null"]) {
        return YES;
    }
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    
    return NO;
}