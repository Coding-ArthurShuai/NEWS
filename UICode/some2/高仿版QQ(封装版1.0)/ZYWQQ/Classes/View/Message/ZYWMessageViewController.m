//
//  ZYWMessageViewController.m
//  ZYWQQ
//
//  Created by Devil on 16/2/22.
//  Copyright © 2016年 Devil. All rights reserved.
//

#import "ZYWMessageViewController.h"
#import "MYDataViewController.h"
#import "UIView+SHCZExt.h"

@interface ZYWMessageViewController ()

@end

@implementation ZYWMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setSubViews];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(tiaozhuan) name:@"跳转1" object:nil];
}
-(void)dealloc
{
    // 移除通知观察者.
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    NSLog(@"移除跳转1通知对象");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//设置基本控件
-(void)setSubViews{
    self.navigationItem.title=@"消息";
    //    分段控件
    UISegmentedControl *segmentC=[[UISegmentedControl alloc]initWithItems:@[@"消息",@"电话"]];
    segmentC.w=120;
    segmentC.selectedSegmentIndex=0;
   
    segmentC.tintColor=[UIColor colorWithRed:13/255.0 green:184/255.0 blue:246/255.0 alpha:1];
    
    self.navigationItem.titleView=segmentC;
    //搜索栏
    UISearchBar *sB=[[UISearchBar alloc]initWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width,44)];
    [sB setPlaceholder:@"搜索"];
    
    [self.view addSubview:sB];
    
}

//双层跳转
-(void)tiaozhuan{
    
    
    
    self.tabBarController.tabBar.hidden=YES;
    
    self.tabBarController.view.transform=CGAffineTransformIdentity;
    
    
    
    MYDataViewController *VC=[[MYDataViewController alloc]init];
    
    
    
    [self.navigationController pushViewController:VC animated:NO];
    
    
    
    
    UIBarButtonItem *backButton=[[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:@selector(backButton)];
    
    
    
    VC.navigationItem.leftBarButtonItem=backButton;
    self.tabBarController.view.transform=CGAffineTransformIdentity;
}

-(void)backButton{
    
    
    
    //    先让tabbar返回原来的位置
    self.tabBarController.view.transform=CGAffineTransformTranslate([[UIApplication sharedApplication].delegate window].transform,[UIScreen mainScreen].bounds.size.width*0.75, 0);
    
    self.tabBarController.tabBar.hidden=NO;
    
    
    
    //    再返回消息控制器
    [self.navigationController popViewControllerAnimated:NO];
    
    
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
