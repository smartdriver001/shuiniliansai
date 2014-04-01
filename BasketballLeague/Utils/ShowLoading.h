//
//  ShowLoading.h
//  product
//
//  Created by 陈庭俊 on 13-7-26.
//  Copyright (c) 2013年 北京三赢伟业科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface ShowLoading : NSObject {
    MBProgressHUD *progress;
}

+(void)showWithMessage:(NSString *)message view:(UIView *)view;
+(void)hideLoading:(UIView *)view;

+(void)showErrorMessage:(NSString *)message view:(UIView *)view;

+(void)showSuccView:(UIView *)view message:(NSString *)message;

@end
