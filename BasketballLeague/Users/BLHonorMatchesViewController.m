//
//  BLHonorMatchesViewController.m
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-3-12.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLHonorMatchesViewController.h"
#import "UIButton+Bootstrap.h"

@interface BLHonorMatchesViewController ()

@end

@implementation BLHonorMatchesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        if (iPhone5) {
            self.view.frame = CGRectMake(0, 0, 280, 548-50);
        }else{
            self.view.frame = CGRectMake(0, 0, 280, 460-50);
        }
        self.view.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self performSelector:@selector(initButtons) withObject:nil afterDelay:0/1];
}

-(void)initButtons{
    
    UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    scroll.contentSize = CGSizeMake(280, _itemsArray.count*44+_itemsArray.count*2);
    
    for (int i=0; i<_itemsArray.count; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, 280, 44);
        [button setTitle:@"分享" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
        [button commitStyle];
        
        [scroll addSubview:button];
    }
    
    
    [self.view addSubview:scroll];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
