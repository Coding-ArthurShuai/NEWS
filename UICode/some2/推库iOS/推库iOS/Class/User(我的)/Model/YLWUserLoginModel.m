//
//  YLWUserLoginModel.m
//  推库iOS
//
//  Created by Mac on 16/2/22.
//  Copyright © 2016年 YLW. All rights reserved.
//

#import "YLWUserLoginModel.h"
#import "YLWHttpTool.h"
#import "YLWUserMessageModel.h"
@implementation YLWUserLoginModel

/**
 *  创建单例
 *
 *  @return 登录模型
 */
+(instancetype)sharedUserLoginModel{

    static YLWUserLoginModel *instance;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        instance = [[YLWUserLoginModel alloc]init];
        
    });
    return instance;
    
}

-(instancetype)init{

    if (self = [super init]) {
        self.userInfoModel = [YLWUserMessageModel readUserInfo];
    }
    return self;
}

-(NSString *)name{

    return self.userInfoModel.name;

}

-(NSString *)email{

    return self.userInfoModel.email;
}

-(NSString *)token{
    
    return self.userInfoModel.token;
    
}

-(NSString *)id{

    return self.userInfoModel.id;
}

-(BOOL)isLogin{

    return self.token == nil ? NO : YES;
}

-(void)getUserInfoWith:(NSDictionary *)loginMessageDic  success:(SuccessLogin)successLogin error:(ErrorLogin)errorLogin{

    
    [YLWHttpTool postWithURLString:@"http://api.tuicool.com/api/login.json" parameter:loginMessageDic progress:nil success:^(id responseObject) {
        
        NSDictionary *responseObjectDic = (NSDictionary *)responseObject;
        
        if (responseObjectDic[@"success"]) {
            
            NSDictionary *userDic = responseObjectDic[@"user"];
            
            YLWUserMessageModel *model = [YLWUserMessageModel userMessageModelWithDictionary:userDic];
            
            self.userInfoModel = model;
            //归档保存
            [model saveUserInfo];
            
            successLogin(@"success");
            
        }else{
        
            NSLog(@"%@",responseObjectDic[@"error"]);
            
            successLogin(responseObjectDic[@"error"]);
            
        }
        
        
        
    } failure:^(NSError *error) {
        
        errorLogin(error);
        
    }];
    

}

@end
