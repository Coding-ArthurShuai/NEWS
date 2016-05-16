//
//  ViewController.m
//  3D效果
//
//  Created by 卢鹏肖 on 16/1/7.
//  Copyright © 2016年 com.shuai. All rights reserved.
//

#import "ViewController.h"

#import "ShowImageCell.h"
#import "CircleLayout.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong) UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, width, height) collectionViewLayout:[[CircleLayout alloc] init]];
    [self.collectionView registerClass:[ShowImageCell class] forCellWithReuseIdentifier:@"identifier"];
    self.collectionView.backgroundColor = [UIColor grayColor];
    self.collectionView.delegate = self;
    [self.collectionView setContentOffset:CGPointMake(width, 0.0F)];
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    ShowImageCell *cell = (ShowImageCell *)[cView dequeueReusableCellWithReuseIdentifier:@"identifier" forIndexPath:indexPath];
    if (!cell) return nil;
    NSString *imageName = [NSString stringWithFormat:@"%ld.JPG",(long)indexPath.row];
    cell.imageView.image = [UIImage imageNamed:imageName];
    cell.titleLabel.text = imageName;
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    float targetX = scrollView.contentOffset.x;
    NSInteger numCount = [self.collectionView numberOfItemsInSection:0];
    float ITEM_WIDTH = scrollView.frame.size.width;
    if (numCount>=3)
    {
        if (targetX < ITEM_WIDTH/2) {
            [scrollView setContentOffset:CGPointMake(targetX+ITEM_WIDTH *numCount, 0)];
        }
        else if (targetX >ITEM_WIDTH/2+ITEM_WIDTH *numCount)
        {
            [scrollView setContentOffset:CGPointMake(targetX-ITEM_WIDTH *numCount, 0)];
        }
    }
}


@end
