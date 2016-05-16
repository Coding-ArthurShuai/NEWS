//
//  YLWTopicItemModel.m
//  推库iOS
//
//  Created by Mac on 16/2/20.
//  Copyright © 2016年 YLW. All rights reserved.
//

#import "YLWTopicItemModel.h"
#import "YLWHttpTool.h"
@interface YLWTopicItemModel ()

@property (nonatomic,strong) NSArray *lastModels;

@end

@implementation YLWTopicItemModel

-(instancetype)initWithDictionary:(NSDictionary *)dic{

    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dic];
        
    }
    return self;

}

+(instancetype)topicItemModelWithDictionary:(NSDictionary *)dic{

    return [[self alloc]initWithDictionary:dic];
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{

    

}

+(void)topicItemModelWithURLstring:(NSString *)URLString lastArray:(NSArray *)lastArray successblock:(SuccessBlock)successBlock {

    
    [SVProgressHUD show];
    [YLWHttpTool getWithURLString:URLString parameter:nil progress:nil success:^(id responseObject) {
        
        NSLog(@"%@",responseObject);
        
        NSDictionary *responseObjectDic = (NSDictionary *)responseObject;
        NSArray *responseObjectArray = responseObjectDic[@"items"];
        NSMutableArray *num = [NSMutableArray array];
        
        for (NSDictionary *dic in responseObjectArray) {
            
            YLWTopicItemModel *model = [self topicItemModelWithDictionary:dic];
            
            [num addObject:model];
            
        }
        
        for (int i = 0; i < num.count; i ++) {
            YLWTopicItemModel *newModel = num[i];
            for (YLWTopicItemModel *lastModel in lastArray) {
                if (lastModel.id == newModel.id) {
                    
                    num[i] = lastModel;
                    
                }
                
            }
   
        }
        
        
        
        
        [self siteItemModelgetCountWithSiteModelArray:num completBlock:^(NSArray *itemArray) {
            
            for (NSDictionary *dic in itemArray) {
                
                for (YLWTopicItemModel *model in num) {
                    
                    
                    if (dic[@"id"] == model.id) {
                        
                        model.count = [NSString stringWithFormat:@"%@",dic[@"count"]];
                        
                        model.time = [NSString stringWithFormat:@"%@",dic[@"time"]];
                        
                        model.lang = [NSString stringWithFormat:@"%@",dic[@"lang"]];
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
        YLWTopicItemModel *model = siteModelArray[i];
        
        //        NSString *time = model.time == nil ? @"0" : model.time;
        NSString *time = @"0";
        //如果时间不存在就是0，如果存在并且被点击过就是model.time，如果存在但是没有被点击过就是0；
        if (model.time == nil) {
            time = @"0";
        }else{
            
            if (model.didSelected) {
                
                time = [NSString stringWithFormat:@"%@:%@",model.time,model.lang];
                
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
    
    NSLog(@"%@",valueString);
    NSDictionary *parameters = @{@"k":valueString};
    
    
    [YLWHttpTool postWithURLString:@"http://api.tuicool.com/api/topics/check_counts.json" parameter:parameters progress:nil success:^(id responseObject) {
        
        NSLog(@"%@",responseObject);
        
        NSDictionary *responseObjectDic = (NSDictionary *)responseObject;
        
        NSArray *responseObjectArray = responseObjectDic[@"items"];
        
        completBlock(responseObjectArray);
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
    }];
    
    
}


@end
