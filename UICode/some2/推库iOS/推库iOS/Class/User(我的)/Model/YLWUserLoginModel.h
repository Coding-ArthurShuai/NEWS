//
//  YLWUserLoginModel.h
//  推库iOS
//
//  Created by Mac on 16/2/22.
//  Copyright © 2016年 YLW. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YLWUserMessageModel;
typedef void(^SuccessLogin)(NSString *resultString);
typedef void(^ErrorLogin)(NSError *error);
@interface YLWUserLoginModel : NSObject


@property (nonatomic,strong) YLWUserMessageModel *userInfoModel;

@property (nonatomic,copy) NSString *id;


@property (nonatomic,copy) NSString *name;

@property (nonatomic,copy) NSString *email;

@property (nonatomic,copy) NSString *token;
/**
 *  判断是否登录
 */
@property (nonatomic,assign) BOOL isLogin;

/**
 *  单例创建用户登录信息
 *
 *  @return 用户登录信息
 */
+(instancetype)sharedUserLoginModel;

-(void)getUserInfoWith:(NSDictionary *)loginMessageDic success:(SuccessLogin)successLogin error:(ErrorLogin)errorLogin;

@end
