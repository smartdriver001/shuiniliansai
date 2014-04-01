//
//  BLBaseViewController.m
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-2-26.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLBaseViewController.h"
#import "UIColor+Hex.h"
#import "BLAdvertise.h"
#import "UIImageView+WebCache.h"
#import "BLCityBase.h"
#import "BLSchool.h"
#import "BLCityLists.h"

@interface BLBaseViewController () {
    UIView *navBarView;
    UIImageView *adView;
    NSMutableArray *urls;
}

@end

@implementation BLBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundDarkGray"]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    urls = [NSMutableArray array];
//    [self requestAD];
    NSData *data = [[BLUtils globalCache]dataForKey:@"city"];
    if (!data) {
        [self requestCity];
    }
}

-(void)requestCity
{
    NSString *path = [NSString stringWithFormat:@"city/"];
    
    [BLCityBase globalTimelinePostsWithBlock:^(NSArray *posts, NSError *error) {
        if (posts.count > 0) {
            BLCityBase *city = [posts objectAtIndex:0];
            if (city.cityListsArray.count > 0) {
                BLCityLists *list = [city.cityListsArray objectAtIndex:0];
                [self requestSchool:list.cityId];
            }
        }
    } path:path];
}

-(void)requestSchool:(NSString *)cityId{
    NSString *path = [NSString stringWithFormat:@"school/index/?cityid=%@",cityId];
    [BLSchool globalTimelinePostsWithBlock:^(NSArray *posts, NSError *error) {
        
    } path:path];
}

-(void)setBackgroudView:(NSString *)image{
    if ([image isEqualToString:@""]) {
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundDarkGray"]];
    }else{
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:image]];
    }
}

-(void)requestAD{
    
    NSString *path = @"focus/index/";
    [BLAdvertise globalTimelinePostsWithBlock:^(NSArray *posts, NSError *error) {
        if (error) {
            return ;
        }else{
            [[BLUtils globalCache]setString:@"11" forKey:@"load"];
            [self initURLS];
            [self addNavBarTitle:@"" action:nil];
            [self addNavBarTitle:@"" andDetailTitle:@"" action:nil];
            [self addADNavBar];
//            [self addNavBarTitle:@"" action:nil];
//            [self addNavBarTitle:@"" andDetailTitle:@"" action:nil];
//            [self addADNavBar];
//            
//            if (posts.count > 0) {
//                BLAdvertise *advertise = [posts objectAtIndex:0];
//                if (advertise.msg == nil) {
//                    for (int i=0; i<posts.count; i++) {
//                        BLAdvertise *advertise = [posts objectAtIndex:i];
//                        [urls addObject:advertise.url];
//                    }
//                    [adView setAnimationImagesWithURLs:[NSArray arrayWithArray:urls]];
//                }else{
//                    
//                }
//            }
        }
    } path:path];
}

- (void)addLeftNavItem:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    if (ios7) {
        btn.frame = CGRectMake(0, 0, 25, 25);
    }else{
        btn.frame = CGRectMake(12, 9.5, 25, 25);
    }
    
    [btn setBackgroundImage:[UIImage imageNamed:@"back_normal@2x"]
                   forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"back_selected@2x"]
                   forState:UIControlStateHighlighted];
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    [self addCustomBtnToNavBar:0 btn:btn];
}

- (void)addLeftNavItemAndTextImg:(NSString *)img Text:(NSString *)text :(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    if ([text isEqualToString:@""]) {
        if (ios7) {
            btn.frame = CGRectMake(0, 0, 25, 25);
        }else{
            btn.frame = CGRectMake(12, 9.5, 25, 25);
        }
        [btn setBackgroundImage:[UIImage imageNamed:img]
                       forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:img]
                       forState:UIControlStateHighlighted];
    }else{
        if (ios7) {
            btn.frame = CGRectMake(0, 0, 36, 25);
        }else{
            btn.frame = CGRectMake(12, 9.5, 30, 25);
        }
        [btn setTitle:text forState:UIControlStateNormal];
        [btn setTitle:text forState:UIControlStateHighlighted];
        [btn setTitleColor:[UIColor colorWithHexString:@"FFFFFF"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    }
    
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    [self addCustomBtnToNavBar:0 btn:btn];
}

- (void)addRightNavItemWithImg:(NSString *)img hImg:(NSString *)hImg action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (ios7) {
        btn.frame = CGRectMake(0, 0, 25, 25);
    }else{
        btn.frame = CGRectMake(20, 9.5, 25, 25);
    }
    [btn setBackgroundImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:hImg] forState:UIControlStateHighlighted];
    
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    [self addCustomBtnToNavBar:1 btn:btn];
}

- (void)addNavTextAndDetailText:(NSString *)text :(NSString *)detailText action:(SEL)action
{
//    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 200, 44);
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 200, 28);
    [btn setTitle:text forState:UIControlStateNormal];
    btn.titleLabel.textAlignment = UITextAlignmentCenter;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    [btn setTitleColor:COLOR_WITH_RGB(190, 215, 30) forState:UIControlStateHighlighted];
    //    btn.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:20];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    btn.titleLabel.numberOfLines = 0;
    
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(0, 24, 200, 14);
    [btn1 setTitle:detailText forState:UIControlStateNormal];
    btn1.titleLabel.textAlignment = UITextAlignmentCenter;

    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    [btn setTitleColor:COLOR_WITH_RGB(190, 215, 30) forState:UIControlStateHighlighted];
    //    btn.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:20];
    btn1.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    btn1.titleLabel.numberOfLines = 0;
    
    if (!ios7) {
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 0)];

        [btn1 setTitleEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 0)];
    }
    
    [button addSubview:btn];
    [button addSubview:btn1];
    [self addCustomBtnToNavBar:2 btn:button];
}

- (void)addNavText:(NSString *)text action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 200, 44);
    [btn setTitle:text forState:UIControlStateNormal];
    btn.titleLabel.textAlignment = UITextAlignmentCenter;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    [btn setTitleColor:COLOR_WITH_RGB(190, 215, 30) forState:UIControlStateHighlighted];
//    btn.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:20];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    btn.titleLabel.numberOfLines = 0;
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [self addCustomBtnToNavBar:2 btn:btn];
}

-(void)addADNavBar{
    
    adView = nil;
    adView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
    adView.animationImages = nil;
    if (urls.count<1 || urls == nil) {
        NSMutableArray *images = [NSMutableArray array];
        for (int i = 1; i <= 3; i ++)
        {
            [images addObject:[UIImage imageNamed:[NSString            stringWithFormat:@"pic%i", i]]];
        }
        adView.animationImages = images;
    }else{
        [adView setAnimationImagesWithURLs:urls];
    }
    adView.animationDuration = 4;
    adView.animationRepeatCount = -1;
    [adView startAnimating];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
    view.backgroundColor = [UIColor clearColor];
    [view addSubview:adView];
    
    self.navigationItem.titleView = view;
    
}

- (void)addNavRightText:(NSString *)text action:(SEL)action{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (ios7) {
        btn.frame = CGRectMake(0, 0, 38, 44);
    }else{
        btn.frame = CGRectMake(0, 0, 60, 44);
    }
    [btn setTitle:text forState:UIControlStateNormal];
//    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];

    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    [btn setTitleColor:COLOR_WITH_RGB(190, 215, 30) forState:UIControlStateHighlighted];
    //    btn.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:20];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    [self addCustomBtnToNavBar:1 btn:btn];
}

- (void)addCustomBtnToNavBar:(NSInteger)position btn:(UIButton *)btn
{
    UIView *view ;
    UIBarButtonItem *item ;
    
    if (!ios7) {
        view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 44)];
        view.backgroundColor = [UIColor clearColor];
        [view addSubview:btn];
        item = [[UIBarButtonItem alloc] initWithCustomView:view];
    }else{
        item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    }
    
    // Add the two buttons together on the left:
    if (position == 0) {
        
        self.navigationItem.leftBarButtonItem = item;
    } else if (position == 1) {
        
        self.navigationItem.rightBarButtonItem = item;
    } else if (position == 2) {
        
        self.navigationItem.titleView = btn;
    }
}

//自定义添加的navigationbar
-(void)addNavBar{
    
    if (navBarView) {
        [navBarView removeFromSuperview];
        navBarView = nil;
    }
    int y = 0;
    if (ios7) {
        y = 20;
    }
    navBarView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 44+y)];
    navBarView.backgroundColor = [UIColor blackColor];
    
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, y, 320, 44)];
    imageview.image = [UIImage imageNamed:@"navigationbar_background"];
    [navBarView addSubview:imageview];
    
    [self.view addSubview:navBarView];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.navigationItem.titleView = nil;
//    navBarView = nil;
//    [navBarView removeFromSuperview];
    [adView stopAnimating]; //停止动画
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self addNavBar];
   
//    [self requestAD];
//    [self initURLS];
//    [self addNavBarTitle:@"" action:nil];
//    [self addNavBarTitle:@"" andDetailTitle:@"" action:nil];
//    [self addADNavBar];
    
    NSString *load = [[BLUtils globalCache]stringForKey:@"load"];
    if ([load isEqualToString:@""] || load == nil) {
        [self requestAD];
    }else{
        [self initURLS];
        [self addNavBarTitle:@"" action:nil];
        [self addNavBarTitle:@"" andDetailTitle:@"" action:nil];
        [self addADNavBar];
    }
    
}

-(void)initURLS{
    NSData *jsonData = [[BLUtils globalCache]dataForKey:@"urlsData"];
    if (jsonData== nil) {
        return;
    }
    NSArray *posts = [BLAdvertise parseJsonToArray:jsonData];
    if (posts.count > 0) {
        BLAdvertise *advertise = [posts objectAtIndex:0];
        if (advertise.msg == nil) {
            [urls removeAllObjects];
            for (int i=0; i<posts.count; i++) {
                BLAdvertise *advertise = [posts objectAtIndex:i];
                [urls addObject:advertise.url];
            }
//            [adView setAnimationImagesWithURLs:[NSArray arrayWithArray:urls]];
        }else{
            
        }
    }
}

//自定义添加的navigationbar leftbar
-(void)addLeftNavBarItem:(SEL)action{
    int y = 0;
    if (ios7) {
        y = 20;
    }
    
    UIView  *view = [[UIView alloc]initWithFrame:CGRectMake(0, y, 60, 44)];
    view.backgroundColor = [UIColor clearColor];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.frame = CGRectMake(17.5, 9.5, 25, 25);
    
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundImage:[UIImage imageNamed:@"back_normal"]
                   forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"back_selected"]
                   forState:UIControlStateHighlighted];
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];

    [navBarView addSubview:view];
}

-(void)addRightNavBarItem:(NSString *)title action:(SEL)action{
    int y = 0;
    if (ios7) {
        y = 20;
    }
    UIButton *tagBtn = (UIButton *)[navBarView viewWithTag:100];
    if (!tagBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = 100;
        btn.frame = CGRectMake(320-60, y, 60, 44);//CGRectMake(17.5, 9.5, 25, 25);
        [btn setBackgroundColor:[UIColor clearColor]];
        [btn setTitle:title forState:UIControlStateNormal];
        
        btn.titleLabel.textAlignment = UITextAlignmentCenter;
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
        [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
        
        [navBarView addSubview:btn];
    }else{
        [tagBtn setTitle:title forState:UIControlStateNormal];
    }
    
}

-(void)addRightNavBarItemImg:(NSString *)img hImg:(NSString *)himg action:(SEL)action{
    int y = 0;
    if (ios7) {
        y = 20;
    }
    
    UIView  *view = [[UIView alloc]initWithFrame:CGRectMake(320-60, y, 60, 44)];
    view.backgroundColor = [UIColor clearColor];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.frame = CGRectMake(17.5, 9.5, 25, 25);
    
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundImage:[UIImage imageNamed:img]
                   forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:himg]
                   forState:UIControlStateHighlighted];
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    
    [navBarView addSubview:view];
}

//自定义添加的navigationbar title
- (void)addNavBarTitle:(NSString *)text action:(SEL)action
{
    int y = 0;
    if (ios7) {
        y = 20;
    }
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(60, 0+y, 200, 44);
    [btn setTitle:text forState:UIControlStateNormal];
    btn.titleLabel.textAlignment = UITextAlignmentCenter;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    [btn setTitleColor:COLOR_WITH_RGB(190, 215, 30) forState:UIControlStateHighlighted];
    //    btn.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:20];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    btn.titleLabel.numberOfLines = 0;
    btn.tag = 13;
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    [navBarView addSubview:btn];
    
    [self addADNavBar2:btn];
}

-(void)addADNavBar2:(UIButton *)button{
//    [adView removeFromSuperview];
    adView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
    adView.animationImages = nil;
    if (urls.count<1) {
        NSMutableArray *images = [NSMutableArray array];
        for (int i = 1; i <= 3; i ++)
        {
            [images addObject:[UIImage imageNamed:[NSString            stringWithFormat:@"pic%i", i]]];
        }
        adView.animationImages = images;
    }else{
        [adView setAnimationImagesWithURLs:urls];
    }
    adView.animationDuration = 4;
    adView.animationRepeatCount = -1;
    [adView startAnimating];
    
    [button addSubview:adView];
}

- (void)addNavBarTitle:(NSString *)text andDetailTitle:(NSString *)dtext action:(SEL)action
{
    for (int i = 10; i < 14; i++) {
        UIButton * Butt = (UIButton *)[navBarView viewWithTag:i];
        [Butt removeFromSuperview];
    }
    
    int y = 0;
    if (ios7) {
        y = 20;
    }
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(60, 0 + y, 200, 44);
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    button.tag = 10;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 200, 28);
    [btn setTitle:text forState:UIControlStateNormal];
    btn.titleLabel.textAlignment = UITextAlignmentCenter;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    [btn setTitleColor:COLOR_WITH_RGB(190, 215, 30) forState:UIControlStateHighlighted];
    //    btn.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:20];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    btn.titleLabel.numberOfLines = 0;
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    btn.tag = 11;


    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(0, 28, 200, 14);
    [btn1 setTitle:dtext forState:UIControlStateNormal];
    btn1.titleLabel.textAlignment = UITextAlignmentCenter;
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    [btn setTitleColor:COLOR_WITH_RGB(190, 215, 30) forState:UIControlStateHighlighted];
    //    btn.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:20];
    btn1.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    btn1.titleLabel.numberOfLines = 0;
    [btn1 addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    btn1.tag = 12;

    [button addSubview:btn];
    [button addSubview:btn1];
    
    [navBarView addSubview:button];
    
    [self addADNavBar2:button];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [adView stopAnimating];
}

@end
