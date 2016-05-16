//
//  SXTTabBarController.m
//  新浪作业
//
//  Created by ma c on 16/2/19.
//  Copyright © 2016年 SXT. All rights reserved.
//

#import "SXTTabBarController.h"
#import "SXTTabBar.h"
#import "SXTNavigationController.h"

@interface SXTTabBarController ()<SXTTabBarDelegate>

@property (strong, nonatomic) SXTTabBar *tabBarView;

@end

@implementation SXTTabBarController

#pragma mark -
#pragma mark init methods
- (SXTTabBar *)tabBarView
{
    _tabBarView = [[SXTTabBar alloc] initWithFrame:self.tabBar.bounds];
    _tabBarView.delegate = self;
    return  _tabBarView;
}

#pragma mark -
#pragma mark SXTTabBarDelegate
- (void)tabBar:(SXTTabBar *)tabBar selectedIndex:(NSUInteger)index
{
    // 切换控制器
    self.selectedIndex = index;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置控制器
    [self addViewControllers];
    
    // 遍历tabBar上面的所有子视图并全部移除
    [self.tabBar.subviews enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        [obj removeFromSuperview];
    }];
    
    // 添加自定义的tabBarView
    [self.tabBar addSubview:self.tabBarView];
    
    
}

- (void)addViewControllers
{
    // 1.获取plist文件中的数据
    NSString *file = [[NSBundle mainBundle] pathForResource:@"TabBarPlist" ofType:@"plist"];
    NSArray *data = [NSArray arrayWithContentsOfFile:file];
    
    // 2.遍历数组，初始化控制器
    NSMutableArray *mutArr = [NSMutableArray array];
    
    for (NSDictionary *dict in data) {
        // 2.1把字符串转化为class
        Class class = NSClassFromString(dict[@"controller"]);
        // 2.2初始化对应的控制器
        UIViewController *viewVC = [[class alloc] init];
        viewVC.title = dict[@"title"];
        SXTNavigationController *nav = [[SXTNavigationController alloc] initWithRootViewController:viewVC];
        [mutArr addObject:nav];
    }
    
    // 3.添加进入viewControllers中
    self.viewControllers = mutArr;
    
}





@end
