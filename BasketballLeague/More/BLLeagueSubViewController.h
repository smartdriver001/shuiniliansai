//
//  BLLeagueSubViewController.h
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-2-18.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//
//用户使用协议

#import <UIKit/UIKit.h>
#import "BLBaseViewController.h"

@interface BLLeagueSubViewController : BLBaseViewController<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
