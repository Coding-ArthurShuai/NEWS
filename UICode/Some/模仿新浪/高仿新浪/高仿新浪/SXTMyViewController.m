//
//  SXTMyViewController.m
//  新浪作业
//
//  Created by ma c on 16/2/19.
//  Copyright © 2016年 SXT. All rights reserved.
//

#import "SXTMyViewController.h"

@interface SXTMyViewController ()

@end

@implementation SXTMyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *view = [[UIImageView alloc] initWithFrame:self.view.bounds];
    view.image = [UIImage imageNamed:@"5"];
    
    [self.view addSubview:view];
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
