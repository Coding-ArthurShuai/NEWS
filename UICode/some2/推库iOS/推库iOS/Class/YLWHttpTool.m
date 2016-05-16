//
//  YLWHttpTool.m
//  推库iOS
//
//  Created by Mac on 16/2/20.
//  Copyright © 2016年 YLW. All rights reserved.
//

#import "YLWHttpTool.h"
#import <AFNetworking.h>


@implementation YLWHttpTool


+(void)getWithURLString:(NSString *)URLString parameter:(NSDictionary *)parameter progress:(void(^)(NSProgress *progress))progress success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{

    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    NSString *userAgent = [NSString stringWithFormat:@"iOS/%@/2.15.0",[[UIDevice currentDevice] name]];
    
    [manager.requestSerializer setValue:userAgent forHTTPHeaderField:@"User-Agent"];
    YLWUserLoginModel *loginModel = [YLWUserLoginModel sharedUserLoginModel];
    if ([YLWUserLoginModel sharedUserLoginModel].isLogin) {
        
        [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:loginModel.id    password:loginModel.token];
    }else{
    
        [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:@"0.0.0.0" password:@"tuicool"];
    
    }
    
    
    [manager GET:URLString parameters:parameter progress:^(NSProgress * _Nonnull downloadProgress) {
        
        if (progress) {
            progress(downloadProgress);
        }
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    
}

+(void)postWithURLString:(NSString *)URLString parameter:(NSDictionary *)parameter progress:(void(^)(NSProgress *progress))progress success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{

    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    NSString *userAgent = [NSString stringWithFormat:@"iOS/%@/2.15.0",[[UIDevice currentDevice] name]];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager.requestSerializer setValue:userAgent forHTTPHeaderField:@"User-Agent"];
    
    [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:@"0.0.0.0" password:@"tuicool"];
    
    [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    
    
    [manager POST:URLString parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    
    
    

    
}


@end
