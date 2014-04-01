//
//  BLUtils.m
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-2-15.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLUtils.h"
#import "RDVTabBarController.h"
#import "RDVTabBarItem.h"
#import "BLAppDelegate.h"
#import "EGOCache.h"


@implementation BLUtils

+(BLAppDelegate *)appDelegate{
    BLAppDelegate *appDelegate = (BLAppDelegate *)[[UIApplication sharedApplication] delegate];
    return appDelegate;
}

+(EGOCache *)globalCache{
    EGOCache *cache = [EGOCache globalCache];
    return cache;
}

+(void)storeArr:(NSMutableArray *)array key:(NSString *)key{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:array forKey:key];
    [userDefaults synchronize];
}

+(NSMutableArray *)getStoreArr:(NSString *)key{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    return  [userDefaults objectForKey:key];
}


+(UIViewController *)viewControlle:(UIView *)view{
    UIViewController *vc;
    if (ios7) {
        vc = (UIViewController *)view.nextResponder.nextResponder.nextResponder.nextResponder;
    }else{
       vc = (UIViewController *)view.nextResponder.nextResponder.nextResponder;
    }
    return vc;
}

+(void)showMessage:(NSString *)message{
//    if (showMsg) {/
        NSLog(@"%@",message);
//    }
}

+(NSString *)urlEncode:(NSString *)url{
    NSString *encodedValue = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return encodedValue;
}

+(CGRect)frame{
    
    CGRect frame;
    
    if (iPhone5 && ios7) {
        frame = iPhone5_frame_ios7_nav;
    }else if(!iPhone5 && ios7){
        frame = iPhone4_frame_ios7_nav;
    }else if (!iPhone5 && !ios7){
        frame = iPhone4_frame_nav;
    }else if (iPhone5 && !ios7){
        frame = iPhone5_frame_nav;
    }
    
    return frame;
}

+(CGRect)frame1{
    CGRect frame;
    if(ios7 && iPhone5){
        frame = CGRectMake(0, 44, 320, 568 - 44);//[BLUtils frame];
    }else if (ios7 && !iPhone5){
        frame = CGRectMake(0, 44, 320, 480 - 44);
    }else if(!ios7 && iPhone5){
        frame = CGRectMake(0, 44, 320, 548 - 44);
    }else{
        frame = CGRectMake(0, 44, 320, 460 - 44);
    }
    return frame;
}

+(CGRect)frameHasBar{
    CGRect frame;
    
    if (iPhone5) {
        frame = iPhone5_frame;
    }else{
        frame = iPhone4_frame;
    }
    
    return frame;
}

//utf-8
+(NSString *)encode:(NSString *)source{
    return [source stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

@end
