//
//  BLGoldViewController.m
//  BasketballLeague
//
//  Created by ptshan on 14-3-27.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLGoldViewController.h"
#import "BLInviteFriendsViewController.h"
#import "BLContinuLogViewController.h"
#import "BLDailyShareViewController.h"
#import "BLMatchRewardViewController.h"
#import "UIColor+Hex.h"

@interface BLGoldViewController ()

@end

@implementation BLGoldViewController

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
    
//    [self addNavText:@"金币" action:nil];
    [self addLeftNavItem:@selector(leftButtonClick)];
    
    [self initView];
}

-(void)initView
{
    backgroudView = [[UIView alloc]init];
    if (iPhone5) {
        backgroudView.frame = iPhone5_frame_tab;
    }else{
        backgroudView.frame = iPhone4_frame_tab;
    }
    [self.view addSubview:backgroudView];
    
    goldimageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"我的金币bg.png"]];
    goldimageView.frame = CGRectMake(0, 0, 320, 126);
    goldimageView.userInteractionEnabled= YES;
    goldimageView.backgroundColor = [UIColor clearColor];
    [backgroudView addSubview:goldimageView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 35, 320, 20)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:16];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"当前拥有的金币数为";
    [goldimageView addSubview:label];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 126+15, 310, 22)];
    label2.backgroundColor = [UIColor clearColor];
    label2.textColor = [UIColor whiteColor];
    label2.font = [UIFont systemFontOfSize:16];
    label2.textAlignment = NSTextAlignmentLeft;
    label2.text = @"赚取金币";
    [backgroudView addSubview:label2];
    
    UIImage *image = [[UIImage imageNamed:@"textBg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    for (int i=0; i<4; i++) {
        UIButton * button  = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundImage:image forState:UIControlStateNormal];
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag=i;
        [backgroudView addSubview:button];
        if (i/2==0) {
            button.frame = CGRectMake(10+i*(147.5+5), 121+50+5, 147.5, 130);
        }
        else{
            button.frame = CGRectMake(10+(147.5+5)*(i-2), 121+50+5+(130+5)*1, 147.5, 130);
        }

        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.userInteractionEnabled = NO;
        imageView.backgroundColor = [UIColor clearColor];
        imageView.image = [UIImage imageNamed:[@[@"icon_邀请好友.png",@"icon_连续登录.png",@"icon_分享.png",@"icon_比赛获币.png"] objectAtIndex:i]];
        imageView.frame = CGRectMake((147.5-69)/2, 15, 69, 55);
        [button addSubview:imageView];
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 75, 147.5, 18)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = [@[@"邀请好友",@"连续登录",@"每日分享",@"比赛获币"] objectAtIndex:i];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [button addSubview:titleLabel];
        
        UILabel *_label = [[UILabel alloc]initWithFrame:CGRectMake(0, 95, 147.5, 15)];
        _label.backgroundColor = [UIColor clearColor];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.text = [@[@"送100金币",@"送10金币",@"送10金币",@"获取金币"] objectAtIndex:i];
        _label.textColor = [UIColor colorWithHexString:@"FBB03B"];
        _label.font = [UIFont systemFontOfSize:14.0f];
        [button addSubview:_label];
    }
    
}

-(void)btnClick:(UIButton *)button
{
    UIViewController *viewController;
    if (button.tag==0) {
        viewController =[[BLInviteFriendsViewController alloc] init];
        viewController.title = @"邀请好友";
    }
    else if (button.tag==1) {
        viewController =[[BLContinuLogViewController alloc] init];
        viewController.title = @"连续登录";
    }
    else if (button.tag==2) {
        viewController =[[BLDailyShareViewController alloc] init];
        viewController.title = @"分享奖励";
    }
    else if (button.tag==3) {
        viewController =[[BLMatchRewardViewController alloc] init];
        viewController.title = @"比赛获币";
    }
    [self.navigationController pushViewController:viewController animated:YES];
}

-(void)setGoldStr:(NSString *)goldStr
{
    goldLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, 320, 20)];
    goldLabel.text = goldStr;
    goldLabel.font = [UIFont boldSystemFontOfSize:19];
    goldLabel.backgroundColor = [UIColor clearColor];
    goldLabel.textColor = [UIColor colorWithHexString:@"#fbb03b"];
    goldLabel.textAlignment = NSTextAlignmentCenter;
    [goldimageView addSubview:goldLabel];

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
