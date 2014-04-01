//
//  BLUtils.h
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-2-15.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BLAppDelegate.h"
#import "EGOCache.h"
#import "BLBaseViewController.h"

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define ios7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0f ? YES : NO )

#define iPhone5_frame CGRectMake(0, 0, 320, 548 - 44)
#define iPhone4_frame CGRectMake(0, 0, 320, 460 - 44)

#define iPhone5_frame_nav CGRectMake(0, 44, 320, 548 - 44)
#define iPhone4_frame_nav CGRectMake(0, 44, 320, 460 - 44)

#define iPhone5_frame_ios7_nav CGRectMake(0, 64, 320, 548 - 44)
#define iPhone4_frame_ios7_nav CGRectMake(0, 64, 320, 460 - 44)

#define iPhone5_frame_tab CGRectMake(0, 0, 320, 548 - 44-49)
#define iPhone4_frame_tab CGRectMake(0, 0, 320, 460 - 44-49)

#define showloading @"请稍后..."


@interface BLUtils : NSObject

+(BLAppDelegate *)appDelegate;
+(EGOCache *)globalCache;

+(UIViewController *)viewControlle:(UIView *)view;

+(void)showMessage:(NSString *)message;

+(NSString *)urlEncode:(NSString *)url;

+(CGRect)frame;

+(CGRect)frameHasBar;

+(CGRect)frame1;

+(NSString *)encode:(NSString *)source;

+(void)storeArr:(NSMutableArray *)array key:(NSString *)key;

+(NSMutableArray *)getStoreArr:(NSString *)key;
@end
