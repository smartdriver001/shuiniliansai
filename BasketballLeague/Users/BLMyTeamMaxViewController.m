//
//  BLMyTeamMaxViewController.m
//  BasketballLeague
//
//  Created by 崔洪禄 on 14-3-3.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLMyTeamMaxViewController.h"
#import "BLMyTeamMaxBase.h"
#import "BLMyTeamMax.h"
#import "UIColor+Hex.h"
#import "UIImageView+WebCache.h"
#import "BLMyViewController.h"

@interface BLMyTeamMaxViewController ()
{
    float navHigh;
}
@property(nonatomic,strong)NSMutableArray * teamMaxArray;

@end

@implementation BLMyTeamMaxViewController

@synthesize teamMaxArray;

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
    self.teamMaxArray = [NSMutableArray array];
    
//    NSString * nav = [[BLUtils globalCache]stringForKey:@"navigation"];
//    if ([nav isEqualToString:@"noNav"]) {
//        if (ios7) {
//            navHigh = 64;
//        }else{
//            navHigh = 44;
//        }
//        [self addNavBar];
//        [self addNavBarTitle:@"各项最高" action:nil];
//        [self addLeftNavBarItem:@selector(leftButtonClick)];
//        
//    }else{
//        NSString * nav1 = [[BLUtils globalCache]stringForKey:@"per"];
//        
//        if ([nav1 isEqualToString:@"homePer"]) {
//            if (ios7) {
//                navHigh = 64;
//            }else{
//                navHigh = 44;
//            }
//            [self addNavBar];
//            [self addNavBarTitle:@"各项最高" action:nil];
//            [self addLeftNavBarItem:@selector(leftButtonClick)];
//        }else{
//            navHigh = 0;
//            [self addNavText:@"各项最高" action:nil];
//            [self addLeftNavItem:@selector(leftButtonClick)];
//        }
//        
//    }
    
//    [self performSelector:@selector(requestMyTeamMax) withObject:nil afterDelay:0.2];
}

-(void)requestMyTeamMax:(NSString *)teamid from:(NSString *)from
{
    NSString *homeString = [[BLUtils globalCache]stringForKey:@"home"];
    
    if (from && [homeString isEqualToString:@""]) {
        [self addNavText:@"各项最高" action:nil];
        [self addLeftNavItem:@selector(leftButtonClick)];
        
    }else{
        [self addNavBar];
        [self addNavBarTitle:@"各项最高" action:nil];
        [self addLeftNavBarItem:@selector(leftButtonClick)];
    }
    
    NSString *path = [NSString stringWithFormat:@"my_teammax/?teamid=%@",teamid];
    
    [ShowLoading showWithMessage:showloading view:self.view];
    [BLMyTeamMaxBase globalTimelinePostsWithBlock:^(NSArray *posts, NSError *error) {
        
        [ShowLoading hideLoading:self.view];
        
        if (error) {
            
        }
        if (posts.count > 0) {
            BLMyTeamMaxBase *base = [posts objectAtIndex:0];
            if ([base.msg isEqualToString:@"succ"]) {
                
                teamMaxArray = [NSMutableArray arrayWithArray:base.myTeamMaxArray];
                if (teamMaxArray.count < 1) {
                    [ShowLoading showErrorMessage:@"暂无数据" view:self.view];
                }else{
                    [self performSelector:@selector(crateTeamMaxView:) withObject:from afterDelay:0.3];
                }
                
            }else{
                [ShowLoading showErrorMessage:base.msg view:self.view];
            }
        }
        
    } path:path];
}
            
-(void)crateTeamMaxView:(NSString *)from
{
    UIScrollView * sc = [[UIScrollView alloc]init];
//    NSString * nav = [[BLUtils globalCache]stringForKey:@"navigation"];
//    if ([nav isEqualToString:@"noNav"]) {
//        sc.frame = [BLUtils frame];
//    }else{
//        NSString * nav1 = [[BLUtils globalCache]stringForKey:@"per"];
//        
//        if ([nav1 isEqualToString:@"homePer"]) {
//            sc.frame = [BLUtils frame];
//        }else{
//            if (iPhone5) {
//                sc.frame = iPhone5_frame;
//            }else{
//                sc.frame = iPhone4_frame;
//            }
//        }
//        
//    }
    NSString *homeString = [[BLUtils globalCache]stringForKey:@"home"];
    
    if (from && [homeString isEqualToString:@""]) {
        if (iPhone5) {
            sc.frame = iPhone5_frame;
        }else{
            sc.frame = iPhone4_frame;
        }
    }else{
        sc.frame = [BLUtils frame];
    }
    sc.backgroundColor = [UIColor clearColor];
    [self.view addSubview:sc];
    
    sc.contentSize = CGSizeMake(320, 10 + (teamMaxArray.count/2 + teamMaxArray.count%2)*185);
    NSLog(@"%f",sc.contentSize.height);
    for (int i = 0; i < teamMaxArray.count; i++) {
        BLMyTeamMax * teamMax = [teamMaxArray objectAtIndex:i];
        
//        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(20 + i%2 * 145, 10 + i/2*185, 135, 175)];
        UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
        view.frame = CGRectMake(20 + i%2 * 145, 10 + i/2*185, 135, 175);
        [view addTarget:self action:@selector(gotoMyView:) forControlEvents:UIControlEventTouchUpInside];
        view.tag = i;
        [view setBackgroundColor:[UIColor colorWithHexString:@"27292E"]];
        view.layer.cornerRadius = 2;
        [sc addSubview:view];
        
        UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 135, 30)];
        titleLabel.textAlignment = UITextAlignmentCenter;
        titleLabel.font = [UIFont boldSystemFontOfSize:16];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.text = [NSString stringWithFormat:@"%@王",teamMax.type];
        titleLabel.textColor = [UIColor colorWithHexString:@"FBB03B"];
        [view addSubview:titleLabel];
        
        UIImageView * photoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 30, 115, 115)];
        [photoImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",teamMax.icon]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        [view addSubview:photoImageView];
        
        UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 145, 70, 30)];
        nameLabel.textAlignment = UITextAlignmentLeft;
        nameLabel.font = [UIFont boldSystemFontOfSize:16];
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.text = [NSString stringWithFormat:@"%@",teamMax.name];
        nameLabel.textColor = [UIColor colorWithHexString:@"FFFFFF"];
        [view addSubview:nameLabel];
        
        UILabel * scoreLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 145, 45, 30)];
        scoreLabel.textAlignment = UITextAlignmentRight;
        scoreLabel.font = [UIFont systemFontOfSize:16];
        scoreLabel.backgroundColor = [UIColor clearColor];
        scoreLabel.text = [NSString stringWithFormat:@"%@",teamMax.num];
        scoreLabel.textColor = [UIColor colorWithHexString:@"FF0000"];
        [view addSubview:scoreLabel];
    }
}

-(void)gotoMyView:(UIButton *)button{
    BLMyTeamMax * teamMax = [teamMaxArray objectAtIndex:button.tag];
    BLMyViewController *myViewController = [[BLMyViewController alloc]initWithNibName:nil bundle:nil];
    [myViewController setVisitid:teamMax.uid andName:teamMax.name from:@""];
    [self.navigationController pushViewController:myViewController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
