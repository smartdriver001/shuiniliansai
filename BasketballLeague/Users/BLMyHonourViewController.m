//
//  BLMyHonourViewController.m
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-3-7.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLMyHonourViewController.h"
#import "UIColor+Hex.h"
#import "UIButton+Bootstrap.h"
#import "BLHonor.h"
#import "UIViewController+MJPopupViewController.h"
#import "BLShareWXViewController.h"
#import "BLHonorMatchesViewController.h"
#import "IBActionSheet.h"
#import "BLSingleHonorViewController.h"
#import "BLErrorView.h"

#define TOP_VIEW  [[UIApplication sharedApplication]keyWindow].rootViewController.view

#define KEY_WINDOW  [[UIApplication sharedApplication]keyWindow]


@interface BLMyHonourViewController ()<DismissModelView,IBActionSheetDelegate> {
    
    NSArray *images;
    NSArray *titles;
    UIButton *commit;
    IBActionSheet *sexAction;
    
    float navHigh;
    
    BLErrorView *errorView ;
}

@end

@implementation BLMyHonourViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setBackgroudView:@""];
//        [self initFrame];
    }
    return self;
}

-(void)initFrame{
    if (iPhone5) {
        self.view.frame = iPhone5_frame_tab;
    }else{
        self.view.frame = iPhone4_frame_tab;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    NSString * nav = [[BLUtils globalCache]stringForKey:@"per"];
//    if ([nav isEqualToString:@"homePer"]) {
//        [self addNavBar];
//        [self addLeftNavBarItem:@selector(dismiss)];
//        [self addRightNavBarItemImg:@"Filter_normal@2x" hImg:@"Filter_selected@2x" action:@selector(filterData)];
//        
//        if (ios7) {
//            navHigh = 64;
//        }else{
//            navHigh = 44;
//        }
//
//        if (iPhone5) {
//            self.view.frame = CGRectMake(0, navHigh, 320, 548 - 44);
//        }else{
//            self.view.frame = CGRectMake(0, navHigh, 320, 460 - 44);
//        }
//        
//    }else{
//        navHigh = 0;
//    }
//    [self addLeftNavItem:@selector(dismiss)];
//    [self addRightNavItemWithImg:@"Filter_normal@2x" hImg:@"Filter_selected@2x" action:@selector(filterData)];
 
//    [self requestData:nil];
    
    
    NSString *home = [[BLUtils globalCache]stringForKey:@"home"];
    NSString *whose = [[BLUtils globalCache]stringForKey:@"whose"];
    
    if ([whose isEqualToString:@"TA的"]) {
        if ([home isEqualToString:@""]) {
            [self addLeftNavItem:@selector(dismiss)];
//            [self addRightNavItemWithImg:@"Filter_normal@2x" hImg:@"Filter_selected@2x" action:@selector(filterData)];
            [self addNavRightText:@"筛选" action:@selector(filterData)];
            [self addNavText:@"我的荣耀" action:nil];
            commit = [UIButton buttonWithType:UIButtonTypeCustom];
            commit.frame = CGRectMake(18, navHigh + 350, 280, 44);
            [commit setTitle:@"分享" forState:UIControlStateNormal];
            [commit addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
            [commit commitStyle];
            [self.view addSubview:commit];
        }else{
            self.view.frame = [BLUtils frame];
            if (ios7) {
                navHigh = 64;
            }else{
                navHigh = 44;
            }
            [self addNavBar];
            [self addNavBarTitle:@"TA的荣耀" action:nil];
            [self addLeftNavBarItem:@selector(dismiss)];
//            [self addRightNavBarItemImg:@"Filter_normal@2x" hImg:@"Filter_selected@2x" action:@selector(filterData)];
            
            [self addRightNavBarItem:@"筛选" action:@selector(filterData)];
        }
        
    }else{
        [self addLeftNavItem:@selector(dismiss)];
//        [self addRightNavItemWithImg:@"Filter_normal@2x" hImg:@"Filter_selected@2x" action:@selector(filterData)];
        [self addNavRightText:@"筛选" action:@selector(filterData)];
        [self addNavText:@"我的荣耀" action:nil];
        
        commit = [UIButton buttonWithType:UIButtonTypeCustom];
        commit.frame = CGRectMake(18, navHigh + 350, 280, 44);
        [commit setTitle:@"分享" forState:UIControlStateNormal];
        [commit addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
        [commit commitStyle];
        [self.view addSubview:commit];
    }

}

-(void)requestData:(NSString *)matchid uid:(NSString *)uid from:(NSString *)from isAll:(BOOL)isAll{
    
    fromString = from;
    
    NSString *path;
    if (matchid && !isAll) {
        path = [NSString stringWithFormat:@"my_glorylist4ios/?uid=%@&matchid=%@",uid,matchid];
    }else{
        myUid = uid;
        path = [NSString stringWithFormat:@"my_glorylist4ios/?uid=%@",uid];
    }
    [ShowLoading showWithMessage:showloading view:self.view];
    [BLHonor globalTimelinePostsWithBlock:^(NSArray *posts, NSError *error) {
        [ShowLoading hideLoading:self.view];
        if (error) {
            [ShowLoading showErrorMessage:@"网络连接失败！" view:self.view];
        }
        if (posts.count > 0) {
            BLHonor *honor = [posts objectAtIndex:0];
            if (honor.msg == nil) {
                myHonors = posts;
                [self initViews:posts];
            }else{
                [self initErrorView:@"暂无数据！"];
//                [ShowLoading showErrorMessage:@"暂无数据！" view:self.view];
            }
        }
    } path:path];
    
}


-(void)initViews:(NSArray *)posts{
    
    UILabel *tipsLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, navHigh + 290, 200, 64)];
    tipsLabel.numberOfLines = 2;
    tipsLabel.backgroundColor = [UIColor clearColor];
    tipsLabel.textColor = [UIColor grayColor];
    tipsLabel.font = [UIFont systemFontOfSize:13.0f];
    tipsLabel.text = @"由于您上时间的努力，力压群雄，恭喜您获得以上的成就。";
    tipsLabel.textAlignment = UITextAlignmentCenter;
    
    [self.view addSubview:tipsLabel];
    
    UIImage *titleImage = [UIImage imageNamed:@"pkBG"];
    
    for (int i=0; i<posts.count; i++) {
        UIImageView *imageView = [[UIImageView alloc]init];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImageView *titleImageView = [[UIImageView alloc]init];
        UILabel *fenLabel = [[UILabel alloc]init];
        fenLabel.backgroundColor = [UIColor clearColor];
        fenLabel.font = [UIFont boldSystemFontOfSize:16.0f];
        fenLabel.textColor = [UIColor colorWithHexString:@"#e4e509"];
        UILabel *fenValueLabel = [[UILabel alloc]init];
        fenValueLabel.backgroundColor = [UIColor clearColor];
        fenValueLabel.font = [UIFont boldSystemFontOfSize:15.0f];
        fenValueLabel.textColor = [UIColor whiteColor];
        
        if (i>=3 && i<=5) {
            titleImageView.frame = CGRectMake(20+8+(60*(i-3)+(i-3)*45), navHigh + 20+200+20, 60, 25);
            fenValueLabel.frame = CGRectMake(20+8+(60*(i-3)+(i-3)*45), navHigh + 20+200+20, 60, 25);
            imageView.frame = CGRectMake(20+(75*(i-3)+(i-3)*30), navHigh + 20+120+20, 75, 75);
            button.frame = CGRectMake(20+(75*(i-3)+(i-3)*30), navHigh + 20+120+20, 75, 75);
            fenLabel.frame = CGRectMake(20+8+(60*(i-3)+(i-3)*45), navHigh + 20+200+20+25, 60, 25);
        }else{
            button.frame = CGRectMake(20+(75*i+i*30), navHigh + 20, 75, 75);
            imageView.frame = CGRectMake(20+(75*i+i*30), navHigh + 20, 75, 75);
            titleImageView.frame = CGRectMake(20+8+(60*i+i*45), navHigh + 20+80, 60, 25);
            fenLabel.frame = CGRectMake(20+8+(60*i+i*45), navHigh + 20+80+25, 60, 25);
            fenValueLabel.frame = CGRectMake(20+8+(60*i+i*45), navHigh + 20+80, 60, 25);
        }
//        fenLabel.text = [titles objectAtIndex:i];
        BLHonor *honor = [posts objectAtIndex:i];
        fenLabel.text = [NSString stringWithFormat:@"%@",honor.cname];
        fenLabel.textAlignment = UITextAlignmentCenter;
        fenValueLabel.textAlignment = UITextAlignmentCenter;
        fenValueLabel.tag = i;
        fenValueLabel.text = [NSString stringWithFormat:@"%@",honor.cnt];
        imageView.image = [UIImage imageNamed:honor.ename];
        titleImageView.image = titleImage;
        button.tag = i;
        [button addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        [self.view addSubview:fenLabel];
        [self.view addSubview:imageView];
        [self.view addSubview:titleImageView];
        [self.view addSubview:fenValueLabel];
        
    }
}

-(void)initErrorView:(NSString *)msg{
    
    NSString *home = [[BLUtils globalCache]stringForKey:@"home"];
    NSString *whose = [[BLUtils globalCache]stringForKey:@"whose"];
    
    errorView = [[BLErrorView alloc]init];
    if ([whose isEqualToString:@"TA的"]) {
        if ([home isEqualToString:@""]) {
            errorView.frame = CGRectMake(0, 0, 320, self.view.frame.size.height);
        }else{
            errorView.frame = CGRectMake(0, 64, 320, self.view.frame.size.height-64);
        }
        
    }else{
        errorView.frame = CGRectMake(0, 0, 320, self.view.frame.size.height);
    }
    errorView.titleLabel.text = [NSString stringWithFormat:@"%@",msg];
    errorView.tag = 12345;
    [self.view addSubview:errorView];
}

-(void)removeErrorView{
    [[self.view viewWithTag:12345]removeFromSuperview];
}

-(void)clickBtn:(UIButton *)btn{
    /*1:得分王、2:篮板王、3:助攻王、
     4:盖帽王、5:抢断王、6:远投王*/
    int type ;
    BLHonor *honor = [myHonors objectAtIndex:btn.tag];
    if ([honor.cname isEqualToString:@"得分王"]) {
        type = 1;
    }else if ([honor.cname isEqualToString:@"篮板王"]){
        type = 2;
    }else if ([honor.cname isEqualToString:@"助攻王"]){
        type = 3;
    }else if ([honor.cname isEqualToString:@"盖帽王"]){
        type = 4;
    }else if ([honor.cname isEqualToString:@"抢断王"]){
        type = 5;
    }else{
        type = 6;
    }
    NSString *path = [NSString stringWithFormat:@"my_singleglory/?uid=%@&honourtype=%d",@"2",type];
    [ShowLoading showWithMessage:showloading view:self.view];
    [BLHonor globalTimelinePostsWithBlock:^(NSArray *posts, NSError *error) {
        [ShowLoading hideLoading:self.view];
        if (error) {
            return ;
        }
        if (posts.count > 0) {
            BLHonor *honor = [posts objectAtIndex:0];
            if (honor.msg == nil) {
                [self pushToSingleHonor:posts];
            }else{
                
            }
        }
        
    } path:path];
}

-(void)pushToSingleHonor:(NSArray *)honors{
    BLSingleHonorViewController *singleHonor = [[BLSingleHonorViewController alloc]initWithNibName:nil bundle:nil];
    singleHonor.honors = honors;
    singleHonor.delegate = self;
    [self presentPopupViewController:singleHonor animationType:MJPopupViewAnimationSlideLeftLeft];
}

- (UIImage *)capture
{
    
//    UIGraphicsBeginImageContextWithOptions(KEY_WINDOW.bounds.size, KEY_WINDOW.opaque, 0.0);
//    UIGraphicsBeginImageContext(self.view.bounds.size);
//    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
//    
//    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
//    
//    UIGraphicsEndImageContext();
    commit.hidden = YES;
    
    if (iPhone5) {
        UIWindow *screenWindow = [[UIApplication sharedApplication] keyWindow];
        UIGraphicsBeginImageContext(screenWindow.frame.size);//全屏截图，包括window
        
        [screenWindow.layer renderInContext:UIGraphicsGetCurrentContext()];
        
        UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        UIImageWriteToSavedPhotosAlbum(viewImage, nil, nil, nil);
        return viewImage;
    }else{
        UIGraphicsBeginImageContextWithOptions(TOP_VIEW.bounds.size, TOP_VIEW.opaque, 0.0);
        [TOP_VIEW.layer renderInContext:UIGraphicsGetCurrentContext()];
        
        UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        return img;
    }
    
}

-(void)dismisModelViewController{
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationSlideLeftLeft];
}

-(void)share{
    
    BLShareWXViewController *share = [[BLShareWXViewController alloc]initWithNibName:@"BLShareWXViewController" bundle:nil];
    UIImage *image = [self screenshot];
    [[BLUtils globalCache]setImage:image forKey:@"weixin"];
    [share initImage:image];
    commit.hidden = NO;
    share.delegate = self;
    [self presentPopupViewController:share animationType:MJPopupViewAnimationSlideLeftLeft];
//    [self sendPhoto];
}

- (UIImage*)screenshot
{
    commit.hidden = YES;
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

-(void)sendPhoto{
   
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"logo114" ofType:@"png"];
//    NSLog(@"filepath :%@",filePath);
//    ext.imageData = [NSData dataWithContentsOfFile:filePath];
    
    //UIImage* image = [UIImage imageWithContentsOfFile:filePath];
//    UIImage* image = [UIImage imageWithData:ext.imageData];
//    ext.imageData = UIImagePNGRepresentation(image);
    
//    UIImage* image = [UIImage imageNamed:@"res5thumb.png"];
    UIImage *image = [self capture];
//    UIImage *image = [self screenshot];
    WXMediaMessage *message = [WXMediaMessage message];
    [message setThumbImage:image];
    
    WXImageObject *ext = [WXImageObject object];
    ext.imageData = UIImageJPEGRepresentation(image, 0.5);//(image);
    
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneTimeline;
    
    [WXApi sendReq:req];
    
    commit.hidden = NO;
}


-(void)dismiss{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)filterData{
    NSString *uid = [[BLUtils globalCache]stringForKey:@"uid"];
    NSString *path = [NSString stringWithFormat:@"getMatchsByUid/?uid=%@",uid];
    [ShowLoading showWithMessage:showloading view:self.view];
    [BLHonor globalTimelinePostsWithBlock:^(NSArray *posts, NSError *error) {
        [ShowLoading hideLoading:self.view];
        if (error) {
            return ;
        }
        if (posts.count > 0) {
            BLHonor *honor = [posts objectAtIndex:0];
            if (honor.msg == nil && honor.mdate != nil) {
                
//                BLHonorMatchesViewController *matches = [[BLHonorMatchesViewController alloc]initWithNibName:nil bundle:nil];
//                matches.itemsArray = posts;
//                [self presentPopupViewController:matches animationType:MJPopupViewAnimationSlideBottomBottom];
                matches = posts;
                [self showMatchesAction:posts];
            }else{
                [ShowLoading showErrorMessage:@"暂无相关数据！" view:self.view];
            }
        }
    } path:path];
}

-(void)showMatchesAction:(NSArray *)buttons{
    
    NSMutableArray *myTitles = [NSMutableArray array];
    for (int i=0; i<buttons.count; i++) {
        BLHonor *honor = [buttons objectAtIndex:i];
        NSString *title = [NSString stringWithFormat:@"%@  %@VS%@",honor.mdate,honor.teamA,honor.teamB];
        [myTitles addObject:title];
    }
    
    sexAction = [[IBActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitlesArray:myTitles];
    [sexAction setButtonBackgroundColor:[UIColor colorWithHexString:@"#55585f"]];
    [sexAction setFont:[UIFont boldSystemFontOfSize:16.0f]];
    [sexAction setButtonTextColor:[UIColor whiteColor]];
    [sexAction setButtonBackgroundColor:[UIColor colorWithHexString:@"#ac3726"] forButtonAtIndex:buttons.count];
    
    [sexAction showInView:self.navigationController.view];
    
}

-(void)actionSheet:(IBActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex >= matches.count) {
        return;
    }
    
    BLHonor *honor = [matches objectAtIndex:buttonIndex];
    
    [self requestData:honor.matchid uid:myUid from:@"" isAll:NO];
    
//    if (buttonIndex == 0) {
//        [self openCamera];
//    }else if (buttonIndex == 1){
//        [self openPics];
//    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
