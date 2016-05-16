//
//  YLWUserMessageModel.h
//  推库iOS
//
//  Created by Mac on 16/2/21.
//  Copyright © 2016年 YLW. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SuccessLoginblock)();
typedef void(^ErrorLogin)(NSError *error);
@interface YLWUserMessageModel : NSObject<NSCoding>

@property (nonatomic,copy) NSString *id;

@property (nonatomic,copy) NSString *email;

@property (nonatomic,copy) NSString *name;

@property (nonatomic,copy) NSString *ctime;

@property (nonatomic,copy) NSString *uid;

@property (nonatomic,copy) NSString *profile;

@property (nonatomic,copy) NSString *token;

@property (nonatomic,copy) NSString *weibo_id;

@property (nonatomic,copy) NSString *weibo_name;

@property (nonatomic,copy) NSString *qq_id;

@property (nonatomic,copy) NSString *qq_name;

@property (nonatomic,copy) NSString *weixin_name;

@property (nonatomic,copy) NSString *flyme_name;

-(instancetype)initWithDictionary:(NSDictionary *)dic;

+(instancetype)userMessageModelWithDictionary:(NSDictionary *)dic;

//暂存
+(void)userMessageModelToLoginWith:(NSDictionary *)nameAndPassword success:(SuccessLoginblock)successLogin error:(ErrorLogin)errorLogin;
/**
 *  归档保存用户数据
 */
-(void)saveUserInfo;
/**
 *  归档读取用户数据
 *
 *  @return 用户的数据模型
 */
+(instancetype)readUserInfo;

@end
