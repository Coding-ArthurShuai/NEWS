//
//  ViewController.m
//  MoveTableViewDemo
//
//  Created by King on 16/4/18.
//  Copyright © 2016年 King. All rights reserved.
//

#import "ViewController.h"
#import "TableViewController.h"
#import "CollectionViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton * topButton = [[UIButton alloc]initWithFrame:CGRectMake(50,50+64,self.view.frame.size.width-100,50)];
    topButton.backgroundColor = [UIColor blackColor];
    [topButton setTitle:@"moveTableViewCell" forState:UIControlStateNormal];
    [topButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [topButton addTarget:self action:@selector(onClickTopButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:topButton];
    
    UIButton * bottomButton = [[UIButton alloc]initWithFrame:CGRectMake(50,50+64+50+100,self.view.frame.size.width-100,50)];
    bottomButton.backgroundColor = [UIColor blackColor];
    [bottomButton setTitle:@"moveCollectionViewCell" forState:UIControlStateNormal];
    [bottomButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bottomButton addTarget:self action:@selector(onClickBottomButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bottomButton];

}

- (void)onClickTopButton{
    
    TableViewController * tvc = [[TableViewController alloc]init];
    [self.navigationController pushViewController:tvc animated:YES];
    
}

- (void)onClickBottomButton{
    
    CollectionViewController * cvc = [[CollectionViewController alloc]init];
    [self.navigationController pushViewController:cvc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
