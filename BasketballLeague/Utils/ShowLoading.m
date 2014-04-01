//
//  ShowLoading.m
//  product
//
//  Created by 陈庭俊 on 13-7-26.
//  Copyright (c) 2013年 北京三赢伟业科技有限公司. All rights reserved.
//

#import "ShowLoading.h"
#import "MBProgressHUD.h"

@implementation ShowLoading

+(void)showWithMessage:(NSString *)message view:(UIView *)view;
{
    MBProgressHUD *progress = [MBProgressHUD showHUDAddedTo:view animated:YES];
    progress.labelText = message;
}

+(void)hideLoading:(UIView *)view{
    [MBProgressHUD hideHUDForView:view animated:YES];
}

+(void)showErrorMessage:(NSString *)message view:(UIView *)view{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.labelText = message;
    hud.margin = 10.f;
//    hud.yOffset = 150.f;
    hud.removeFromSuperViewOnHide = YES;
    
    [hud hide:YES afterDelay:1.5];

}

+(void)showSuccView:(UIView *)view message:(NSString *)message{
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
	[view addSubview:hud];
	
	hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
	
	// Set custom view mode
	hud.mode = MBProgressHUDModeCustomView;
	
	hud.labelText = message;
	
	[hud show:YES];
	[hud hide:YES afterDelay:1.5];
}


@end
