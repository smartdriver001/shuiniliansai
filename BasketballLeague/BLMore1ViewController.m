//
//  BLMore1ViewController.m
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-3-5.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLMore1ViewController.h"
#import "BLAboutUsViewController.h"
#import "BLAppDelegate.h"
#import "BLMessageViewController.h"
#import "BLFeedbackViewController.h"
#import "BLLmsmViewController.h"
#import "BLMyMessageViewController.h"

@interface BLMore1ViewController () {
    
    BLAppDelegate *appDelegate ;
    NSArray *dataSource;
    NSArray *images;
}

@end

@implementation BLMore1ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"更多";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    appDelegate = [BLUtils appDelegate];
    
    [self addADNavBar];
    [self initButtons];
}


-(void)initButtons{
    
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    if (iPhone5) {
        scrollView.frame = iPhone5_frame_tab;
        scrollView.contentSize = CGSizeMake(320, 548 - 44-45);
    }else{
        scrollView.frame = iPhone4_frame_tab;
        scrollView.contentSize = CGSizeMake(320, 460 - 44-45);
    }
    
    dataSource = [NSMutableArray array];
    dataSource = @[@"消息",@"关于我们",@"意见反馈",@"评价该软件",@"检查更新"];
    images = @[@"message",@"lmsm",@"aboutUs",@"yjfk",@"comment",@"gengxin"];
    int y = 0;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(15, 20, 280, 44);
    /* 背景图 */
    UIImage *image = [[UIImage imageNamed:@"textBg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    
    for (int i=0; i<dataSource.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        if (i==1) {
            y = y+11;
        }
        button.frame = CGRectMake(20, 20+y+(i*44+i*2), 280, 44);
        [button setBackgroundImage:image forState:UIControlStateNormal];
        [button addTarget:self action:@selector(additions:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
        [scrollView addSubview:button];
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20+14+40, 20+6+y+(i*32+i*2+i*12), 120, 32)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.text = [dataSource objectAtIndex:i];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = [UIFont boldSystemFontOfSize:17.0f];
        [scrollView addSubview:titleLabel];
        
        UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(266, 20+10+y+(i*32+i*2+i*12), 25, 25)];
        imageview.image = [UIImage imageNamed:@"arrow@2x"];
        [scrollView addSubview:imageview];
        
        UIImageView *iconimageview = [[UIImageView alloc]initWithFrame:CGRectMake(35, 20+10+y+(i*32+i*2+i*12), 25, 25)];
        iconimageview.image = [UIImage imageNamed:[images objectAtIndex:i]];
        [scrollView addSubview:iconimageview];
        
    }
    [self.view addSubview:scrollView];
}

-(void)additions:(UIButton *)button{
    
    [self performSelector:@selector(push:) withObject:button afterDelay:.0f];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //    [self performSelector:@selector(showTabViewController) withObject:nil afterDelay:.0f];//.45f 比较合适
    [self showTabViewController];
    NSString *pushMsg = [[BLUtils globalCache]stringForKey:@"push"];
    if (pushMsg.length > 0) {
        [self performSelector:@selector(pushToMSG) withObject:nil afterDelay:1.0];
    }
}

-(void)pushToMSG{
    BLMyMessageViewController *viewController = [[BLMyMessageViewController alloc]initWithNibName:nil bundle:nil];
    viewController.title = @"消息";
    [self.navigationController pushViewController:viewController animated:YES];
    [appDelegate.tabBarController setTabBarHidden:YES animated:YES];
}


-(void)showTabViewController{
    [appDelegate.tabBarController setTabBarHidden:NO animated:NO];
}


-(void)push:(UIButton *)button{
    
    UIViewController *viewController;
    
//    if (button.tag == 1 ) {
//        
//        viewController = [[BLLmsmViewController alloc]initWithNibName:nil bundle:nil];
//        viewController.title = [dataSource objectAtIndex:button.tag];
//        
//    }else
        if (button.tag == 0){
        
//        viewController = [[BLMessageViewController alloc] initWithStyle:UITableViewStylePlain];
        viewController = [[BLMyMessageViewController alloc]initWithNibName:nil bundle:nil];
        
    }else if (button.tag == 1){
        
        viewController = [[BLAboutUsViewController alloc] initWithNibName:@"BLAboutUsViewController" bundle:nil];
        
    }else if (button.tag == 2){
        
        viewController = [[BLFeedbackViewController alloc] initWithNibName:@"BLFeedbackViewController" bundle:nil];
        
    }else if (button.tag == 3){
        
        NSString *evaluateString = [NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@",appstoreID];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:evaluateString]];
        return;
    
    }else if (button.tag == 4){
//        [ShowLoading showErrorMessage:@"开发中..." view:self.view];
//        return;
        
        NSString * url = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@", appstoreID];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
        return;
//        appstoreID
//        viewController = [[BLAboutUsViewController alloc] initWithNibName:nil bundle:nil];
        
    }else{
        
        return;
    }
    
    viewController.title = [dataSource objectAtIndex:button.tag];
    
    [self.navigationController pushViewController:viewController animated:YES];
    [appDelegate.tabBarController setTabBarHidden:YES animated:YES];
    
}

@end
