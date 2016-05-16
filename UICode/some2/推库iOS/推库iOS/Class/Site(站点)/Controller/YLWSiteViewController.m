//
//  YLWSiteViewController.m
//  推库iOS
//
//  Created by Mac on 16/2/17.
//  Copyright © 2016年 YLW. All rights reserved.
//

#import "YLWSiteViewController.h"


@implementation YLWSiteViewController 



- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    

}

/**
 *  获取站点的数据
 */
-(void)getSiteData{

    __weak typeof(self) weakself = self;
    [YLWSiteItemModel siteItemModelWithURLstring:@"http://api.tuicool.com/api/sites/user_default.json" lastArray:(NSArray *)self.itemModelArray  successblock:^(NSArray *itemArray) {
       
        weakself.itemModelArray = itemArray;
        [weakself.tableView reloadData];
        weakself.tableView.tableFooterView = weakself.footView;
        
    }];
    
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    YLWSiteItemModel *model = self.itemModelArray[indexPath.row];
    
    model.didSelected = YES;
    model.count = @"";
    [self.tableView reloadData];
    YLWContentTableViewController *contentVc = [[YLWContentTableViewController alloc]init];
    contentVc.hidesBottomBarWhenPushed = YES;
    contentVc.title = model.name;
    NSString *urlstring = [NSString stringWithFormat:@"http://api.tuicool.com/api/sites/%@.json?size=30",model.id];
    NSLog(@"%@",urlstring);
    contentVc.urlstring = urlstring;
    [self.navigationController pushViewController:contentVc animated:YES];
    

}


@end
