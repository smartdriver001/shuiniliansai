//
//  BLRankingViewController.m
//  BasketballLeague
//
//  Created by 崔洪禄 on 14-3-4.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLRankingViewController.h"
#import "UIColor+Hex.h"

@interface BLRankingViewController ()
{
    UIScrollView * sv;
    float navHigh;
}

@end

@implementation BLRankingViewController

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
    
    sv = [[UIScrollView alloc]init];
    
//    NSString * nav = [[BLUtils globalCache]stringForKey:@"navigation"];
//    if ([nav isEqualToString:@"noNav"]) {
//        if (ios7) {
//            navHigh = 64;
//        }else{
//            navHigh = 44;
//        }
//        [self addNavBar];
//        [self addNavBarTitle:@"战队等级" action:nil];
//        [self addLeftNavBarItem:@selector(leftButtonClick)];
//        
//        sv.frame = [BLUtils frame];
//    }else{
//        NSString * nav1 = [[BLUtils globalCache]stringForKey:@"per"];
//        if ([nav1 isEqualToString:@"homePer"]) {
//            if (ios7) {
//                navHigh = 64;
//            }else{
//                navHigh = 44;
//            }
//            [self addNavBar];
//            [self addNavBarTitle:@"战队等级" action:nil];
//            [self addLeftNavBarItem:@selector(leftButtonClick)];
//            
//            sv.frame = [BLUtils frame];
//            
//        }else{
//            navHigh = 0;
//            [self addNavText:@"战队等级" action:nil];
//            [self addLeftNavItem:@selector(leftButtonClick)];
//            
//            if (iPhone5) {
//                sv.frame = iPhone5_frame;
//            }else{
//                sv.frame = iPhone4_frame;
//            }
//        }
//    }
    
    
}

-(void)from:(NSString *)from{
    
    NSString *homeString = [[BLUtils globalCache]stringForKey:@"home"];
    
    if (from && ![homeString isEqualToString:@"首页"]) {
        
        if (iPhone5) {
            sv.frame = iPhone5_frame;
        }else{
            sv.frame = iPhone4_frame;
        }
        [self addNavText:@"战队等级" action:nil];
        [self addLeftNavItem:@selector(leftButtonClick)];
        
    }else{
        
        [self addNavBar];
        [self addNavBarTitle:@"战队等级" action:nil];
        [self addLeftNavBarItem:@selector(leftButtonClick)];
        
        sv.frame = [BLUtils frame];
        
    }
    
    sv.contentSize = CGSizeMake(320, 548 - 44);
    sv.backgroundColor = [UIColor colorWithHexString:@"383B44"];
    [self.view addSubview:sv];
    
    [self createRankingView];
    
    [self createExperienceView];
    
    [self createExplanationView];
    
}

-(void)createRankingView
{
    NSArray * array = [NSArray arrayWithObjects:@"等级",@"村代表队",@"乡镇代表队",@"县代表队",@"市代表队",@"省代表队",@"国家代表队", nil];
    for (int i = 0; i < 7; i++) {
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0 + i * 44, 160, 44)];
        label.textAlignment = UITextAlignmentCenter;
        label.text = [array objectAtIndex:i];
        if (i%2 == 0) {
            label.backgroundColor = [UIColor colorWithHexString:@"3D3E43"];
        }else{
            label.backgroundColor = [UIColor colorWithHexString:@"55585F"];
        }
        if (i == 0) {
            label.textColor = [UIColor lightGrayColor];
            label.font = [UIFont systemFontOfSize:15];
        }else{
            label.textColor = [UIColor colorWithHexString:@"FFFFFF"];
            label.font = [UIFont boldSystemFontOfSize:17];
        }
        [sv addSubview:label];
    }
}

-(void)createExperienceView
{
    NSArray * array = [NSArray arrayWithObjects:@"经验值",@"0-100",@"100-200",@"200-300",@"300-400",@"400-500",@"500~", nil];
    for (int i = 0; i < 7; i++) {
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(160, 0 + i * 44, 160, 44)];
        label.textAlignment = UITextAlignmentCenter;
        label.text = [array objectAtIndex:i];
        if (i%2 == 0) {
            label.backgroundColor = [UIColor colorWithHexString:@"36383F"];
        }else{
            label.backgroundColor = [UIColor colorWithHexString:@"3E4149"];
        }
        if (i == 0) {
            label.textColor = [UIColor lightGrayColor];
            label.font = [UIFont systemFontOfSize:15];
        }else{
            label.textColor = [UIColor colorWithHexString:@"FFFFFF"];
            label.font = [UIFont boldSystemFontOfSize:17];
        }
        [sv addSubview:label];
    }
}

-(void)createExplanationView
{
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(10, 44 * 7 + 4, 300, 40)];
    label.textColor = [UIColor colorWithHexString:@"FFFFFF"];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = UITextAlignmentLeft;
    label.font = [UIFont boldSystemFontOfSize:17];
    label.text = @"经验值计算方法";
    [sv addSubview:label];
    
    UILabel * expLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 44*8, 300, 548 - 44*9)];
    expLabel.backgroundColor = [UIColor clearColor];
    expLabel.textColor = [UIColor lightGrayColor];
    expLabel.textAlignment = UITextAlignmentLeft;
    expLabel.font = [UIFont boldSystemFontOfSize:13.2f];
    expLabel.numberOfLines = 0;
    expLabel.text = @"胜一场2个经验值,负一场1个经验值。\n三连胜，额外给1个经验值，即最后为7个经验值；\n四连胜，额外给2个经验值，即最后为11个经验值；\n五连胜，额外给3个经验值，即最后为16个经验值；\n六连胜，额外给4个经验值，即最后为22个经验值；\n七连胜，额外给5个经验值，即最后为29个经验值；\n八连胜，额外给6个经验值，即最后为37个经验值；\n......\n\n";
    [sv addSubview:expLabel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
