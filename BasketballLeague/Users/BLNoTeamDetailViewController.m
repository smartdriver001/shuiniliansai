//
//  BLNoTeamDetailViewController.m
//  BasketballLeague
//
//  Created by 崔洪禄 on 14-3-6.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLNoTeamDetailViewController.h"
#import "UIColor+Hex.h"

@interface BLNoTeamDetailViewController ()

@end

@implementation BLNoTeamDetailViewController

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
    [self addLeftNavItem:@selector(leftButtonClick)];
    
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(110, 30, 100, 100)];
    imageView.image = [UIImage imageNamed:@"NoRespite"];
    [self.view addSubview:imageView];
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 150, 320, 40)];
    label.text = @"您暂没创建球队也没有加入球队，若你是队长，\n那赶快创建属于你的球队吧！";
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [UIColor lightGrayColor];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:14];
    label.numberOfLines = 0;
    [self.view addSubview:label];
    
    UIButton * createButton = [UIButton buttonWithType:UIButtonTypeCustom];
    createButton.frame = CGRectMake(20, 220, 280, 44);
    [createButton addTarget:self action:@selector(createButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [createButton setBackgroundImage:[UIImage imageNamed:@"redButton_normal"] forState:UIControlStateNormal];
    [createButton setBackgroundImage:[UIImage imageNamed:@"redButton_press"] forState:UIControlStateHighlighted];
    [createButton setTitle:@"创建战队" forState:UIControlStateNormal];
    [createButton setTitleColor:[UIColor colorWithHexString:@"FFFFFF"] forState:UIControlStateNormal];
    [self.view addSubview:createButton];
}

-(void)createButtonClick
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
