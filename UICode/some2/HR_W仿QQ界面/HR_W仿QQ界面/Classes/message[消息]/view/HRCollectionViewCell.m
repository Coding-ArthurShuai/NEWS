//
//  HRCollectionViewCell.m
//  HR_W仿QQ界面
//
//  Created by admin on 16/4/19.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "HRCollectionViewCell.h"
@interface HRCollectionViewCell ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation HRCollectionViewCell

static NSString * const ID = @"tabCell";

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tableView = [[UITableView alloc] initWithFrame:self.bounds];
            //tableView.tableFooterView = [[UIView alloc] init];
       
        [self addSubview:self.tableView];
            //注册
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
            //设置代理
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
            //设置行高
        self.tableView.rowHeight = 50;
        
        
    }
    return self;
}

- (void)setTableView:(UITableView *)tableView{

    _tableView = tableView;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];

    UIImage *image = [UIImage imageNamed:@"4511463d5795eafe7066a68f2aa377a1"];
   
    cell.imageView.image = [self creatImage:image];
    cell.accessoryType = UITableViewCellAccessoryDetailButton;
    return cell;
}



- (UIImage *)creatImage:(UIImage *)iconImage{
        //获取头像
    UIImage *image = iconImage;
        //创建图片上下文
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(50, 50), NO, 0);
        //获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
        //绘制路径
    CGContextAddEllipseInRect(ctx, CGRectMake(0, 0, 50, 50));
        //裁剪
    CGContextClip(ctx);
    [image drawInRect:CGRectMake(0, 0, 50, 50)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    return newImage;

}
@end
