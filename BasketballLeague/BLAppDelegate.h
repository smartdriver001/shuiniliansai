//
//  BLAppDelegate.h
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-2-17.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RDVTabBarController.h"
#import "BLHomeViewController.h"
#import "WXApi.h"

@interface BLAppDelegate : UIResponder <UIApplicationDelegate,RDVTabBarControllerDelegate,WXApiDelegate,UIAlertViewDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UIViewController *viewController;
@property (strong, nonatomic) BLHomeViewController *homeViewController;


@property (strong, nonatomic) RDVTabBarController *tabBarController;

-(void)setAPTags:(NSString *)uid;
@end
