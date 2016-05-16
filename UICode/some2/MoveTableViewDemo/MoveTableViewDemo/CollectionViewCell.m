//
//  CollectionViewCell.m
//  MoveTableViewDemo
//
//  Created by King on 16/4/19.
//  Copyright © 2016年 King. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

- (id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        //self.backgroundColor = [UIColor purpleColor];
        
        self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, CGRectGetWidth(self.frame)-10, CGRectGetWidth(self.frame)-10+20)];
        self.imgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.imgView];
        
        self.text = [[UILabel alloc]initWithFrame:CGRectMake(5,CGRectGetMaxY(self.imgView.frame)-20, CGRectGetWidth(self.frame)-10, 20)];
        self.text.backgroundColor = [UIColor colorWithRed:12/255 green:12/255 blue:12/255 alpha:0.4];
        self.text.textAlignment = NSTextAlignmentCenter;
        self.text.textColor = [UIColor whiteColor];
        [self addSubview:self.text];
    }
    
    return self;
}

@end
