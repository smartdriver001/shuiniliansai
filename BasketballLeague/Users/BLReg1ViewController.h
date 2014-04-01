//
//  BLReg1ViewController.h
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-2-20.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//
//获取验证码 重置密码
#import <UIKit/UIKit.h>
#import "BLBaseViewController.h"

@interface BLReg1ViewController : BLBaseViewController{
    
    UITextField *resetPwdLabel;
    UITextField *vCodeLabel;
    UILabel *telLabel;
}

@property(nonatomic,copy)NSString *isNext;
@property(nonatomic,strong)NSString *telPhone;

@property (weak, nonatomic) IBOutlet UIButton *validCodeBtn_;
- (IBAction)doAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *buttonText;
@property (weak, nonatomic) IBOutlet UIButton *commitButton;

@end
