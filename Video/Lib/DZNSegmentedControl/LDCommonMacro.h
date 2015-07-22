//
//  LDCommonMacro.h
//  commonLib
//
//  Created by aqua on 11/19/14.
//  Copyright (c) 2014 aqua. All rights reserved.
//

#ifndef commonLib_commonMacro_h
#define commonLib_commonMacro_h


/**
 *  判断一个对象是否为空
 *
 *  @param thing 对象
 *
 *  @return 返回结果
 */
static inline BOOL isObjectEmpty(id thing){
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
static inline BOOL isStringEmpty(NSString *string){
    
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
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    
    return NO;
}



#pragma mark-   iPhone常用屏幕尺寸


#define TABBAR_HEIGHT             49         //标签栏高度，不用于横屏模式
#define NAVBAR_HEIGHT     44        //竖屏导航栏高度
#define NAVBAR_VERTICAL_HEIGHT     32        //横屏导航栏高度

#define STATUSBAR_HEIGHT  20                 //状态栏高度


#pragma mark - 常用宏函数及声明

//设置字典key 判断为nil的情况
#define  setDicObject(dict, key, str)                      \
if (str!= nil)                                               \
[dict setObject: str forKey: key];                           \
else                                        \
printf("errDic....");

//添加数组数据 判断为nil的情况
#define  addArrayObject(array, object)                      \
if (object!= nil)                                               \
[array addObject: object];                           \
else                                        \
printf("errArray....");

#define CHECK_S(s) ((s != nil) ? s : @"")

//声明弱引用对象，常在blocks中使用
#define WEAKSELF typeof(self) __weak weakSelf = self;
//RGB颜色设置
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define COLOR_CM_BLUE       0x0085CF          //统一蓝色色值
//RGB颜色设置 16进制
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//由角度获取弧度 由弧度获取角度
#define degreesToRadian(x) (M_PI * (x) / 180.0)
#define radianToDegrees(radian) (radian*180.0)/(M_PI)

////获取当前语言
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0]) 

//是否是iPad
#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)


//读取本地图片
#define LOCAL_IMAGE(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:ext]]
#define LOCAL_PNG_IMAGE(file) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:@"png"]]

//设备屏幕高度
#ifndef UIScreenHeight
#define UIScreenHeight   [UIScreen mainScreen].bounds.size.height
#endif

//设备屏幕宽度
#ifndef UIScreenWidth
#define UIScreenWidth    [UIScreen mainScreen].bounds.size.width
#endif

#ifndef IOSVERSION
#define IOSVERSION       [[[UIDevice currentDevice] systemVersion] floatValue]
#endif

//程序全局委托
#ifndef APPLICATIONDELEGATE
#define APPLICATIONDELEGATE   (AppDelegate*)[[UIApplication sharedApplication] delegate]
#endif

//是否为iPhone6 plus
#ifndef iPhone6plus
#define iPhone6plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ?  \
CGSizeEqualToSize(CGSizeMake(1242 , 2208), [[UIScreen mainScreen] currentMode].size) : NO)
#endif

//是否为iPhone6
#ifndef iPhone6
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ?  \
CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#endif

//是否为iPhone5 5s
#ifndef iPhone5
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#endif

//是否为iPhone3 3gs  ipad
#ifndef iPhone3gs
#define iPhone3gs ([UIScreen instancesRespondToSelector:@selector(currentMode)] ?  \
CGSizeEqualToSize(CGSizeMake(320, 480), [[UIScreen mainScreen] currentMode].size) : NO)
#endif

//是否为iPhone4，4s
#ifndef iPhone4s
#define iPhone4s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ?  \
CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#endif

//是否为iPhone4、4s,3gs
#ifndef iPhone4
#define iPhone4 (UIScreenHeight==480)
#endif



//是否为ios8
#ifndef IS_IOS8
#define IS_IOS8            (IOSVERSION >= 8.0?YES:NO)
#endif


//是否为ios7
#ifndef IS_IOS7
#define IS_IOS7            (IOSVERSION >= 7.0 && [IOSVERSION < 8.0?YES:NO)
#endif

//是否为ios6
#ifndef IS_IOS6
#define IS_IOS6            (IOSVERSION < 7.0?YES:NO)
#endif

//如果为ios7以上，则返回20的冗余
#ifndef PADDING
#define PADDING            (IOSVERSION >= 7.0?20:0)
#endif

#define SCREENPROPORTION   (UIScreenWidth/320)
#define SCREENPROPORTION_NEW   UIScreenWidth/320

//区分真机和模拟器
//TARGET_OS_IPHONE  真机
//TARGET_IPHONE_SIMULATOR  模拟器

//区分是否为ARC
//#if __has_feature(objc_arc)



#endif
