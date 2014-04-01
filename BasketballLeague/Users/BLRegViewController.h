//
//  BLRegViewController.h
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-2-20.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//
//手机注册 找回密码 
#import <UIKit/UIKit.h>
#import "BLBaseViewController.h"

@interface BLRegViewController : BLBaseViewController

- (IBAction)protocolAction:(id)sender;
@property(nonatomic)NSString *isNext;
- (IBAction)getVcode:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *agreementButton;

@property (weak, nonatomic) IBOutlet UIButton *selectedButton;
- (IBAction)dimissKeyboard:(id)sender;

@end
