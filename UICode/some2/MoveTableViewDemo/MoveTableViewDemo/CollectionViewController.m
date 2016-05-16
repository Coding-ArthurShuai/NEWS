//
//  CollectionViewController.m
//  MoveTableViewDemo
//
//  Created by King on 16/4/19.
//  Copyright © 2016年 King. All rights reserved.
//

#import "CollectionViewController.h"

#import "CollectionViewCell.h"

@interface CollectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIGestureRecognizerDelegate>

@property (strong,nonatomic) UICollectionView * collectionView;
@property (strong,nonatomic) NSMutableArray * dataSource;

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"moveCollectionViewCell";
    
    self.dataSource = [NSMutableArray array];
    
    [self createDataSource];
    [self createCollectionView];
    
    //注册cell
    [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"cell"];

}

- (void)createDataSource{
    
    NSArray * array = @[@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg",@"5.jpg",@"6.jpg",@"7.jpg",@"8.jpg",@"9.jpg",@"10.jpg",@"11.jpg"];
    self.dataSource = [[NSMutableArray alloc]initWithArray:array];
}

- (void)createCollectionView{
    
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];

    
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64) collectionViewLayout:flowLayout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    [self.view addSubview:self.collectionView];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]
                                               initWithTarget:self action:@selector(longPressGestureRecognized:)];
    [self.collectionView addGestureRecognizer:longPress];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];

}

//长按手势方法
- (void)longPressGestureRecognized:(id)sender {
    
    UILongPressGestureRecognizer *longPress = (UILongPressGestureRecognizer *)sender;
    UIGestureRecognizerState state = longPress.state;
    
    static UIView       *snapshot = nil;        ///< A snapshot of the row user is moving
    
    //判断手势状态
    switch (state) {
        case UIGestureRecognizerStateBegan:{
            //判断手势落点位置是否在路径上
            NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:[longPress locationInView:self.collectionView]];
            
            UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:indexPath];
            snapshot = [self customSnapshotFromView:cell];
            snapshot.center = cell.center;
            [self.collectionView addSubview:snapshot];
            
            [UIView animateWithDuration:0.25 animations:^{
                
                // Offset for gesture location.
                
                snapshot.transform = CGAffineTransformMakeScale(1.05, 1.05);
                snapshot.alpha = 0.28;
                
                // Black out.
                //cell.backgroundColor = [UIColor blackColor];
            } completion:nil];
            
            if (indexPath == nil) {
                break;
            }
            //在路径上则开始移动该路径上的cell
            [self.collectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
        }
            break;
        case UIGestureRecognizerStateChanged:
            //移动过程当中随时更新cell位置
            
            [self.collectionView updateInteractiveMovementTargetPosition:[longPress locationInView:self.collectionView]];
            
            break;
            
        case UIGestureRecognizerStateEnded:
            //移动结束后关闭cell移动
            [self.collectionView endInteractiveMovement];
            [snapshot removeFromSuperview];
            
            break;
        default:
            [self.collectionView cancelInteractiveMovement];
            break;
    }
    
    // More coming soon...
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath{
    //返回YES允许其item移动
    return YES;
}

//CollectionView move 方法
- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath {
    //取出源item数据
    id objc = [_dataSource objectAtIndex:sourceIndexPath.item];
    
    //从资源数组中移除该数据
    [_dataSource removeObject:objc];
    //将数据插入到资源数组中的目标位置上
    [_dataSource insertObject:objc atIndex:destinationIndexPath.item];
}

//自定制快照样式
- (UIView *)customSnapshotFromView:(UIView *)inputView {
    
    UIView *snapshot = [inputView snapshotViewAfterScreenUpdates:YES];
    snapshot.layer.masksToBounds = NO;
    snapshot.layer.cornerRadius = 0.0;
    snapshot.layer.shadowOffset = CGSizeMake(-5.0, 0.0);
    snapshot.layer.shadowRadius = 5.0;
    snapshot.layer.shadowOpacity = 0.4;
    
    return snapshot;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataSource.count;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * identity = @"cell";
    CollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:identity forIndexPath:indexPath];
    //[cell sizeToFit];
    if (!cell) {
        
    }
    
    cell.imgView.image = [UIImage imageNamed:self.dataSource[indexPath.row]];
    cell.text.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    
    return cell;
}

//定义每个uicoView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(self.view.frame.size.width/3-10, self.view.frame.size.width/3-10+20);
}

//定义每个UIcollectionView 的间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0, 5, 5, 5);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0;
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
