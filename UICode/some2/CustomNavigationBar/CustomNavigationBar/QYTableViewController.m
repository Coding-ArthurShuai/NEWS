//
//  QYTableViewController.m
//  CustomNavigationBar
//
//  Created by 青云-wjl on 16/4/7.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "QYTableViewController.h"

@interface QYTableViewController ()
@property (nonatomic, strong) UIView *bgView;
@end

@implementation QYTableViewController

-(UIView *)bgView {
    if (_bgView == nil) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 3, 3)];
        _bgView.alpha = 1.0;
        _bgView.backgroundColor = [UIColor redColor];
    }
    return _bgView;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self changeAlphaForNavigationSubViews:self.navigationController.navigationBar alpha:0];
    //[self.navigationController.navigationBar setBackgroundImage:[[self getImage] resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1, 1) resizingMode:UIImageResizingModeStretch] forBarMetrics:UIBarMetricsDefault];
    
    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = [NSString stringWithFormat:@"%ld行",indexPath.row];
    
    return cell;
}


-(UIImage *)getImage
{
    //创建一个跟view相同大小的上下文
    UIGraphicsBeginImageContext(self.bgView.bounds.size);
    //把view中的layer绘制到上下文
    [self.bgView.layer renderInContext:UIGraphicsGetCurrentContext()];
    //返回一个基于当前上下文的图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    _bgView.alpha = scrollView.contentOffset.y / 100;
//    [self.navigationController.navigationBar setBackgroundImage:[[self getImage] resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1, 1) resizingMode:UIImageResizingModeStretch] forBarMetrics:UIBarMetricsDefault];
    [self changeAlphaForNavigationSubViews:self.navigationController.navigationBar alpha:scrollView.contentOffset.y / 100];
}

-(void)changeAlphaForNavigationSubViews:(UIView *)view alpha:(CGFloat)num{
    for (UIView *subView in view.subviews) {
        subView.alpha = num;
        [self changeAlphaForNavigationSubViews:subView alpha:num];
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"第一组";
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
