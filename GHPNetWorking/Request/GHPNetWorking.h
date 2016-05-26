//
//  GHPNetWorking.h
//  GHPNetWorkingDemo
//
//  Created by jzl on 16/5/24.
//  Copyright © 2016年 jiaozhenlong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AFHTTPSessionManager.h"

typedef void (^requestSuccessBlock)(id responseObject);

//请求失败回调block
typedef void (^requestFailureBlock)(NSError *error);

//请求方法define
typedef enum {
    GET,
    POST,
    PUT,
    DELETE,
    HEAD
} HTTPMethod;

@interface GHPNetWorking : AFHTTPSessionManager

+ (instancetype)sharedManager;
- (void)requestWithMethod:(HTTPMethod)method
                 WithPath:(NSString *)path
               WithParams:(NSDictionary*)params
         WithSuccessBlock:(requestSuccessBlock)success
          WithFailurBlock:(requestFailureBlock)failure delegate:(UIView* )view;

@end
