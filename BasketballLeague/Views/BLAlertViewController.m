//
//  BLAlertViewController.m
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-3-10.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLAlertViewController.h"
#import "UIButton+Bootstrap.h"


@interface BLAlertViewController ()

@end

@implementation BLAlertViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initViews];
}

-(void)initViews{
    
    [self setBackgroudView:@""];
    [UIImage imageNamed:@"navigationbar_background"];
    
    [_titleBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_background"] forState:UIControlStateNormal];
    [_titleBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_background"] forState:UIControlStateHighlighted];
    
    [_titleBtn setTitle:@"删除图片" forState:UIControlStateNormal];
    
    [_cancelBtn setTitle:@"确定" forState:UIControlStateNormal];
    [_cancelBtn commitStyle];
    
    [_commitBtn setTitle:@"取消" forState:UIControlStateNormal];
    [_commitBtn dangerStyle];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)btnAction:(id)sender {
    [_delegate didClickButton:sender];
}
@end
