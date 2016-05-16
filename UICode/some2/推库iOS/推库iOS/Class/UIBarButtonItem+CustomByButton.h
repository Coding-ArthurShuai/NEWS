//
//  UIBarButtonItem+CustomByButton.h
//  推库iOS
//
//  Created by Mac on 16/2/24.
//  Copyright © 2016年 YLW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (CustomByButton)


+(instancetype)barButtonItemByCustomButtonWithImage:(NSString *)imageName highlightedImage:(NSString *)highlightName target:(id)target action:(SEL)action;

@end
