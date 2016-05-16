//
//  YLWDayNightTool.m
//  推库iOS
//
//  Created by Mac on 16/3/3.
//  Copyright © 2016年 YLW. All rights reserved.
//

#import "YLWDayNightTool.h"

@implementation YLWDayNightTool

+(instancetype)shareDayNightTool{
    static YLWDayNightTool *day;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        day = [[YLWDayNightTool alloc]init];
        
    });
    return day;
    
}

-(UIView *)setNavBgDayColor:(UIColor *)dayColor nightColor:(UIColor *)nightColor{

    

    return nil;
}



@end
