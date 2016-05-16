//
//  YLWSearchViewController.m
//  推库iOS
//
//  Created by Mac on 16/3/3.
//  Copyright © 2016年 YLW. All rights reserved.
//

#import "YLWSearchViewController.h"

@interface YLWSearchViewController ()

@end


@implementation YLWSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleModelArray = [YLWTitleModel titleModelGetModelArrayWith:@"search.plist"];
    
    [self setUI];
    
    [self setNav];
    
}

-(void)setNav{

    UISearchBar *search = [[UISearchBar alloc]init];
    search.placeholder = @"请输入搜索";
    self.navigationItem.titleView = search;
    
    UIBarButtonItem *back = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(backBtnClick)];
    
    
    self.navigationItem.leftBarButtonItems = @[back];
    
    
    
}

-(void)backBtnClick{
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
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
