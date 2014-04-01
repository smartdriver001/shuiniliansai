//
//  BLReadMsgViewController.m
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-2-18.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLReadMsgViewController.h"

@interface BLReadMsgViewController ()

@end

@implementation BLReadMsgViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setBackgroudView:@""];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initLeftButton];
}

-(void)initLeftButton{
    [self addLeftNavItem:@selector(dismiss)];
}

-(void)dismiss{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
