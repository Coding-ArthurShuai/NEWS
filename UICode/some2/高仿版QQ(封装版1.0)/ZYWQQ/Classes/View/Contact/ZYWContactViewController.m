//
//  ZYWContactViewController.m
//  ZYWQQ
//
//  Created by Devil on 16/2/22.
//  Copyright © 2016年 Devil. All rights reserved.
//

#import "ZYWContactViewController.h"
#import "MYDataViewController.h"

@interface ZYWContactViewController ()

@end

@implementation ZYWContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //搜索栏
    UISearchBar *sB=[[UISearchBar alloc]initWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width,44)];
    [sB setPlaceholder:@"搜索"];
    
    [self.view addSubview:sB];
    
    // Do any additional setup after loading the view.
    //   注册通知观察者
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(tiaozhuan) name:@"跳转2" object:nil];
    
}
-(void)dealloc
{
    // 移除通知观察者.
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    NSLog(@"移除跳转2通知对象");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//双层跳转
-(void)tiaozhuan{
    
    self.tabBarController.tabBar.hidden=YES;
    self.tabBarController.view.transform=CGAffineTransformIdentity;
    
    
    
    MYDataViewController *VC=[[MYDataViewController alloc]init];
    
    
    
    [self.navigationController pushViewController:VC animated:NO];
    
    
    UIBarButtonItem *backButton=[[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:@selector(backButton)];
    
    VC.navigationItem.leftBarButtonItem=backButton;
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
