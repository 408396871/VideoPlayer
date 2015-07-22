//
//  NetReachableTool.m
//  ECarService
//
//  Created by 123 on 15-3-23.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "NetReachableTool.h"
//#import "MBProgressHUD+MJ.h"
#import "AFNetworkReachabilityManager.h"
@implementation NetReachableTool
+ (void)isNetReachable
{
    
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    [MBProgressHUD showError:@"请链接网络"];
                });
                break;
                case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"wifi");
                break;
                
                case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"AFNetworkReachabilityStatusReachableViaWWAN");
                break;
                
            default:
                break;
        }
    }];
    [mgr startMonitoring];
}
@end
