//
//  BLHomeViewController.m
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-2-17.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLHomeViewController.h"
#import "RDVTabBarController.h"
#import "RDVTabBarItem.h"
#import "BLScheduleViewController.h"
#import "BLTeamsListViewController.h"
#import "UIColor+Hex.h"
#import "BLRankViewController.h"
#import "BLEntryViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "BLAdvertise.h"
#import "BLCityListViewController.h"
#import "BLSchool.h"
#import "BLSearchViewController.h"


@interface BLHomeViewController ()<CLLocationManagerDelegate,cityListDelegate>
{
    CLLocationManager * clManager;
}
@end

@implementation BLHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"首页";
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundDarkGray"]];
//        [self initNavBar];
    }
    return self;
}

-(void)titleCityName:(NSString *)cityName{
    [self addRightNavBarItem:cityName action:@selector(titleClick)];
    NSString *cityId = [[BLUtils globalCache]stringForKey:@"cityId"];
    [self requestSchool:cityId];
}

-(void)requestSchool:(NSString *)cityId{
    NSString *path = [NSString stringWithFormat:@"school/index/?cityid=%@",cityId];
    [BLSchool globalTimelinePostsWithBlock:^(NSArray *posts, NSError *error) {
        
    } path:path];
}

-(void)titleClick
{
    BLCityListViewController * cityView = [[BLCityListViewController alloc]init];
    cityView.delegate = self;
    [self presentModalViewController:cityView animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    [self initNavBar];
    
//    [self performSelector:@selector(initNavBar) withObject:nil afterDelay:0.0];
    
    [[BLUtils globalCache]setString:@"noNav" forKey:@"navigation"];
    [[BLUtils globalCache]setString:@"per" forKey:@"per"];
    
    [[BLUtils globalCache]setString:@"北京" forKey:@"location"];
    [[BLUtils globalCache]setString:@"北京" forKey:@"GPSLocation"];
    
    float high = 0;
    float y;
    if (ios7) {
        if (iPhone5) {
            y = 568 - 320 - 49;
        }else{
            y = 480 - 320 - 49;
        }
    }else{
        if (iPhone5) {
            y = 548 - 320 - 49;
        }else{
            y = 460 - 320 - 49;
        }
    }
    
    high = (y-199)/2;
    
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, high, 320, 199)];
//    imageView.backgroundColor = [UIColor lightGrayColor];
    imageView.image = [UIImage imageNamed:@"home_log"];
    [self.view addSubview:imageView];
    
    //全国赛程
    UIButton * scheduleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    scheduleButton.frame = CGRectMake(0, y, 160, 160);
    [scheduleButton addTarget:self action:@selector(schedulelistButtonClick) forControlEvents:UIControlEventTouchUpInside];
    scheduleButton.layer.borderWidth = 0.6;
    scheduleButton.layer.borderColor = [[UIColor blackColor] CGColor];
    scheduleButton.backgroundColor = [UIColor colorWithPatternImage:[[UIImage imageNamed:@"purple"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)]];
    [scheduleButton setBackgroundImage:[UIImage imageNamed:@"purple"] forState:UIControlStateNormal];
//    [scheduleButton setBackgroundImage:[UIImage imageNamed:@"button_Click"] forState:UIControlStateHighlighted];
    [self.view addSubview:scheduleButton];
    
    UIImageView * scheduleImage = [[UIImageView alloc]initWithFrame:CGRectMake((160-50)/2, (160-50)/2-20, 50, 50)];
    scheduleImage.image = [UIImage imageNamed:@"quanguosaicheng"];
    [scheduleButton addSubview:scheduleImage];
    
    UILabel * scheduleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 95-20, 160, 50)];
    scheduleLabel.text = @"赛程战况";
    scheduleLabel.textAlignment = UITextAlignmentCenter;
    scheduleLabel.textColor = [UIColor whiteColor];
    scheduleLabel.font = [UIFont boldSystemFontOfSize:17];
    scheduleLabel.backgroundColor = [UIColor clearColor];
    [scheduleButton addSubview:scheduleLabel];
    
    
    //全国球队
    UIButton * teamslistButton = [UIButton buttonWithType:UIButtonTypeCustom];
    teamslistButton.frame = CGRectMake(160, y, 160, 160);
    [teamslistButton addTarget:self action:@selector(teamslistButtonClick) forControlEvents:UIControlEventTouchUpInside];
    teamslistButton.layer.borderWidth = 0.6;
    teamslistButton.layer.borderColor = [[UIColor blackColor] CGColor];
    teamslistButton.backgroundColor = [UIColor colorWithPatternImage:[[UIImage imageNamed:@"blue"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)]];
    [teamslistButton setBackgroundImage:[UIImage imageNamed:@"blue"] forState:UIControlStateNormal];
//    [teamslistButton setBackgroundImage:[UIImage imageNamed:@"button_Click"] forState:UIControlStateHighlighted];
    [self.view addSubview:teamslistButton];
    
    UIImageView * teamslistImage = [[UIImageView alloc]initWithFrame:CGRectMake((160-50)/2, (160-50)/2-20, 50, 50)];
    teamslistImage.image = [UIImage imageNamed:@"quanguoqiudui"];
    [teamslistButton addSubview:teamslistImage];
    
    UILabel * teamslistLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 95-20, 160, 50)];
    teamslistLabel.text = @"参赛球队";
    teamslistLabel.textAlignment = UITextAlignmentCenter;
    teamslistLabel.textColor = [UIColor whiteColor];
    teamslistLabel.font = [UIFont boldSystemFontOfSize:17];
    teamslistLabel.backgroundColor = [UIColor clearColor];
    [teamslistButton addSubview:teamslistLabel];
    
    
    //排行榜
    UIButton * listButton = [UIButton buttonWithType:UIButtonTypeCustom];
    listButton.frame = CGRectMake(0, y + 160, 160, 160);
    [listButton addTarget:self action:@selector(listButtonClick) forControlEvents:UIControlEventTouchUpInside];
    listButton.layer.borderWidth = 0.6;
    listButton.layer.borderColor = [[UIColor blackColor] CGColor];
    listButton.backgroundColor = [UIColor colorWithPatternImage:[[UIImage imageNamed:@"green"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)]];
    [listButton setBackgroundImage:[UIImage imageNamed:@"green"] forState:UIControlStateNormal];
//    [listButton setBackgroundImage:[UIImage imageNamed:@"button_Click"] forState:UIControlStateHighlighted];
    [self.view addSubview:listButton];
    
    UIImageView * listImage = [[UIImageView alloc]initWithFrame:CGRectMake((160-50)/2, (160-50)/2-20, 50, 50)];
    listImage.image = [UIImage imageNamed:@"paihangbang"];
    [listButton addSubview:listImage];
    
    UILabel * listLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 95-20, 160, 50)];
    listLabel.text = @"排行榜";
    listLabel.textAlignment = UITextAlignmentCenter;
    listLabel.textColor = [UIColor whiteColor];
    listLabel.font = [UIFont boldSystemFontOfSize:17];
    listLabel.backgroundColor = [UIColor clearColor];
    [listButton addSubview:listLabel];
    
    
    //比赛报名
    UIButton * entryButton = [UIButton buttonWithType:UIButtonTypeCustom];
    entryButton.frame = CGRectMake(160, y + 160, 160, 160);
    [entryButton addTarget:self action:@selector(entryButtonClick) forControlEvents:UIControlEventTouchUpInside];
    entryButton.layer.borderWidth = 0.6;
    entryButton.layer.borderColor = [[UIColor blackColor] CGColor];
    entryButton.backgroundColor = [UIColor colorWithPatternImage:[[UIImage imageNamed:@"yellow"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)]];
    [entryButton setBackgroundImage:[UIImage imageNamed:@"yellow"] forState:UIControlStateNormal];
//    [entryButton setBackgroundImage:[UIImage imageNamed:@"button_Click"] forState:UIControlStateHighlighted];
    [self.view addSubview:entryButton];
    
    UIImageView * entryImage = [[UIImageView alloc]initWithFrame:CGRectMake((160-50)/2, (160-50)/2-20, 50, 50)];
    entryImage.image = [UIImage imageNamed:@"sousuo"];
    [entryButton addSubview:entryImage];
    
    UILabel * entryLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 95-20, 160, 50)];
    entryLabel.text = @"搜索";
    entryLabel.textAlignment = UITextAlignmentCenter;
    entryLabel.textColor = [UIColor whiteColor];
    entryLabel.font = [UIFont boldSystemFontOfSize:17];
    entryLabel.backgroundColor = [UIColor clearColor];
    [entryButton addSubview:entryLabel];
    
    clManager = [[CLLocationManager alloc]init];
    clManager.delegate = self;
    clManager.distanceFilter = 1000;
    clManager.desiredAccuracy = kCLLocationAccuracyBest;
    [clManager startUpdatingLocation];
    
    [self addNavBar];
    [self addNavBarTitle:@"" action:nil];
    [self addRightNavBarItem:@"北京" action:@selector(titleClick)];

}

#pragma mark - 定位 -
-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error){
        for (CLPlacemark * place in placemarks) {
            
            [[BLUtils globalCache]setString:[NSString stringWithFormat:@"%@",place.administrativeArea] forKey:@"location"];
            
            [[BLUtils globalCache]setString:[NSString stringWithFormat:@"%@",place.administrativeArea] forKey:@"GPSLocation"];
        }
    }];
    
    [clManager stopUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    UIAlertView * alv = [[UIAlertView alloc]initWithTitle:@"定位失败" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alv show];
    
    [clManager stopUpdatingLocation];
}

-(void)schedulelistButtonClick
{
    BLScheduleViewController * scheduleView = [[BLScheduleViewController alloc]initWithNibName:nil bundle:nil];
    scheduleView.title = @"全国赛程";
    scheduleView.condition = @"quanguo";
    [scheduleView requestData:@"quanguo"];
    [self.navigationController pushViewController:scheduleView animated:YES];
//    UINavigationBar *bar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0,320, 49)];
    [[BLUtils appDelegate].tabBarController setTabBarHidden:YES animated:YES];
}

-(void)teamslistButtonClick
{
    BLTeamsListViewController * teamsView = [[BLTeamsListViewController alloc]init];
    [teamsView requestTeamsList];
    [self.navigationController pushViewController:teamsView animated:YES];
    [[BLUtils appDelegate].tabBarController setTabBarHidden:YES animated:YES];
}

-(void)listButtonClick
{
    BLRankViewController * rankingView = [[BLRankViewController alloc]init];
    [self.navigationController pushViewController:rankingView animated:YES];
    [[BLUtils appDelegate].tabBarController setTabBarHidden:YES animated:YES];
}

-(void)entryButtonClick
{
//    BLEntryViewController * entryView = [[BLEntryViewController alloc]init];
//    [self.navigationController pushViewController:entryView animated:YES];
    
    
    BLSearchViewController * entryView = [[BLSearchViewController alloc]init];
    [self.navigationController pushViewController:entryView animated:YES];
    
    [[BLUtils appDelegate].tabBarController setTabBarHidden:YES animated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [[BLUtils appDelegate].tabBarController setTabBarHidden:NO animated:NO];
    self.navigationController.navigationBarHidden = YES;
//    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [[BLUtils globalCache]setString:@"noNav" forKey:@"navigation"];
    [[BLUtils globalCache]setString:@"per" forKey:@"per"];
    [[BLUtils globalCache]setString:@"首页" forKey:@"home"];;
    [[BLUtils globalCache]setString:@"TA的" forKey:@"whose"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
