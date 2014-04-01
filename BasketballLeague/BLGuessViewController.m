//
//  BLGuessViewController.m
//  BasketballLeague
//
//  Created by ptshan on 14-3-25.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLGuessViewController.h"
#import "BLCityListViewController.h"
#import "BLCityBase.h"
#import "BLCityLists.h"
#import "UIColor+Hex.h"
#import "BLVillage.h"
#import "BLLists.h"
#import "BLScheduleTitleCell.h"
#import "BLScheduleCell.h"
#import "UIImageView+AFNetworking.h"
#import "BLMySingleGameViewController.h"
#import "BLCounty.h"
#import "BLsinglegameViewController.h"
#import "BLDetailRankViewController.h"
#import "BLGuessPrizeViewController.h"
#import "BLGuessScheduleViewController.h"
#import "BLGuessRuleViewController.h"
#import "BLGoldRankViewController.h"

@interface BLGuessViewController (){
    BLAppDelegate *appDelegate;
}
@end

@implementation BLGuessViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title= @"竞猜";
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[BLUtils appDelegate].tabBarController setTabBarHidden:NO animated:NO];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[BLUtils globalCache]setString:@"北京" forKey:@"location"];
    [[BLUtils globalCache]setString:@"北京" forKey:@"GPSLocation"];
    
    [self initView];
}

//创建视图
-(void)initView
{
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    if (iPhone5) {
        scrollView.frame = iPhone5_frame_tab;
        scrollView.contentSize = CGSizeMake(320, 548 - 44-45);
    }else{
        scrollView.frame = iPhone4_frame_tab;
        scrollView.contentSize = CGSizeMake(320, 460 - 44-45);
    }

    int y = 0;
    NSArray *imageNameArray = @[@"pic_竞猜赛程@2x.png",@"pic_奖品@2x.png",@"金币排行_normal@2x.png",@"比赛规则_normal@2x.png"];
    for (int i=0; i<4; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        if (i==2) {
            y = y+11;
        }
        UIImage *image = [UIImage imageNamed:[imageNameArray objectAtIndex:i]];

        [button setBackgroundImage:image forState:UIControlStateNormal];
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
        [scrollView addSubview:button];

        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.userInteractionEnabled = NO;
        imageView.backgroundColor = [UIColor clearColor];
        imageView.image = [UIImage imageNamed:@""];
        imageView.frame = CGRectMake((147.5-47)/2, 25, 47, 47);
        [button addSubview:imageView];

        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 80, 147.5, 32)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = [@[@"",@"",@"金币排行榜",@"规则"] objectAtIndex:i];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = [UIFont boldSystemFontOfSize:17.0f];
        [button addSubview:titleLabel];
        
        if (i==2) {
            button.frame = CGRectMake(10, 12.5+i*135+5*i, 147.5, 130);
            imageView.image = [UIImage imageNamed:@"icon_jinbi.png"];
        }
        else if (i==3){
            button.frame = CGRectMake(10+152.5, 12.5+(135+5)*(i-1), 147.5, 130);
            imageView.image = [UIImage imageNamed:@"icon_guize.png"];
        }
        else{
            button.frame = CGRectMake(10, 12.5+i*135+5*i, 300, 135);
            titleLabel.frame = CGRectMake(10, 12.5+i*135+5*i, 300, 135);
        }
    }
    [self.view addSubview:scrollView];
}

-(void)btnClick:(UIButton *)button
{
    [self performSelector:@selector(push:) withObject:button afterDelay:.0f];
}

-(void)push:(UIButton *)button
{
    UIViewController *viewController;
    if (button.tag == 0){
        viewController = [[BLGuessScheduleViewController alloc] init];
        viewController.title = @"竞猜赛程";
    }
    else if (button.tag == 1) {
        viewController = [[BLGuessPrizeViewController alloc] init];
        viewController.title = @"奖品";
    }
    else if (button.tag == 2) {
        BLGoldRankViewController * dRankView = [[BLGoldRankViewController alloc] init];
        [dRankView setNavTitle:@"金币排行榜"];
        [dRankView requestPaihangbang];
        viewController = dRankView;
//        self.navigationController.navigationBarHidden = YES;
//        [self.navigationController setNavigationBarHidden:YES animated:NO];
    }
    else if (button.tag == 3) {
        viewController = [[BLGuessRuleViewController alloc] init];
        viewController.title = @"规则";
    }
    else{
        return;
    }
    [[BLUtils appDelegate].tabBarController setTabBarHidden:YES animated:YES];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
