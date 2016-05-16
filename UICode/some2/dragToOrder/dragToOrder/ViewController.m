//
//  ViewController.m
//  dragToOrder
//
//  Created by 史秀泽 on 16/4/3.
//  Copyright © 2016年 SXZ. All rights reserved.
//

#import "ViewController.h"
#import "FDSlideBar.h"
#import "HUDManager.h"
#import "Classify.h"
#import "EditCategoriesViewController.h"
#define FILEPATH [NSHomeDirectory() stringByAppendingPathComponent:@"/Documents/Classify.archiver"]
#define ENCODEKEY @"Classify"
#define WEAKSELF(weakSelf) typeof(self) __weak weakSelf = self;
#define DSSBounds   [UIScreen mainScreen].bounds
#define DSSWidth    CGRectGetWidth(DSSBounds)
#define DSSHeight   CGRectGetHeight(DSSBounds)
#define COLOR [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1]

@interface ViewController ()<UIScrollViewDelegate>
{
    NSMutableArray<Classify*>* myClassify;
}

@property(nonatomic, strong)UIScrollView *scrollMain;
@property(nonatomic, strong)FDSlideBar *sliderBar;
@property(nonatomic, strong)UIButton* editCategoriesBtn;
@property(nonatomic, strong)EditCategoriesViewController* editVC;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [[NSNotificationCenter defaultCenter]addObserver: self
                                            selector: @selector(refreshTitle:)
                                                name: @"editClassify"
                                              object:nil];
    [self customNavigationController];
}

-(void)viewDidAppear:(BOOL)animated
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self getMyClassify];
    });
}

#pragma mark -定制NavigationController
-(void)customNavigationController
{
    [self.navigationItem setHidesBackButton:YES];
    
    self.editCategoriesBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    [self.editCategoriesBtn setBackgroundImage:[UIImage imageNamed:@"edit"] forState:UIControlStateNormal];
    self.editCategoriesBtn.frame=CGRectMake(0, 5, 30, 30);
    [self.editCategoriesBtn addTarget:self action:@selector(editCategories) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:self.editCategoriesBtn]];
}

#pragma mark -进入编辑页面
-(void)editCategories
{
    [self presentViewController:self.editVC animated:YES completion:^{
        
    }];
}

#pragma mark -获取自定义类别
-(void)getMyClassify
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:FILEPATH]) {
        
        NSData *data = [[NSMutableData alloc] initWithContentsOfFile:FILEPATH];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        myClassify = [NSMutableArray arrayWithArray:[unarchiver decodeObjectForKey:@"Classify"]];
        [unarchiver finishDecoding];
        
    }else
    {
        myClassify=[[NSMutableArray alloc]init];
        for (int i=1; i<=20; i++) {
            Classify* class=[[Classify alloc]init];
            class.pageNum = [NSString stringWithFormat:@"%d",i];
            [myClassify addObject:class];
        }
        [self saveChangeOfCategories];
    }
    
    self.editVC = [[self theStoryboard] instantiateViewControllerWithIdentifier:@"EditCategoriesViewController"];
    self.editVC.categories=[[NSMutableArray alloc]initWithArray:myClassify];
    self.editVC.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
    
    [self createScrollMain];
}

#pragma mark -第一次运行此程序时创建初始文件
-(void)saveChangeOfCategories
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [HUDManager showWithStatus:@"初始化。。。"];
        [[NSFileManager defaultManager] fileExistsAtPath:FILEPATH];
        NSMutableData *data = [[NSMutableData alloc] init];
        NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
        
        [archiver encodeObject:myClassify forKey:ENCODEKEY];
        [archiver finishEncoding];
        
        if ([data writeToFile:FILEPATH atomically:YES]) {
            [HUDManager dismissWithSuccess:@"欢迎使用" delay:2];
        }else
        {
            [HUDManager dismissWithError:@"初始化错误" delay:0.5];
        }
    });
}

- (UIScrollView *)scrollMain
{
    if (!_scrollMain) {
        _scrollMain = [[UIScrollView alloc] init];
        _scrollMain.frame = CGRectMake(0, 0, DSSWidth, DSSHeight);
        _scrollMain.contentSize = CGSizeMake(DSSWidth * myClassify.count, 0);
        _scrollMain.pagingEnabled = YES;
        _scrollMain.delegate = self;
        [self.view addSubview:_scrollMain];
    }
    return _scrollMain;
}

-(UIStoryboard *)theStoryboard{
    if(self.storyboard != nil)
    {
        return self.storyboard;
    }
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    return sb;
}

#pragma mark -刷新界面
-(void)createScrollMain
{
    for (UIView* v in self.scrollMain.subviews) {
        [v removeFromSuperview];
    }
    
    for (int i=0; i<myClassify.count; i++) {
        
        UILabel* label=[[UILabel alloc]initWithFrame:CGRectMake(i*DSSWidth, 0, DSSWidth, self.scrollMain.frame.size.height)];
        label.backgroundColor = COLOR;
        label.text = myClassify[i].pageNum;
        label.textColor = COLOR;
        label.textAlignment=NSTextAlignmentCenter;
        label.font=[UIFont boldSystemFontOfSize:30];
        [self.scrollMain addSubview:label];
    }
    self.scrollMain.contentSize = CGSizeMake(DSSWidth * myClassify.count, 0);
    self.scrollMain.contentOffset=CGPointMake(0, 0);
    [self refreshTitle:nil];
}

#pragma mark -创建标签栏
- (void)refreshTitle:(NSNotification*)notification {
    if (notification) {
        myClassify = notification.object;
        [self createScrollMain];
    }
    
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < myClassify.count; i++) {
        [arr addObject:[NSString stringWithFormat:@"第%@页",myClassify[i].pageNum]];
    }
    
    self.sliderBar = [[FDSlideBar alloc] init];
    [self.sliderBar setItemsTitle:arr];
    self.sliderBar.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1];
    self.sliderBar.itemColor = [UIColor colorWithRed:0.46 green:0.46 blue:0.46 alpha:1];
    self.sliderBar.itemSelectedColor = [UIColor colorWithRed:0.93 green:0.16 blue:0.14 alpha:1];
    self.sliderBar.sliderColor = [UIColor colorWithRed:0.93 green:0.16 blue:0.14 alpha:1];
    [self.view addSubview:self.sliderBar];
    self.editCategoriesBtn.enabled = YES;
    
    WEAKSELF(weakSelf)
    [self.sliderBar slideBarItemSelectedCallback:^(NSUInteger idx) {
        
        CGRect rect = weakSelf.scrollMain.bounds;
        rect.origin.x = rect.size.width*idx;
        [weakSelf.scrollMain setContentOffset:CGPointMake(rect.origin.x, rect.origin.y) animated:NO];
        
    }];
}

#pragma mark -scrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger idx = self.scrollMain.contentOffset.x/DSSWidth;
    [self.sliderBar selectSlideBarItemAtIndex:idx];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
