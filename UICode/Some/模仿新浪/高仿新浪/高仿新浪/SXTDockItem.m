//
//  SXTDockItem.m
//  04-TabBar
//
//  Created by andezhou on 16/1/6.
//  Copyright (c) 2016年 周安德. All rights reserved.
//

#import "SXTDockItem.h"

static CGFloat kImageScale = 0.64f;

@implementation SXTDockItem

#pragma mark -
#pragma mark lifecycle
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 设置文字字体大小
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        // 设置文字居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        // 调整图片
        self.imageView.contentMode = UIViewContentModeCenter;
    }
    return self;
}

// 去掉按钮高亮状态
- (void)setHighlighted:(BOOL)highlighted{}

// 调整文字的frame  contentRect：button的frame
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat pointX = 0;
    CGFloat pointY = contentRect.size.height * kImageScale;
    CGFloat width = contentRect.size.width;
    CGFloat height = contentRect.size.height * (1 - kImageScale);
    return CGRectMake(pointX, pointY, width, height);
}

// 调整图片的frame  contentRect：button的frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat pointX = 0;
    CGFloat pointY = 0;
    CGFloat width = contentRect.size.width;
    CGFloat height = contentRect.size.height * kImageScale;
    return CGRectMake(pointX, pointY, width, height);
}

@end
