//
//  YLWUserLoginCell.m
//  推库iOS
//
//  Created by Mac on 16/2/21.
//  Copyright © 2016年 YLW. All rights reserved.
//

#import "YLWUserLoginCell.h"
#import "YLWUserItemModel.h"
#import "YLWUserMessageModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface YLWUserLoginCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UILabel *NameLabel;

@end

@implementation YLWUserLoginCell

- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle]loadNibNamed:@"YLWUserLoginCell" owner:nil options:nil] lastObject];
    }
    return self;
}

+(instancetype)userLoginCell{

    YLWUserLoginCell *cell =[[[NSBundle mainBundle]loadNibNamed:@"YLWUserLoginCell" owner:nil options:nil] lastObject];
    return cell;

}

- (void)awakeFromNib {
    
    
    
}

-(void)setItemModel:(YLWUserItemModel *)itemModel{

    _itemModel = itemModel;
    if ([YLWUserLoginModel sharedUserLoginModel].isLogin) {
        
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[YLWUserLoginModel sharedUserLoginModel].userInfoModel.profile] placeholderImage:[UIImage imageNamed:itemModel.icon]];
        self.NameLabel.text = [YLWUserLoginModel sharedUserLoginModel].userInfoModel.name;
        
    }
    self.iconImageView.image = [UIImage imageNamed:itemModel.icon];
    self.NameLabel.text = itemModel.name;

}


@end
