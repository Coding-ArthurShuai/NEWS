//
//  YLWUserItemModel.h
//  推库iOS
//
//  Created by Mac on 16/2/21.
//  Copyright © 2016年 YLW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YLWUserItemModel : NSObject

@property (nonatomic,copy) NSString *name;

@property (nonatomic,copy) NSString *urlstring;

@property (nonatomic,copy) NSString *icon;

@property (nonatomic,assign) BOOL swich;
+(instancetype)userItemModelWithName:(NSString *)name;

+(instancetype)userItemModelWithName:(NSString *)name urlstring:(NSString *)urlstring;

+(instancetype)userItemModelWithName:(NSString *)name icon:(NSString *)icon;

+(instancetype)userItemModelWithName:(NSString *)name swich:(BOOL)swich;

@end
