//
//  HRNavController.m
//  HR_W仿QQ界面
//
//  Created by admin on 16/4/19.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "HRNavController.h"

@implementation HRNavController

+ (void)initialize{
    
    UINavigationBar *navBar = [UINavigationBar appearance];
    
    [navBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    navBar.backgroundColor = [UIColor blueColor];
}

@end
