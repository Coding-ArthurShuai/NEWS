//
//  SXTTabBar.h
//  新浪作业
//
//  Created by ma c on 16/2/19.
//  Copyright © 2016年 SXT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"
@class SXTTabBar;

@protocol SXTTabBarDelegate <NSObject>

@optional
- (void)tabBar:(SXTTabBar *)tabBar selectedIndex:(NSUInteger)index;

@end

@interface SXTTabBar : UIView

@property (weak, nonatomic) id<SXTTabBarDelegate> delegate;

@end
