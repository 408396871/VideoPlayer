//
//  BaseAFAPI.m
//  hm-ios
//
//  Created by humin on 14-6-16.
//  Copyright (c) 2014年 humin. All rights reserved.
//

#import "BaseAFAPI.h"
#import "AFNetworking.h"

typedef void (^AFResponseSuccess)(AFHTTPRequestOperation *operation, id responseObject);
typedef void (^AFResponseFailed)(AFHTTPRequestOperation *operation, NSError *error);

@implementation BaseAFAPI

- (void)requestJSONWithUrl:(NSString *)url param:(NSDictionary *)param method:(AFRequestMethod)method completion:(RequestCompletionBlock)completion
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    AFResponseSuccess successBlock = ^(AFHTTPRequestOperation *o, id responseObject){
        completion(YES, responseObject);
    };
    AFResponseFailed failedBlock = ^(AFHTTPRequestOperation *o, NSError *error) {
        completion(NO, nil);
    };
    switch (method) {
        case AFRequestMethodGET:
        {
            [manager GET:url parameters:param success:successBlock failure:failedBlock];
        }
            break;
        case AFRequestMethodPOST:
        {
            [manager POST:url parameters:param success:successBlock failure:failedBlock];
        }
            break;
        case AFRequestMethodPUT:
        {
            [manager PUT:url parameters:param success:successBlock failure:failedBlock];
        }
            break;
        default:
        {
            [manager DELETE:url parameters:param success:successBlock failure:failedBlock];
        }
            break;
    }
}

@end
