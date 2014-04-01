//
//  BLEntryViewController.m
//  BasketballLeague
//
//  Created by 崔洪禄 on 14-3-9.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLEntryViewController.h"
#import "BLEntry1ViewController.h"

@interface BLEntryViewController ()

@end

@implementation BLEntryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)leftButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self addNavBar];
    [self addNavBarTitle:@"热门比赛" action:nil];
    [self addLeftNavBarItem:@selector(leftButtonClick)];
    
    float high = 44;
    if (ios7) {
        high = 44+20;
    }
    
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, high + 10, 300, 315)];
    imageView.image = [[UIImage imageNamed:@"tableViewCellBlack"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    [self.view addSubview:imageView];
    
    UIImageView * iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, high + 17.5, 290, 97)];
    iconImageView.image = [UIImage imageNamed:@"joinAD"];
    iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:iconImageView];
    
    UIImageView * gzImageView = [[UIImageView alloc]initWithFrame:CGRectMake(7, high + 122.5, 113, 30)];
    gzImageView.image = [UIImage imageNamed:@"ruleStrip"];
    [self.view addSubview:gzImageView];
    
    UILabel * gzLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    gzLabel.backgroundColor = [UIColor clearColor];
    gzLabel.textColor = [UIColor whiteColor];
    gzLabel.textAlignment = UITextAlignmentCenter;
    gzLabel.font = [UIFont systemFontOfSize:17];
    gzLabel.text = @"比赛规则:";
    [gzImageView addSubview:gzLabel];
    
    
    UIButton * entryButton = [UIButton buttonWithType:UIButtonTypeCustom];
    entryButton.frame = CGRectMake(20, high + 255, 280, 44);
    [entryButton setTitle:@"我要报名" forState:UIControlStateNormal];
    [entryButton setBackgroundImage:[[UIImage imageNamed:@"redButton_normal"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)] forState:UIControlStateNormal];
    [entryButton setBackgroundImage:[[UIImage imageNamed:@"redButton_press"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)] forState:UIControlStateHighlighted];
    [entryButton addTarget:self action:@selector(entryButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:entryButton];
}

-(void)entryButtonClick
{
    BLEntry1ViewController * entry1View = [[BLEntry1ViewController alloc]init];
    [self.navigationController pushViewController:entry1View animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
