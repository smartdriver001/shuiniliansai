//
//  BLMySingleGameViewController.m
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-3-4.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLMySingleGameViewController.h"
#import "BLBaseObject.h"
#import "BLSinglegameTableHeaderView.h"
#import "UIColor+Hex.h"
#import "UIImageView+WebCache.h"
#import "BLData.h"
#import "BLShareWXViewController.h"
#import "UIViewController+MJPopupViewController.h"

@interface BLMySingleGameViewController ()<WXApiDelegate,DismissModelView>
{
    float navHigh;
}
@end

@implementation BLMySingleGameViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"统计";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    [self initViews];
    
}

-(void)dismisModelViewController{
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationSlideLeftLeft];
}

-(void)share{
    
    BLShareWXViewController *share = [[BLShareWXViewController alloc]initWithNibName:@"BLShareWXViewController" bundle:nil];
    UIImage *image = [self screenshot];
    [[BLUtils globalCache]setImage:image forKey:@"weixin"];
    [share initImage:image];
    
    share.delegate = self;
    [self presentPopupViewController:share animationType:MJPopupViewAnimationSlideLeftLeft];
}

- (UIImage*)screenshot
{
    // Create a graphics context with the target size
    // On iOS 4 and later, use UIGraphicsBeginImageContextWithOptions to take the scale into consideration
    // On iOS prior to 4, fall back to use UIGraphicsBeginImageContext
    CGSize imageSize = [[UIScreen mainScreen] bounds].size;
    imageSize.height = imageSize.height-20;
    if (NULL != UIGraphicsBeginImageContextWithOptions)
        UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    else
        UIGraphicsBeginImageContext(imageSize);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Iterate over every window from back to front
    for (UIWindow *window in [[UIApplication sharedApplication] windows])
    {
        if (![window respondsToSelector:@selector(screen)] || [window screen] == [UIScreen mainScreen])
        {
            // -renderInContext: renders in the coordinate space of the layer,
            // so we must first apply the layer's geometry to the graphics context
            CGContextSaveGState(context);
            // Center the context around the window's anchor point
            //            CGContextTranslateCTM(context, [window center].x, [window center].y);
            CGContextTranslateCTM(context, [window center].x, [window center].y - 20);
            // Apply the window's transform about the anchor point
            CGContextConcatCTM(context, [window transform]);
            // Offset by the portion of the bounds left of and above the anchor point
            CGContextTranslateCTM(context,
                                  -[window bounds].size.width * [[window layer] anchorPoint].x,
                                  -[window bounds].size.height * [[window layer] anchorPoint].y);
            
            // Render the layer hierarchy to the current context
            [[window layer] renderInContext:context];
            
            // Restore the context
            CGContextRestoreGState(context);
        }
    }
    
    // Retrieve the screenshot image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

-(void)dismiss{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)initViews{
    
    iconAImageView = [[UIImageView alloc]initWithFrame:CGRectMake(30, navHigh + 10, 50, 50)];
    [self.view addSubview:iconAImageView];
    
    iconBImageView = [[UIImageView alloc]initWithFrame:CGRectMake(320 - 30 - 50, navHigh + 10, 50, 50)];
    [self.view addSubview:iconBImageView];
    
    nameALabel = [[UILabel alloc]initWithFrame:CGRectMake(10, navHigh + 65, 90, 25)];
    nameALabel.textAlignment = UITextAlignmentCenter;
    nameALabel.backgroundColor = [UIColor clearColor];
    nameALabel.textColor = [UIColor colorWithHexString:@"FFFFFF"];
    nameALabel.font = [UIFont boldSystemFontOfSize:13];
    [self.view addSubview:nameALabel];
    
    nameBLabel = [[UILabel alloc]initWithFrame:CGRectMake(320 - 20 - 70-10, navHigh + 65, 90, 25)];
    nameBLabel.textAlignment = UITextAlignmentCenter;
    nameBLabel.backgroundColor = [UIColor clearColor];
    nameBLabel.textColor = [UIColor colorWithHexString:@"FFFFFF"];
    nameBLabel.font = [UIFont boldSystemFontOfSize:13];
    [self.view addSubview:nameBLabel];
    
    scoreLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, navHigh + 10, 160, 50)];
    scoreLabel.textAlignment = UITextAlignmentCenter;
    scoreLabel.font = [UIFont systemFontOfSize:28];
    scoreLabel.backgroundColor = [UIColor clearColor];
    scoreLabel.textColor = [UIColor colorWithHexString:@"FF0000"];
    [self.view addSubview:scoreLabel];
    
    scoreLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(90, navHigh + 65, 140, 25)];
    scoreLabel1.textAlignment = UITextAlignmentCenter;
    scoreLabel1.font = [UIFont boldSystemFontOfSize:13];
    scoreLabel1.backgroundColor = [UIColor clearColor];
    scoreLabel1.textColor = [UIColor colorWithHexString:@"FBB03B"];
    [self.view addSubview:scoreLabel1];
    
    NSArray * array = [NSArray arrayWithObjects:@"得分",@"篮板",@"助攻",@"远投",@"抢断",@"盖帽", nil];
    
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, navHigh + 100, 320, 30)];
    view1.backgroundColor = [UIColor colorWithHexString:@"#55585f"];
    
    for (int i = 0; i < 6; i++) {
        UILabel * statisticsLabel = [[UILabel alloc]initWithFrame:CGRectMake(i*(320/6.0), 0, 320/6.0, 30)];
        statisticsLabel.backgroundColor = [UIColor clearColor];
        statisticsLabel.textColor = [UIColor colorWithHexString:@"#ffff00"];
        statisticsLabel.font = [UIFont systemFontOfSize:14];
        statisticsLabel.textAlignment = UITextAlignmentCenter;
        statisticsLabel.text = [array objectAtIndex:i];
        [view1 addSubview:statisticsLabel];
    }
    [self.view addSubview:view1];
    
    UIView *myTitleView2 = [[UIView alloc]initWithFrame:CGRectMake(0, navHigh + 100+30, 320, 30)];
    myTitleView2.backgroundColor = [UIColor colorWithHexString:@"#36383f"];
    myTitleView2.tag = 1321;
    [self.view addSubview:myTitleView2];
    
    
    UIImage *image = [[UIImage imageNamed:@"pkBG"]resizableImageWithCapInsets:UIEdgeInsetsMake(0, 30, 0, 30)];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, navHigh + 180, 290, 70)];
    imageView.image = image;
    
    UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(15, navHigh + 180+75, 290, 70)];
    imageView1.image = image ;
    
    [self.view addSubview:imageView];
    [self.view addSubview:imageView1];
    
    UIImageView *iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(2.5, 2.5, 65, 65)];
    iconImageView.image = [UIImage imageNamed:@"singlegame@2x"];
    [imageView addSubview:iconImageView];
    
    UIImageView *iconImageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(2.5, 2.5, 65, 65)];
    iconImageView1.image = [UIImage imageNamed:@"singlegame1@2x"];
    
    [imageView1 addSubview:iconImageView1];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 8, 40, 32)];
    label.backgroundColor = [UIColor clearColor];
    label.text = @"PK";
    label.textAlignment = UITextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:20.0f];
    label.textColor = [UIColor whiteColor];
    
    UILabel *label11 = [[UILabel alloc]initWithFrame:CGRectMake(12, 8, 40, 32)];
    label11.backgroundColor = [UIColor clearColor];
    label11.text = @"PK";
    label11.textAlignment = UITextAlignmentCenter;
    label11.font = [UIFont boldSystemFontOfSize:20.0f];
    label11.textColor = [UIColor whiteColor];
    
    [iconImageView addSubview:label11];
    [iconImageView1 addSubview:label];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(8, 25, 60, 32)];
    label1.backgroundColor = [UIColor clearColor];
    label1.text = @"竞争对手";
    label1.font = [UIFont boldSystemFontOfSize:12.0f];
    label1.textColor = [UIColor whiteColor];
    [iconImageView addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(8, 25, 60, 32)];
    label2.backgroundColor = [UIColor clearColor];
    label2.text = @"本队球员";
    label2.font = [UIFont boldSystemFontOfSize:12.0f];
    label2.textColor = [UIColor whiteColor];
    [iconImageView1 addSubview:label2];
    
    duishouLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 10, 192, 50)];
    duishouLabel.backgroundColor = [UIColor clearColor];
    duishouLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    duishouLabel.numberOfLines = 2;
    duishouLabel.textColor = [UIColor whiteColor];
    
    [imageView1 addSubview:duishouLabel];
    
    benduiLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 10, 192, 50)];
    benduiLabel.backgroundColor = [UIColor clearColor];
    benduiLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    benduiLabel.numberOfLines = 2;
    benduiLabel.textColor = [UIColor whiteColor];
    
    [imageView addSubview:benduiLabel];
}

-(void)initData:(BLData *)data{
    scoreLabel1.text = [NSString stringWithFormat:@"%@",data.time];
    scoreLabel.text = [NSString stringWithFormat:@"%@ : %@",data.scoreA,data.scoreB];
    nameBLabel.text = [NSString stringWithFormat:@"%@",data.teamNameB];
    nameALabel.text = [NSString stringWithFormat:@"%@",data.teamNameA];
    [iconBImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",data.iconB]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    [iconAImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",data.iconA]] placeholderImage:[UIImage imageNamed:@"placeholder"]];

    UIView *titleView2 = [self.view viewWithTag:1321];
    NSArray * array = [NSArray arrayWithObjects:data.defen,data.lanban,data.zhugong,data.yuantou,data.qiangduan,data.gaimao, nil];
    for (int i=0; i<array.count; i++) {
        UILabel * statisticsLabel = [[UILabel alloc]initWithFrame:CGRectMake(i*(320/6.0), 0, 320/6.0, 30)];
        statisticsLabel.textAlignment = UITextAlignmentCenter;
        statisticsLabel.font = [UIFont systemFontOfSize:14];
        statisticsLabel.textColor = [UIColor whiteColor];
        statisticsLabel.backgroundColor = [UIColor clearColor];
        statisticsLabel.text = [NSString stringWithFormat:@"%@",[array objectAtIndex:i]];
        NSLog(@"%@",[array objectAtIndex:i]);
        [titleView2 addSubview:statisticsLabel];
    }
    
    benduiLabel.text = data.pkMsg1;
    duishouLabel.text = data.pkMsg2;
    
}

-(void)requestSingleGame:(NSString *)matchid uid:(NSString *)uid from:(NSString *)from;
{
    
    NSString *home = [[BLUtils globalCache]stringForKey:@"home"];
    NSString *whose = [[BLUtils globalCache]stringForKey:@"whose"];

    if ([whose isEqualToString:@"TA的"]) {
        if ([home isEqualToString:@""]) {
            navHigh = 0;
            [self addLeftNavItem:@selector(dismiss)];
        }else{
            if (ios7) {
                navHigh = 64;
            }else{
                navHigh = 44;
            }
            [self addNavBar];
            [self addNavBarTitle:@"统计" action:nil];
            [self addLeftNavBarItem:@selector(dismiss)];
        }
        
    }else{
        navHigh = 0;
        [self addLeftNavItem:@selector(dismiss)];
        [self addRightNavItemWithImg:@"share_normal" hImg:@"share_press" action:@selector(share)];
    }

    [self initViews];

    NSString *path = [NSString stringWithFormat:@"my_singlegame/?id=%d&uid=%@",[matchid intValue],uid];
    
    [ShowLoading showWithMessage:showloading view:self.view];
    [BLBaseObject globalTimelinePostsWithBlock:^(NSArray *posts, NSError *error) {
        
        [ShowLoading hideLoading:self.view];
        
        if (error) {
            
        }
        if (posts.count > 0) {
            BLBaseObject *base = [posts objectAtIndex:0];
            if ([base.msg isEqualToString:@"succ"]) {
                
                NSLog(@"%@",base.data.teamA.userArray);
                [self initData:base.data];
                
            }else{
                [ShowLoading showErrorMessage:base.msg view:self.view];
            }
        }
        
    } path:path];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
