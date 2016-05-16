//
//  YLWUserInfoViewController.m
//  推库iOS
//
//  Created by Mac on 16/2/22.
//  Copyright © 2016年 YLW. All rights reserved.
//

#import "YLWUserInfoViewController.h"

@interface YLWUserInfoViewController ()<UITableViewDelegate,UITableViewDataSource>



@property (nonatomic,strong) NSArray *userArray;

@end

@implementation YLWUserInfoViewController

-(NSArray *)userArray{

    if (_userArray == nil) {
        
        _userArray = [NSArray array];
        
    }
    return _userArray;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];
    
    YLWUserLoginModel *loginmodel = [YLWUserLoginModel sharedUserLoginModel];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"userinfo"];
    
    self.userArray = @[@{@"key":@"名字",
                         @"name":loginmodel.name
                         }];

}



-(void)setNav{

    UIBarButtonItem *leavLogin = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"logout"] style:UIBarButtonItemStylePlain target:self action:@selector(logout)];
    
    self.navigationItem.rightBarButtonItem = leavLogin;



}

-(void)logout{

    UIAlertController *logoutAlert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要退出吗？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *shure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        
        NSString *file = [path stringByAppendingPathComponent:@"userInfo.plist"];
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        if ([fileManager fileExistsAtPath:file]) {
            
            [fileManager removeItemAtPath:file error:nil];
            
            [YLWUserLoginModel sharedUserLoginModel].userInfoModel = nil;
            
            [self.tabBarController setSelectedIndex:0];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"YLWUserLoginControllerLoginSuccess" object:nil];
            
            [self.navigationController popViewControllerAnimated:YES];
            
            
        }else{
            
            NSLog(@"文件不存在");
            
        }

        
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [logoutAlert addAction:shure];
    [logoutAlert addAction:cancel];
    
    [self presentViewController:logoutAlert animated:YES completion:nil];
    
    
    
    
    

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.userArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"userinfo" forIndexPath:indexPath];

    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"userinfo" ];
    }
    NSDictionary *dic = self.userArray[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@: %@",dic[@"key"],dic[@"name"]];


    
    return cell;
}

@end
