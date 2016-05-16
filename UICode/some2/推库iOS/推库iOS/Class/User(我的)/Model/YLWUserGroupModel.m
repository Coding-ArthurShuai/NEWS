//
//  YLWUserGroupModel.m
//  推库iOS
//
//  Created by Mac on 16/2/21.
//  Copyright © 2016年 YLW. All rights reserved.
//

#import "YLWUserGroupModel.h"


@implementation YLWUserGroupModel

+(instancetype)userGroupModelWithModelArray:(NSArray *)itemModelArray{

    YLWUserGroupModel *group = [[YLWUserGroupModel alloc]init];
    
    group.itemModelArray = itemModelArray;
    
    return group;

}

@end
