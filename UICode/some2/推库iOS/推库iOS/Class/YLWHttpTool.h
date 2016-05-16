//
//  YLWHttpTool.h
//  推库iOS
//
//  Created by Mac on 16/2/20.
//  Copyright © 2016年 YLW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YLWHttpTool : NSObject

+(void)getWithURLString:(NSString *)URLString parameter:(NSDictionary *)parameter progress:(void(^)(NSProgress *progress))progress success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

+(void)postWithURLString:(NSString *)URLString parameter:(NSDictionary *)parameter progress:(void(^)(NSProgress *progress))progress success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

@end
