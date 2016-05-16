//
//  ZYWMainViewController.m
//  ZYWQQ
//
//  Created by Devil on 16/2/22.
//  Copyright © 2016年 Devil. All rights reserved.
//

#import "ZYWMainViewController.h"
#import "ZYWMessageViewController.h"
#import "ZYWContactViewController.h"
#import "ZYWDynamicViewController.h"

@interface ZYWMainViewController ()

@end

@implementation ZYWMainViewController

-(NSString *)name{
    if (!_name) {
        _name=@"消息";
    }
    return _name;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addChildViewControllers];
    
//    [self setupTabbar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)addChildViewControllers{
    
    [self addChildViewController:[[ZYWMessageViewController alloc]init] andTitle:@"消息" andImageName:@"tab_buddy_"];
    [self addChildViewController:[[ZYWContactViewController alloc]init] andTitle:@"联系人" andImageName:@"tab_qworld_"];
    [self addChildViewController:[[ZYWDynamicViewController alloc]init] andTitle:@"动态" andImageName:@"tab_recent_"];
    
    
}

-(void)addChildViewController:(UIViewController *)VC andTitle:(NSString *)title andImageName:(NSString *)imageName{
    
    VC.title=title;
    VC.tabBarItem.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@nor",imageName]];
    
    VC.tabBarItem.selectedImage=[UIImage imageNamed:[NSString stringWithFormat:@"%@press",imageName]];
    
    self.tabBar.tintColor=[UIColor colorWithRed:13/255.0 green:184/255.0 blue:246/255.0 alpha:1];
    
    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:VC];
    
    
    [self addChildViewController:nav];
    
}
-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    
    if ([item.title isEqualToString:@"消息"]) {
        self.name=@"跳转1";
        
        
    }else if ([item.title isEqualToString:@"联系人"]){
        
        self.name=@"跳转2";
    } else{
        
        self.name=@"跳转3";
    }
    //    发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"主传左" object:self.name];
    
}



@end
