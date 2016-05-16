//
//  SXTTabBar.m
//  新浪作业
//
//  Created by ma c on 16/2/19.
//  Copyright © 2016年 SXT. All rights reserved.
//

#import "SXTTabBar.h"
#import "SXTDockItem.h"

static NSUInteger kTag = 100;

@interface SXTTabBar ()

// 全局button
@property (strong, nonatomic) SXTDockItem *selectedBtn;
// 存放图片和文字的数组
@property (strong, nonatomic) NSArray *dataList;

@end

@implementation SXTTabBar

#pragma mark -
#pragma mark init methods
- (NSArray *)dataList
{
    if (!_dataList) {
        NSString *file = [[NSBundle mainBundle] pathForResource:@"TabBarPlist" ofType:@"plist"];
        _dataList = [NSArray arrayWithContentsOfFile:file];
    }
    return  _dataList;
}

#pragma mark -
#pragma mark lifecycle
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 设置背景颜色
        self.backgroundColor = [UIColor clearColor];
        // 获取button的宽度
        CGFloat width = kViewWidth / self.dataList.count;
        for (NSUInteger idx = 0; idx < self.dataList.count; idx++) {
            // 获取存放图片和文字的字典
            NSDictionary *dict = self.dataList[idx];
            // 获取btn的X坐标
            CGFloat pointX = width * idx;
            // 初始化一个btn
            SXTDockItem *btn = [SXTDockItem buttonWithType:UIButtonTypeCustom];
            // 设置btn的frame
            btn.frame = CGRectMake(pointX, 0, width, CGRectGetHeight(self.frame));
            
            // 设置文字
            [btn setTitle:dict[@"title"] forState:UIControlStateNormal];
            // 设置文字颜色
            [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            // 设置图片
            [btn setImage:[UIImage imageNamed:dict[@"normal"]] forState:UIControlStateSelected];
            [btn setImage:[UIImage imageNamed:dict[@"selected"]] forState:UIControlStateNormal];
            
            // 添加响应事件
            [btn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            
            // 设置tag
            btn.tag = kTag + idx;
            
            // 第一个按钮默认选中
            if (!idx) {
                self.selectedBtn = btn;
                btn.selected = YES;
            }
            
            if (idx == 1) {
                UIView *view = [[UIView alloc] initWithFrame:CGRectMake(40, 5, 13, 13)];
                UILabel *label = [[UILabel alloc] initWithFrame:view.bounds];
                view.backgroundColor = [UIColor redColor];
                label.text = @"2";
                label.textColor = [UIColor whiteColor];
                label.font = [UIFont systemFontOfSize:10];
                label.textAlignment = NSTextAlignmentCenter;
                view.layer.cornerRadius = view.frame.size.width/2;
                view.clipsToBounds = YES;
                [btn addSubview:view];
                [view addSubview:label];
            }
            
            if (idx == 2) {
                btn.contentEdgeInsets = UIEdgeInsetsMake(-25, 0, 0, 0);
                
            }
            
            [self addSubview:btn];
        }
        
    }
    return self;
}

// 按钮响应事件方法
- (void)buttonAction:(SXTDockItem *)btn
{
    // 把以前设置的button设为不选中
    self.selectedBtn.selected = NO;
    // 把当前选中的btn设为选中
    btn.selected = YES;
    // 把当前选中的btn给全局button
    self.selectedBtn = btn;
    
    
    
    if (btn.tag == kTag + 2) {
        NSLog(@"添加成功");
    }
    
    // delegate
    if ([self.delegate respondsToSelector:@selector(tabBar:selectedIndex:)]) {
        [self.delegate tabBar:self selectedIndex:btn.tag - kTag];
    }
    
}


@end











