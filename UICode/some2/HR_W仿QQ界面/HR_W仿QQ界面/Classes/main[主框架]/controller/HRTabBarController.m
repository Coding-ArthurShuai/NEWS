//
//  HRTabBarController.m
//  HR_W仿QQ界面
//
//  Created by admin on 16/4/19.
//  Copyright © 2016年 admin. All rights reserved.
//



#import "HRTabBarController.h"
#import "HRMessageController.h"
#import "HRDynamicController.h"
#import "HRContactController.h"
#import "HRNavController.h"


@implementation HRTabBarController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self setNavigationController];
}

- (void)setNavigationController{
    
    HRNavController *nav1 = [[HRNavController alloc] initWithRootViewController:[[HRMessageController alloc] init]];
    nav1.tabBarItem.title = @"消息";
    nav1.tabBarItem.image = [UIImage imageNamed:@"right_menu_multichat"];
    
    HRNavController *nav2 = [[HRNavController alloc] initWithRootViewController:[[HRContactController alloc] init]];
    nav2.tabBarItem.title = @"联系人";
    nav2.tabBarItem.image = [UIImage imageNamed:@"right_menu_addFri"];
    
    HRNavController *nav3 = [[HRNavController alloc] initWithRootViewController:[[HRDynamicController alloc] init]];
    nav3.tabBarItem.title = @"动态";
    nav3.tabBarItem.image = [UIImage imageNamed:@"right_menu_facetoface"];
    
    self.viewControllers = @[nav1,nav2,nav3];
}
@end
