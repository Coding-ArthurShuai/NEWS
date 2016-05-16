//
//  UIBarButtonItem+CustomByButton.m
//  推库iOS
//
//  Created by Mac on 16/2/24.
//  Copyright © 2016年 YLW. All rights reserved.
//

#import "UIBarButtonItem+CustomByButton.h"

@implementation UIBarButtonItem (CustomByButton)

+(instancetype)barButtonItemByCustomButtonWithImage:(NSString *)imageName highlightedImage:(NSString *)highlightName target:(id)target action:(SEL)action{

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highlightName] forState:UIControlStateDisabled];
    btn.bounds = CGRectMake(0, 0, 38, 38);
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];

    return barButtonItem;
}


@end
