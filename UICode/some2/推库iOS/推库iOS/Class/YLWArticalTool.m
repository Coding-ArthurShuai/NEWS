//
//  YLWArticalTool.m
//  推库iOS
//
//  Created by Mac on 16/2/29.
//  Copyright © 2016年 YLW. All rights reserved.
//

#import "YLWArticalTool.h"
#import "YLWArticleModel.h"
static FMDatabase *_db;
@implementation YLWArticalTool

+ (void)initialize{

    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"homeData.db"];
    
    //创建数据库
    _db = [FMDatabase databaseWithPath:filePath];
    
    [_db open];
    
    if (![_db open]) {
        return;
    }
    
    [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_artical_deal(id integer PRIMARY KEY, deal blob NOT NULL, deal_id text NOT NULL);"];
}

+ (void)addArticalWithModel:(YLWArticleModel *)model{

    //归档
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];

    [_db executeUpdateWithFormat:@"INSERT INTO t_artical_deal(deal,deal_id) VALUES(%@,%@);",data,model.id];

}

+ (void)addArticalWithArray:(NSArray *)modelArray{

    
    [_db executeUpdate:@"DELETE FROM t_artical_deal;"];
    
    for (YLWArticleModel *model in modelArray) {
        
        [self addArticalWithModel:model];
        
    }
    

}

+(void)deleteArticalWithModel:(YLWArticleModel *)model{

    [_db executeUpdateWithFormat:@"DELETE FROM t_artical_deal WHERE deal_id=%@", model.id];

}

+ (NSArray *)Articalsback
{

    
    FMResultSet *set = [_db executeQuery:@"SELECT * FROM t_artical_deal;"];
    
    //3. 获取数据 --> 获取模型的二进制数据  --> 还原成模型 --> 并且添加到数组中返回
    NSMutableArray *tempArray = [NSMutableArray array];
    
    while ([set next]) {
        NSData *data = [set objectForColumnName:@"deal"];
        YLWArticleModel *dealModel = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        [tempArray addObject:dealModel];
        
    }
    return tempArray;
}


@end
