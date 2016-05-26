//
//  GHPNetWorking.m
//  GHPNetWorkingDemo
//
//  Created by jzl on 16/5/24.
//  Copyright © 2016年 jiaozhenlong. All rights reserved.
//

#import "GHPNetWorking.h"
#import "MBProgressHUD+BWMExtension.h"


#define BASE_URL  @"https://itunes.apple.com"

@implementation GHPNetWorking

+ (instancetype)sharedManager {
    static GHPNetWorking *manager = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        manager = [[self alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL]];
    });
    return manager;
}
-(instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (self) {
        // 请求超时设定
        self.requestSerializer.timeoutInterval = 30;
        self.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData; //缓存策略：忽略缓存，直接请求服务器
        [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [self.requestSerializer setValue:url.absoluteString forHTTPHeaderField:@"Referer"];//告诉服务器从哪个页面来，用于统计
        
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", nil];
        self.securityPolicy.allowInvalidCertificates = NO;
    }
    return self;
}

- (void)requestWithMethod:(HTTPMethod)method
                 WithPath:(NSString *)path
               WithParams:(NSDictionary*)params
         WithSuccessBlock:(requestSuccessBlock)success
          WithFailurBlock:(requestFailureBlock)failure delegate:(UIView *)view
{
    MBProgressHUD *HUD;
    if (view) {
        HUD = [MBProgressHUD bwm_showHUDAddedTo:view title:@"正在加载..." animated:YES];
    }
    
    switch (method) {
        case GET:{
            
            [self GET:path parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
                success(responseObject);
                [HUD bwm_hideWithTitle:@"加载完成！" hideAfter:2 msgType:BWMMBProgressHUDMsgTypeSuccessful];
            } failure:^(NSURLSessionTask *operation, NSError *error) {
                failure(error);
                [HUD bwm_hideWithTitle:@"失败！" hideAfter:2 msgType:BWMMBProgressHUDMsgTypeError];
            }];
            break;
        }
        case POST:{
            [self POST:path parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
                success(responseObject);
                [HUD bwm_hideWithTitle:@"加载完成！" hideAfter:2 msgType:BWMMBProgressHUDMsgTypeSuccessful];
            } failure:^(NSURLSessionTask *operation, NSError *error) {
                NSLog(@"%@",error.localizedDescription);
                failure(error);
                [HUD bwm_hideWithTitle:@"失败！" hideAfter:2 msgType:BWMMBProgressHUDMsgTypeError];
            }];
            break;
        }
        default:
            break;
    }
}
@end
