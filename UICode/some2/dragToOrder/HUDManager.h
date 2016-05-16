//
//  WSHUD.h
//  WSGear
//
//  Created by 王贺 on 14/12/26.
//  Copyright (c) 2014年 us.hector2. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVProgressHUD.h"

@interface HUDManager : NSObject
+(void)show;
+(void)showWithStatus:(NSString *)status;
+(void)showInfoWithStatus:(NSString *)status;

+(void)showProgress:(float)progress status:(NSString *)status;
+(void)dismiss;
+(void)dismissWithError:(NSString *)error delay:(float)delay;
+(void)dismissWithSuccess:(NSString *)info delay:(float)delay;
+(void)showSysAlert:(NSString *)title
            message:(NSString *)message;
+(void)showSysAlert:(NSString *)title
            message:(NSString *)message
           delegate:(id)delegate;
@end
