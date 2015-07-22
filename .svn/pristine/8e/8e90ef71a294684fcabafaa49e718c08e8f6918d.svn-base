//
//  BaseAFAPI.h
//  hm-ios
//
//  Created by humin on 14-6-16.
//  Copyright (c) 2014年 humin. All rights reserved.
//
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, AFRequestMethod) {
    AFRequestMethodGET,
    AFRequestMethodPOST,
    AFRequestMethodPUT,
    AFRequestMethodDELETE
};

#define kJysdHost @"http://www.jysd.com/api4"

typedef void (^RequestCompletionBlock)(BOOL success, id object);

@interface BaseAFAPI : NSObject

- (void)requestJSONWithUrl:(NSString *)url param:(NSDictionary *)param method:(AFRequestMethod)method completion:(RequestCompletionBlock)completion;

@end
