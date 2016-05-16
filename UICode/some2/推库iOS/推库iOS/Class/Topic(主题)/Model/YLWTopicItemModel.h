//
//  YLWTopicItemModel.h
//  推库iOS
//
//  Created by Mac on 16/2/20.
//  Copyright © 2016年 YLW. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SuccessBlock)(NSArray *itemArray);
typedef void(^CompletBlock)(NSArray *itemArray ,SuccessBlock *successBlock);
@interface YLWTopicItemModel : NSObject
/*
 id": 10000024,
 "name": "\u521b\u4e1a",
 "image": "http://ttimg0.tuicool.com/10000024.png",
 "followed": false
 
 "id": 10000024,
 "time": 1455976120658,
 "count": 30,
 "lang": 1
 */

@property (nonatomic,copy) NSString *id;

@property (nonatomic,copy) NSString *name;

@property (nonatomic,copy) NSString *image;

@property (nonatomic,copy) NSString *followed;

@property (nonatomic,copy) NSString *time;

@property (nonatomic,copy) NSString *count;

@property (nonatomic,copy) NSString *lang;

@property (nonatomic,assign) BOOL didSelected;

-(instancetype)initWithDictionary:(NSDictionary *)dic;

+(instancetype)topicItemModelWithDictionary:(NSDictionary *)dic;

+(void)topicItemModelWithURLstring:(NSString *)URLString lastArray:(NSArray *)lastArray successblock:(SuccessBlock)successBlock;

@end
