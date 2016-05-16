//
//  SXTNavigationController.m
//  02-tabBar重构
//
//  Created by andezhou on 16/2/19.
//  Copyright (c) 2016年 周安德. All rights reserved.
//

#import "SXTNavigationController.h"

@interface SXTNavigationController ()

@end

@implementation SXTNavigationController

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count) {
        // 隐藏tabTar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
