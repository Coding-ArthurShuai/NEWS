//
//  YLWUserGroupModel.h
//  推库iOS
//
//  Created by Mac on 16/2/21.
//  Copyright © 2016年 YLW. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface YLWUserGroupModel : NSObject

@property (nonatomic,strong) NSArray *itemModelArray;

+(instancetype)userGroupModelWithModelArray:(NSArray *)itemModelArray;

@end
