
//
//  YLWUserViewController.m
//  推库iOS
//
//  Created by Mac on 16/2/17.
//  Copyright © 2016年 YLW. All rights reserved.
//

#import "YLWUserViewController.h"
#import "YLWUserItemModel.h"
#import "YLWUserGroupModel.h"
#import "YLWUserLoginCell.h"
#import "YLWUserLoginController.h"
#import "YLWUserInfoViewController.h"
#import "YLWContentTableViewController.h"
@interface YLWUserViewController ()

@property (nonatomic,strong) NSArray *dataArray;

@property (nonatomic,assign) BOOL isLogin;

@end

@implementation YLWUserViewController

-(BOOL)isLogin{

    return [YLWUserLoginModel sharedUserLoginModel].isLogin;

}

-(NSArray *)dataArray{

    if (_dataArray== nil) {
        
        
        YLWUserItemModel *model00 = [YLWUserItemModel userItemModelWithName:@"点击登录" icon:@"default_avatar"];
        YLWUserGroupModel *group0 = [YLWUserGroupModel userGroupModelWithModelArray:@[model00]];
        
        YLWUserItemModel *model10 = [YLWUserItemModel userItemModelWithName:@"我的待读" urlstring:@"http://api.tuicool.com/api/articles/late.json?size=200"];
        YLWUserItemModel *model11 = [YLWUserItemModel userItemModelWithName:@"我的收藏" urlstring:@"http://api.tuicool.com/api/articles/my.json?size=30"];
        YLWUserItemModel *model12 = [YLWUserItemModel userItemModelWithName:@"我的推刊" urlstring:@"http://api.tuicool.com/api/kans/my.json"];
        YLWUserGroupModel *group1 = [YLWUserGroupModel userGroupModelWithModelArray:@[model10,model11,model12]];
        
        YLWUserItemModel *model20 = [YLWUserItemModel userItemModelWithName:@"夜间模式" swich:YES];
        YLWUserItemModel *model21 = [YLWUserItemModel userItemModelWithName:@"离线阅读"];
        YLWUserItemModel *model22 = [YLWUserItemModel userItemModelWithName:@"相关设置"];
        YLWUserItemModel *model23 = [YLWUserItemModel userItemModelWithName:@"意见反馈"];
        YLWUserItemModel *model24 = [YLWUserItemModel userItemModelWithName:@"请求鼓励"];
        YLWUserItemModel *model25 = [YLWUserItemModel userItemModelWithName:@"关于我们"];
        YLWUserGroupModel *group2 = [YLWUserGroupModel userGroupModelWithModelArray:@[model20,model21,model22,model23,model24,model25]];
        _dataArray = @[group0,group1,group2];
        
        
    }

    return _dataArray;
}

+(instancetype)userview{

    UIStoryboard *st = [UIStoryboard storyboardWithName:@"YLWUserViewController" bundle:nil];
    
    YLWUserViewController *user = [st instantiateInitialViewController];
    
    return user;

}

-(instancetype)init{

    return [super initWithStyle:UITableViewStyleGrouped];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.tableView.sectionHeaderHeight = 1;
    self.tableView.sectionFooterHeight = 18;
    self.tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 1)];

    self.navigationItem.leftBarButtonItem = nil;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loginSuccess) name:@"YLWUserLoginControllerLoginSuccess" object:nil];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 登录成功
-(void)loginSuccess{

    [self.tableView reloadData];
    

}

#pragma mark - Table view data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return self.dataArray.count;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [self.dataArray[section] itemModelArray].count;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YLWUserGroupModel *group = self.dataArray[indexPath.section];
    YLWUserItemModel *itemModel = group.itemModelArray[indexPath.row];
    
    
    NSString *loginIdentifier = @"";
    
    if (indexPath.section == 0) {
        
        loginIdentifier = @"loginIdentifier0";
        
        YLWUserLoginCell *cell = [tableView dequeueReusableCellWithIdentifier:loginIdentifier];
        
        if (cell == nil) {
            
            cell = [YLWUserLoginCell userLoginCell];
            
        }
        cell.itemModel = itemModel;
        
        return cell;
    }else {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:loginIdentifier];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:loginIdentifier];
        }
        
        
        cell.textLabel.text = itemModel.name;
        if (itemModel.swich) {
            cell.accessoryView = [[UISwitch alloc]init];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }else{
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        return cell;
    
    
    }
    
   
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        return 65;
    }else{
    
        return 44;
    }

}

#pragma mark - 选中cell进行跳转

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    YLWUserGroupModel *group = self.dataArray[indexPath.section];
    YLWUserItemModel *itemModel = group.itemModelArray[indexPath.row];
    if (indexPath.section == 0) {
        
        if (self.isLogin) {
            YLWUserInfoViewController *userInfo = [[YLWUserInfoViewController alloc]init];
            userInfo.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:userInfo animated:YES];
        }else{
        
            YLWUserLoginController *login = [[YLWUserLoginController alloc]init];
            
            [self.navigationController pushViewController:login animated:YES];
            
        }
    
    }else if (indexPath.section == 1){
    
        if ([YLWUserLoginModel sharedUserLoginModel].isLogin) {
            
            YLWContentTableViewController *contentTable = [[YLWContentTableViewController alloc]init];
            
            contentTable.urlstring = itemModel.urlstring;
            
            contentTable.title = itemModel.name;
            
            [self.navigationController pushViewController:contentTable animated:YES];
            
        }else{
        
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请登录后查看！" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
            
        
        }
        
    
    
    }


}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
