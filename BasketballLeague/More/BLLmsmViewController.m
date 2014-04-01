//
//  BLLmsmViewController.m
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-3-6.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//  联盟说明

#import "BLLmsmViewController.h"
#import "BLLeagueSubViewController.h"

@interface BLLmsmViewController (){
    NSArray *dataSource;
    NSArray *images;
}

@end

@implementation BLLmsmViewController

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
    [self initDatas];
    
    [self addLeftNavItem:@selector(dismiss)];
    
}

-(void)dismiss{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)initDatas{
    dataSource = @[@"奖励制度",@"升级方式"];
    
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    if (iPhone5) {
        scrollView.frame = iPhone5_frame_tab;
        scrollView.contentSize = CGSizeMake(320, 548 - 44-45);
    }else{
        scrollView.frame = iPhone4_frame_tab;
        scrollView.contentSize = CGSizeMake(320, 460 - 44-45);
    }
    
    images = @[@"jlzd",@"shengji"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(15, 20, 280, 44);
    /* 背景图 */
    UIImage *image = [[UIImage imageNamed:@"textBg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    
    for (int i=0; i<dataSource.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button.frame = CGRectMake(20, 20+(i*44+i*2), 280, 44);
        [button setBackgroundImage:image forState:UIControlStateNormal];
        [button addTarget:self action:@selector(push:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
        [scrollView addSubview:button];
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20+14+40, 20+6+(i*32+i*2+i*12), 120, 32)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.text = [dataSource objectAtIndex:i];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = [UIFont boldSystemFontOfSize:17.0f];
        [scrollView addSubview:titleLabel];
        
        UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(266, 20+10+(i*32+i*2+i*12), 25, 25)];
        imageview.image = [UIImage imageNamed:@"arrow@2x"];
        [scrollView addSubview:imageview];
        
        UIImageView *iconimageview = [[UIImageView alloc]initWithFrame:CGRectMake(35, 20+10+(i*32+i*2+i*12), 25, 25)];
        iconimageview.image = [UIImage imageNamed:[images objectAtIndex:i]];
        [scrollView addSubview:iconimageview];
        
    }
    [self.view addSubview:scrollView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)push:(UIButton *)button{
    
    BLLeagueSubViewController *detailViewController = [[BLLeagueSubViewController alloc] initWithNibName:@"BLLeagueSubViewController" bundle:nil];
    detailViewController.title = [dataSource objectAtIndex:button.tag];
    
    [self.navigationController pushViewController:detailViewController animated:YES];
    
}


@end
