//
//  YLWUserLoginCell.h
//  推库iOS
//
//  Created by Mac on 16/2/21.
//  Copyright © 2016年 YLW. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YLWUserItemModel;
@interface YLWUserLoginCell : UITableViewCell

@property (nonatomic,strong) YLWUserItemModel *itemModel;

+(instancetype)userLoginCell;
@end
