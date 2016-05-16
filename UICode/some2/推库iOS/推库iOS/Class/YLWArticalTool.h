//
//  YLWArticalTool.h
//  推库iOS
//
//  Created by Mac on 16/2/29.
//  Copyright © 2016年 YLW. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YLWArticleModel;
@interface YLWArticalTool : NSObject

/**
 *  删除一个模型
 *
 *  @param model
 */
+(void)deleteArticalWithModel:(YLWArticleModel *)model;
/**
 *  添加一个模型
 *
 *  @param model
 */
+ (void)addArticalWithModel:(YLWArticleModel *)model;
/**
 *  添加一组数据
 *
 *  @param modelArray
 */
+ (void)addArticalWithArray:(NSArray *)modelArray;
/**
 *  获取全部数据
 *
 *  @return 数据
 */
+ (NSArray *)Articalsback;

@end
