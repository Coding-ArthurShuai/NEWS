//
//  EditCategoriesViewController.m
//  dragToOrder
//
//  Created by 史秀泽 on 16/4/5.
//  Copyright © 2016年 SXZ. All rights reserved.
//

#import "EditCategoriesViewController.h"
#import "HUDManager.h"
#define FILEPATH [NSHomeDirectory() stringByAppendingPathComponent:@"/Documents/Classify.archiver"]
#define ENCODEKEY @"Classify"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface EditCategoriesViewController ()
{
    NSInteger selectedLineNum;
    NSInteger otherLineNum;
    NSString* homePath;
    NSString* encodeKey;
    CGPoint nextPoint;
    CGPoint endPoint;
    CGPoint valuePoint;
    NSMutableArray<Classify *>* myCategories;
    NSMutableArray *tempArray;
    UILabel* otherLabel;
    UIButton* rightBtn;
}

@property (strong, nonatomic) IBOutlet UIView *mainView;
@property (strong, nonatomic) IBOutlet UILabel *selectedTitleLabel;
@property UIView* selected;
@property UIScrollView* othersView;
@property NSMutableArray<Classify *>* otherCategories;
@property NSMutableArray<UIButton *>* otherBtns;
@property NSMutableArray<UIButton *>* selectedBtns;
@end

@implementation EditCategoriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.selectedTitleLabel.backgroundColor=[UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1];
    rightBtn=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-35, 30, 30, 30)];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"save"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(onRightButtonTap) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightBtn];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self getAllCategories];
    });
}

#pragma mark -获取全部群组
-(void)getAllCategories
{
    myCategories = [self.categories mutableCopy];
    
    tempArray=[[NSMutableArray alloc]init];
    
    for (int i=1; i<=20; i++) {
        Classify* class=[[Classify alloc]init];
        class.pageNum = [NSString stringWithFormat:@"%d",i];
        [tempArray addObject:class];
    }
    
    [self compareWithAllCategories];
}

#pragma mark -与全部群组对比分类
-(void)compareWithAllCategories
{
    if (self.otherCategories) {
        [self.otherCategories removeAllObjects];
    }else
    {
        self.otherCategories=[[NSMutableArray alloc]init];
    }
    
    BOOL isSelected;
    for (Classify* class in tempArray) {
        isSelected = NO;
        for (Classify* myClass in self.categories) {
            if ([class.pageNum isEqualToString:myClass.pageNum]) {
                isSelected = YES;
                break;
            }
        }
        if (!isSelected) {
            [self.otherCategories addObject:class];
        }
    }
    [self createUI];
}

#pragma mark -计算按钮行数
-(void)calculationOfLineNum
{
    if (self.categories.count%4!=0) {
        selectedLineNum=self.categories.count/4+1;
    }else
    {
        selectedLineNum=self.categories.count/4;
    }
    
    if (self.otherCategories.count%4!=0) {
        otherLineNum=self.otherCategories.count/4+1;
    }else
    {
        otherLineNum=self.otherCategories.count/4;
    }
}

#pragma mark -定制Button
-(void)customButton:(UIButton*)btn andTitle:(NSString*)name
{
    [btn setTitle:name forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont systemFontOfSize:14];
    btn.backgroundColor=[UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1];
    btn.layer.borderWidth=1.0f;
    btn.layer.borderColor=[[UIColor whiteColor]CGColor];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
}

#pragma mark -分类创建标签
-(void)createUI
{
    [self calculationOfLineNum];
    
    self.selected = [[UIView alloc]initWithFrame:CGRectMake(0, 30, SCREEN_WIDTH, selectedLineNum*30+5)];
    [self.mainView addSubview:self.selected];
    
    self.selectedBtns=[[NSMutableArray alloc]init];
    
    for (int i=0; i<self.categories.count; i++) {
        UIButton* btn=[[UIButton alloc]initWithFrame:CGRectMake(i%4*SCREEN_WIDTH/4, 5+i/4*30, SCREEN_WIDTH/4, 30)];
        [btn addTarget:self action:@selector(deleteCategoryBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self customButton:btn andTitle:[self.categories[i] pageNum]];
        if (i==0) {
            btn.enabled=NO;
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }
        UILongPressGestureRecognizer * longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        longPress.minimumPressDuration=0.2;
        [btn addGestureRecognizer:longPress];
        [self.selected addSubview:btn];
        [self.selectedBtns addObject:btn];
    }
    
    self.othersView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, self.selected.frame.size.height+self.selected.frame.origin.y, SCREEN_WIDTH, SCREEN_HEIGHT-(self.selected.frame.size.height+self.selected.frame.origin.y))];
    self.othersView.contentSize=CGSizeMake(0, selectedLineNum*30);
    self.otherBtns=[[NSMutableArray alloc]init];
    
    for (int i=0; i<self.otherCategories.count; i++) {
        UIButton* btn=[[UIButton alloc]initWithFrame:CGRectMake(i%4*SCREEN_WIDTH/4, (i/4+1)*30, SCREEN_WIDTH/4, 30)];
        [self customButton:btn andTitle:[self.otherCategories[i] pageNum]];
        [btn addTarget:self action:@selector(addCategoryBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.othersView addSubview:btn];
        [self.otherBtns addObject:btn];
    }
    
    otherLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 2, SCREEN_WIDTH, 27)];
    otherLabel.backgroundColor=[UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1];
    otherLabel.text=@"  频道";
    
    [self.othersView addSubview:otherLabel];
    
    [self.mainView insertSubview:self.othersView atIndex:0];
}

#pragma mark -删除栏目
-(void)deleteCategoryBtn:(UIButton*)btn
{
    self.view.userInteractionEnabled=NO;
    
    for (UIGestureRecognizer* gr in btn.gestureRecognizers) {
        if ([gr isKindOfClass:[UILongPressGestureRecognizer class]]) {
            [btn removeGestureRecognizer:gr];
        }
    }
    
    for (Classify* class in self.categories) {
        if ([class.pageNum isEqualToString:btn.titleLabel.text]) {
            
            CGPoint btnPoint = btn.center;
            
            [btn removeTarget:self action:@selector(deleteCategoryBtn:) forControlEvents:UIControlEventTouchUpInside];
            [btn addTarget:self action:@selector(addCategoryBtn:) forControlEvents:UIControlEventTouchUpInside];
            
            __block CGPoint wbtPoint = btnPoint;
            
            [self.categories removeObject:class];
            [self.otherCategories insertObject:class atIndex:0];
            
            [self calculationOfLineNum];
            
            [UIView animateWithDuration:0.3 animations:^{
                
                self.selected.frame =CGRectMake(0, 30, SCREEN_WIDTH, selectedLineNum*30+5);
                
                self.othersView.frame = CGRectMake(0, self.selected.frame.size.height+self.selected.frame.origin.y, SCREEN_WIDTH, SCREEN_HEIGHT-(self.selected.frame.size.height+self.selected.frame.origin.y));
                self.othersView.contentSize=CGSizeMake(0, selectedLineNum*30);
                
                btn.frame=CGRectMake(0, self.othersView.frame.origin.y, SCREEN_WIDTH/4, 30);
                for (NSInteger i = [self.selectedBtns indexOfObject:btn]+1; i<self.selectedBtns.count; i++) {
                    UIButton * nextBt = self.selectedBtns[i];
                    nextPoint = nextBt.center;
                    nextBt.center = wbtPoint;
                    wbtPoint = nextPoint;
                }
            } completion:^(BOOL finished) {
                btn.frame=CGRectMake(0, 30, SCREEN_WIDTH/4, 30);
                [self.othersView addSubview:btn];
                [self.selectedBtns removeObject:btn];
                [self.otherBtns insertObject:btn atIndex:0];
            }];
            
            [UIView animateWithDuration:0.3 animations:^{
                for (int i=0; i<self.otherBtns.count; i++) {
                    UIButton* button=self.otherBtns[i];
                    button.frame=CGRectMake((i+1)%4*SCREEN_WIDTH/4, ((i+1)/4+1)*30, SCREEN_WIDTH/4, 30);
                }
            } completion:^(BOOL finished) {
                self.view.userInteractionEnabled=YES;
            }];
            break;
        }
    }
}

#pragma mark -添加栏目
-(void)addCategoryBtn:(UIButton*)btn
{
    self.view.userInteractionEnabled=NO;
    [btn removeTarget:self action:@selector(addCategoryBtn:) forControlEvents:UIControlEventTouchUpInside];
    [btn addTarget:self action:@selector(deleteCategoryBtn:) forControlEvents:UIControlEventTouchUpInside];
    UILongPressGestureRecognizer * longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    longPress.minimumPressDuration=0.2;
    [btn addGestureRecognizer:longPress];
    
    UIButton* button=self.selectedBtns.lastObject;
    
    for (Classify* class in self.otherCategories) {
        
        if ([class.pageNum isEqualToString:btn.titleLabel.text]) {
            
            [self.categories addObject:class];
            [self.otherCategories removeObject:class];
            
            CGPoint btnPoint = btn.center;
            __block CGPoint wbtPoint = btnPoint;
            [UIView animateWithDuration:0.3 animations:^{
                
                for (NSInteger i = [self.otherBtns indexOfObject:btn]+1; i<self.otherBtns.count; i++) {
                    UIButton * nextBt = self.otherBtns[i];
                    nextPoint = nextBt.center;
                    nextBt.center = wbtPoint;
                    wbtPoint = nextPoint;
                }
                
                [self.otherBtns removeObject:btn];
                [self.selectedBtns addObject:btn];
                
                [self calculationOfLineNum];
                self.othersView.contentSize=CGSizeMake(0, selectedLineNum*30);
                
            } completion:^(BOOL finished) {
                self.view.userInteractionEnabled=YES;
            }];
            
            if (button.frame.size.width+button.frame.origin.x+btn.frame.size.width>SCREEN_WIDTH) {
                btn.frame=CGRectMake(0, button.frame.size.height+button.frame.origin.y, 0, button.frame.size.height);
                [UIView animateWithDuration:0.3 animations:^{
                    self.selected.frame=CGRectMake(self.selected.frame.origin.x, self.selected.frame.origin.y, self.selected.frame.size.width, self.selected.frame.size.height+30);
                    self.othersView.frame=CGRectMake(self.othersView.frame.origin.x, self.othersView.frame.origin.y+30, self.othersView.frame.size.width, self.othersView.frame.size.height-30);
                } completion:^(BOOL finished) {
                    
                }];
            }else
            {
                btn.frame=CGRectMake(button.frame.size.width+button.frame.origin.x, button.frame.origin.y, 0, button.frame.size.height);
            }
            
            [self.selected addSubview:btn];
            [UIView animateWithDuration:0.3 animations:^{
                btn.frame=CGRectMake(btn.frame.origin.x, btn.frame.origin.y, button.frame.size.width, button.frame.size.height);
            } completion:^(BOOL finished) {
                self.view.userInteractionEnabled=YES;
            }];
            
            break;
        }
    }
}

#pragma mark -栏目排序
-(void)longPress:(UIGestureRecognizer*)recognizer{
    
    UIButton *recognizerView = (UIButton *)recognizer.view;
    
    CGPoint recognizerPoint = [recognizer locationInView:recognizerView.superview];
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        
        for (UIButton * bt in recognizerView.superview.subviews) {
            if (bt!=recognizerView) {
                bt.userInteractionEnabled = NO;
            }
        }
        [UIView animateWithDuration:0.2 animations:^{
            recognizerView.transform = CGAffineTransformMakeScale(1.3, 1.3);
            recognizerView.alpha = 0.7;
        }];
        [recognizerView.superview bringSubviewToFront:recognizerView];
        
        valuePoint = recognizerView.center;
        endPoint = valuePoint;
        
    }else if(recognizer.state == UIGestureRecognizerStateChanged){
        
        recognizerView.center = recognizerPoint;
        
        for (UIButton * bt in recognizerView.superview.subviews) {
            
            if (CGRectContainsPoint(bt.frame, recognizerView.center)&&bt!=recognizerView&&bt!=self.selectedBtns.firstObject)
            {
                [UIView animateWithDuration:0.2 animations:^{
                    endPoint=bt.center;
                    bt.center=valuePoint;
                    valuePoint=endPoint;
                } completion:^(BOOL finished) {
                    
                    NSInteger fromIndex = [self.selectedBtns indexOfObject:recognizerView];
                    NSInteger toIndex = [self.selectedBtns indexOfObject:bt];
                    [self.categories exchangeObjectAtIndex:fromIndex withObjectAtIndex:toIndex];
                    [self.selectedBtns exchangeObjectAtIndex:fromIndex withObjectAtIndex:toIndex];
                    
                }];
            }
        }
    }else if(recognizer.state == UIGestureRecognizerStateEnded){
        
        for (UIButton * bt in recognizerView.superview.subviews) {
            bt.userInteractionEnabled = YES;
        }
        
        [UIView animateWithDuration:0.2 animations:^{
            recognizerView.transform = CGAffineTransformMakeScale(1.0, 1.0);
            recognizerView.alpha = 1;
            
            recognizerView.center = valuePoint;
        }];
    }
}
#pragma mark -判断是否改变
-(void)onRightButtonTap
{
    BOOL isEqual = self.categories.count == myCategories.count;
    
    if (isEqual) {
        for (int i=0; i<self.categories.count; i++) {
            if (![self.categories[i].pageNum isEqualToString:myCategories[i].pageNum]) {
                isEqual=NO;
                break;
            }
        }
    }
    
    if (!isEqual) [self saveChangeOfCategories];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -保存改变后的数据
-(void)saveChangeOfCategories
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"editClassify" object:[NSArray arrayWithArray:self.categories]];
    dispatch_async(dispatch_get_main_queue(), ^{
        [HUDManager showWithStatus:@"保存中"];
        [[NSFileManager defaultManager] fileExistsAtPath:FILEPATH];
        NSMutableData *data = [[NSMutableData alloc] init];
        NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
        
        [archiver encodeObject:self.categories forKey:ENCODEKEY];
        [archiver finishEncoding];
        
        if ([data writeToFile:FILEPATH atomically:YES]) {
            [HUDManager dismiss];
        }else
        {
            [HUDManager dismissWithError:@"错误" delay:0.5];
        }
    });
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
