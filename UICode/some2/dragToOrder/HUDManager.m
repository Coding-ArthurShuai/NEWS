//
//  WSHUD.m
//  WSGear
//
//  Created by 王贺 on 14/12/26.
//  Copyright (c) 2014年 us.hector2. All rights reserved.
//

#import "HUDManager.h"
#import <BlocksKit/BlocksKit.h>

@implementation HUDManager
static NSTimer *hudTimer;
static int workMode;
+(void)show{
    [SVProgressHUD show];
}
+(void)showInfoWithStatus:(NSString *)status{
    workMode = 1;
    [SVProgressHUD showInfoWithStatus:status maskType:SVProgressHUDMaskTypeGradient];
}
+(void)showWithStatus:(NSString *)status{
    workMode = 1;
    [SVProgressHUD showWithStatus:status maskType:SVProgressHUDMaskTypeGradient];
}
+(void)showProgress:(float)progress status:(NSString *)status{
    workMode = 1;
    [SVProgressHUD showProgress:progress status:status maskType:SVProgressHUDMaskTypeGradient];
}
+(void)dismiss{
    if (workMode == 1) {
        hudTimer = [NSTimer bk_scheduledTimerWithTimeInterval:1 block:^(NSTimer *timer) {
            workMode = 0;
            [self dismiss];
        } repeats:NO];
        return;
    }
    [self stopTimer];
    [SVProgressHUD dismiss];
}
+ (void)stopTimer {
    if (hudTimer != nil) {
        [hudTimer invalidate];
        hudTimer = nil;
    }
}

+(void)dismissWithSuccess:(NSString *)info delay:(float)delay{
    workMode = 2;
    [SVProgressHUD showSuccessWithStatus:info maskType:SVProgressHUDMaskTypeGradient];
    [self stopTimer];
    hudTimer = [NSTimer bk_scheduledTimerWithTimeInterval:3 block:^(NSTimer *timer) {
        workMode = 0;
        [self dismiss];
    } repeats:NO];
}
+(void)dismissWithError:(NSString *)error delay:(float)delay{
    workMode = 2;
    [SVProgressHUD showErrorWithStatus:error maskType:SVProgressHUDMaskTypeGradient];
    [self stopTimer];
    hudTimer = [NSTimer bk_scheduledTimerWithTimeInterval:3 block:^(NSTimer *timer) {
        workMode = 0;
        [self dismiss];
    } repeats:NO];
}



+(void)showSysAlert:(NSString *)title
            message:(NSString *)message
           delegate:(id)delegate{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:title
                                                       message:message
                                                       delegate:delegate
                                                        cancelButtonTitle:@"好的" otherButtonTitles:@"不要", nil];
    [alertView show];
}

+(void)showSysAlert:(NSString *)title
            message:(NSString *)message{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:title
                                                       message:message
                                                      delegate:nil
                                             cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
    [alertView show];
}


@end
