//
//  YLWTabBarController.m
//  推库iOS
//
//  Created by Mac on 16/2/17.
//  Copyright © 2016年 YLW. All rights reserved.
//

#import "YLWTabBarController.h"
#import "YLWHomeViewController.h"
#import "YLWSiteViewController.h"
#import "YLWTopicViewController.h"
#import "YLWWeeklyViewController.h"
#import "YLWUserViewController.h"

@interface YLWTabBarController ()

@end

@implementation YLWTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    [self addChildViewControllers];
    
    
    
}

-(void)addChildViewControllers{

    YLWHomeViewController *homeVc = [[YLWHomeViewController alloc]init];
    [self addChildViewController:homeVc WithTitle:@"文章" image:@"tab_home"];
    
    YLWSiteViewController *site = [[YLWSiteViewController alloc]init];
    [self addChildViewController:site WithTitle:@"站点" image:@"tab_site"];
    
    YLWTopicViewController *topic = [[YLWTopicViewController alloc]init];
    [self addChildViewController:topic WithTitle:@"主题" image:@"tab_topic"];
    
    YLWWeeklyViewController *weekly = [[YLWWeeklyViewController alloc]init];
    [self addChildViewController:weekly WithTitle:@"周刊" image:@"tab_dis"];
    
    YLWUserViewController *user = [[YLWUserViewController alloc]init];
    [self addChildViewController:user WithTitle:@"我的" image:@"tab_user"];


}


-(void)addChildViewController:(UIViewController *)childController WithTitle:(NSString *)title image:(NSString *)imageName{
    
    childController.tabBarItem.image = [UIImage imageNamed:imageName];
    
    childController.title = title;
    
    
    YLWNavigationController *nav = [[YLWNavigationController alloc]initWithRootViewController:childController];
//    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:childController];
//
//    [nav.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
//
//    nav.navigationBar.barTintColor = [UIColor colorWithRed:22.0/255.0 green:147.0/255.0 blue:114.0/255.0 alpha:1.0];
    
    
    
    [self addChildViewController:nav];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
