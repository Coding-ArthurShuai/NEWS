//
//  YLWTopicViewController.m
//  推库iOS
//
//  Created by Mac on 16/2/17.
//  Copyright © 2016年 YLW. All rights reserved.
//

#import "YLWTopicViewController.h"
#import "YLWTopicItemModel.h"
#import "YLWSiteItemTableViewCell.h"
#import "YLWContentTableViewController.h"
@interface YLWTopicViewController ()


@end

@implementation YLWTopicViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    

    
    
}

#pragma mark - 获取数据
-(void)getSiteData{

    __weak typeof(self) weakself = self;
    [YLWTopicItemModel topicItemModelWithURLstring:@"http://api.tuicool.com/api/topics/user_default.json" lastArray:(NSArray *)self.itemModelArray successblock:^(NSArray *itemArray) {
       
        weakself.itemModelArray = itemArray;
        
        [weakself.tableView reloadData];
        
        weakself.tableView.tableFooterView = weakself.footView;
    }];

}



#pragma mark - Tableview 代理和数据源方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.itemModelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YLWSiteItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SiteCellIdentifier"];
    
    if (cell == nil) {
        cell= [[YLWSiteItemTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"SiteCellIdentifier"];
    }
    
    
    YLWSiteItemModel *model = self.itemModelArray[indexPath.row];
    
    cell.siteItemModel = model;
    
    
    
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YLWTopicItemModel *model = self.itemModelArray[indexPath.row];
    model.didSelected = YES;
    model.count = @"";
    [self.tableView reloadData];
    YLWContentTableViewController *contentVc = [[YLWContentTableViewController alloc]init];
    contentVc.hidesBottomBarWhenPushed = YES;
    contentVc.title = model.name;
    NSString *urlstring = [NSString stringWithFormat:@"http://api.tuicool.com/api/topics/%@.json?lang=1&size=30&st=0",model.id];
    contentVc.urlstring = urlstring;
    [self.navigationController pushViewController:contentVc animated:YES];
    
    
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
