//
//  HRMessageController.m
//  HR_W仿QQ界面
//
//  Created by admin on 16/4/19.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "HRMessageController.h"
#import "HRCoverView.h"


@interface HRMessageController ()<UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate>

@property (nonatomic, weak) UIButton *iconBtn;



@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation HRMessageController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad{
    [super viewDidLoad];
        //创建流布局
    UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
        //设置大小
    flowlayout.itemSize = CGSizeMake(self.view.width, self.view.height-KStatusHeight-KTabBarHeight-KNavBarHeight);
        //设置滚动方向
    flowlayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        //设置最小间距
    flowlayout.minimumLineSpacing = 0;
        //布局
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowlayout];
    [self.view addSubview:collectionView];
        //赋值
    _collectionView = collectionView;
        //翻页效果
    collectionView.pagingEnabled = YES;
        //水平滚动
    collectionView.showsHorizontalScrollIndicator = NO;
        //关闭弹簧效果
    collectionView.bounces = NO;
        //设置title
    [self settingTitle];
        //创建昨天的头像
    [self settingIconImage];
        //添加右边的 +
    [self settingAddImage];
        //注册
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
        //设置代理
    collectionView.delegate = self;
    collectionView.dataSource = self;
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
        cell.backgroundColor = HRRandomColor;

            return cell;
   
}



- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat offset = scrollView.contentOffset.x;
    
    self.segment.selectedSegmentIndex = offset/KScreenWith;
    
    
}




- (void)viewWillAppear:(BOOL)animated{
    self.iconBtn.hidden = NO;
}

#pragma make-添加右边的 +
- (void)settingAddImage{
    
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(createCover)];
    
    self.navigationItem.rightBarButtonItem = rightBtn;

}

- (void)createCover{
    
    NSLog(@"创建了一个遮盖");
    
        //创建遮盖
    HRCoverView *cover = [[HRCoverView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
            //跳转
    cover.jump = ^(UIViewController *vc){
        
        self.iconBtn.hidden = YES;
        
        [self.navigationController pushViewController:vc animated:YES];
    };
        
    [self.tabBarController.view addSubview:cover];

}


#pragma make- 创建昨天的头像
- (void)settingIconImage{

    UIButton *iconBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, 40, 40)];
      //裁剪头像
      //获取头像
    UIImage *image = [UIImage imageNamed:@"E940631E-9DA9-41F6-BB5D-B2B1E8C46551"];
        //创建图片上下文
    UIGraphicsBeginImageContextWithOptions(iconBtn.bounds.size, NO, 0);
        //获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
        //绘制路径
    CGContextAddEllipseInRect(ctx, CGRectMake(0, 0, iconBtn.width, iconBtn.height));
        //裁剪
    CGContextClip(ctx);
    [image drawInRect:iconBtn.bounds];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    [iconBtn setImage:newImage forState:UIControlStateNormal];
    
    [iconBtn addTarget:self action:@selector(jump:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.navigationController.navigationBar addSubview:iconBtn];
    _iconBtn = iconBtn;
}

#pragma make- 设置title
- (void)settingTitle{
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:@[@"消息",@"电话"]];
        //设置宽度
    segment.width = 120;
        //设置选中和普通状态 文字颜色为白色
    [segment setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    [segment setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blueColor]} forState:UIControlStateSelected];
        //默认选中第0个
    segment.selectedSegmentIndex = 0;
    
        //添加
    self.navigationItem.titleView = segment;
    
    _segment = segment;
        //添加点击方法
    [segment addTarget:self action:@selector(segmentClick) forControlEvents:UIControlEventValueChanged];
}


    //切换视图
- (void)segmentClick{
    
  CGPoint offsetPoint = CGPointMake(self.segment.selectedSegmentIndex * KScreenWith, -(KStatusHeight+KNavBarHeight));
    NSLog(@"%zd",offsetPoint);
    [self.collectionView setContentOffset:offsetPoint];
}
    //点击头像跳转
- (void)jump:(UIButton *)sender{
    
    NSLog(@"跳转");

}

@end
