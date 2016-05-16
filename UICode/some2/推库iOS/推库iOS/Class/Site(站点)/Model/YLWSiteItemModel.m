//
//  YLWSiteItemModel.m
//  推库iOS
//
//  Created by Mac on 16/2/18.
//  Copyright © 2016年 YLW. All rights reserved.
//

#import "YLWSiteItemModel.h"
#import <AFNetworking.h>
#import "YLWHttpTool.h"

@implementation YLWSiteItemModel

-(instancetype)initWithDictionary:(NSDictionary *)dic{

    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }

    return self;
}

+(instancetype)siteItemModelWithDictionary:(NSDictionary *)dic{

    return [[self alloc]initWithDictionary:dic];
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{

}

+(void)siteItemModelWithURLstring:(NSString *)URLString  lastArray:(NSArray *)lastArray successblock:(SuccessBlock)successBlock{

    [SVProgressHUD show];
    
    [YLWHttpTool getWithURLString:URLString parameter:nil progress:nil success:^(id responseObject) {
        
        NSLog(@"%@",responseObject);
        
        NSDictionary *responseObjectDic = (NSDictionary *)responseObject;
        NSArray *responseObjectArray = responseObjectDic[@"items"];
        NSMutableArray *num = [NSMutableArray array];
        
        for (NSDictionary *dic in responseObjectArray) {
            
            YLWSiteItemModel *model = [self siteItemModelWithDictionary:dic];
            
            [num addObject:model];
            
        }
        
        for (int i = 0; i < num.count; i ++) {
            YLWSiteItemModel *newModel = num[i];
            for (YLWSiteItemModel *lastModel in lastArray) {
                if ([lastModel.id isEqualToString:newModel.id]) {
                    
                    num[i] = lastModel;
                    
                }
                
            }
            
        }
        
        
        [self siteItemModelgetCountWithSiteModelArray:num completBlock:^(NSArray *itemArray) {
            
            for (NSDictionary *dic in itemArray) {
                
                for (YLWSiteItemModel *model in num) {
                    
                    if ([dic[@"id"] isEqualToString:model.id]) {
                        
                        model.count = [NSString stringWithFormat:@"%@",dic[@"count"]];
                        
                        model.time = [NSString stringWithFormat:@"%@",dic[@"time"]];
                        
                        break;
                    }
                    
                }
                
                
            }
            
            successBlock(num);
            [SVProgressHUD dismiss];
        }];

    } failure:^(NSError *error) {
       
        [SVProgressHUD showImage:[UIImage imageNamed:@"fail_result"] status:@"加载失败"];
        NSLog(@"%@",error);
        
    }];
    
    
}

+(void)siteItemModelgetCountWithSiteModelArray:(NSArray *)siteModelArray completBlock:(SuccessBlock)completBlock{

    NSString *valueString = [[NSString alloc]init];
    
    for (int i = 0; i < siteModelArray.count; i ++) {
        YLWSiteItemModel *model = siteModelArray[i];
        
//        NSString *time = model.time == nil ? @"0" : model.time;
        NSString *time = @"0";
        //如果时间不存在就是0，如果存在并且被点击过就是model.time，如果存在但是没有被点击过就是0；
        if (model.time == nil) {
            time = @"0";
        }else{
        
            if (model.didSelected) {
                
                time = model.time;
                
            }else{
            
                time = @"0";
            
            }
            
        }
        
        if (i == siteModelArray.count-1) {
            NSLog(@"%@",valueString);
         valueString = [valueString stringByAppendingFormat:@"%@:%@",model.id,time];
            
        }else{
        
            valueString = [valueString stringByAppendingFormat:@"%@:%@,",model.id,time];
        
        }
        
    }
    
    NSDictionary *parameters = @{@"k":valueString};
    NSLog(@"%@",valueString);
    
    [YLWHttpTool postWithURLString:@"http://api.tuicool.com/api/sites/do_check_counts.json" parameter:parameters progress:nil success:^(id responseObject) {
        
        NSLog(@"%@",responseObject);
        
        NSDictionary *responseObjectDic = (NSDictionary *)responseObject;
        
        NSArray *responseObjectArray = responseObjectDic[@"items"];
        
        completBlock(responseObjectArray);
        
    } failure:^(NSError *error) {
       
         NSLog(@"%@",error);
    }];
    

}



@end
