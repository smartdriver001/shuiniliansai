//
//  BLAppDelegate.m
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-2-17.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLAppDelegate.h"

#import "BLViewController.h"
#import "BLHomeViewController.h"
#import "BLMore1ViewController.h"
#import "BLMyViewController.h"
#import "MLNavigationController.h"
#import "RDVTabBarController.h"
#import "RDVTabBarItem.h"
#import "WXApi.h"
#import "APService.h"
#import "BLMyMessageViewController.h"
#import "BLAdvertise.h"
#import "MobClick.h"


@implementation BLAppDelegate


- (void)umengTrack {
    //    [MobClick setCrashReportEnabled:NO]; // 如果不需要捕捉异常，注释掉此行
    [MobClick setLogEnabled:YES];  // 打开友盟sdk调试，注意Release发布时需要注释掉此行,减少io消耗
    [MobClick setAppVersion:XcodeAppVersion]; //参数为NSString * 类型,自定义app版本信息，如果不设置，默认从CFBundleVersion里取
    //
    [MobClick startWithAppkey:UMENG_APPKEY reportPolicy:(ReportPolicy) REALTIME channelId:nil];
    //   reportPolicy为枚举类型,可以为 REALTIME, BATCH,SENDDAILY,SENDWIFIONLY几种
    //   channelId 为NSString * 类型，channelId 为nil或@""时,默认会被被当作@"App Store"渠道
    
    //      [MobClick checkUpdate];   //自动更新检查, 如果需要自定义更新请使用下面的方法,需要接收一个(NSDictionary *)appInfo的参数
    //    [MobClick checkUpdateWithDelegate:self selector:@selector(updateMethod:)];
    
    [MobClick updateOnlineConfig];  //在线参数配置
    
    //    1.6.8之前的初始化方法
    //    [MobClick setDelegate:self reportPolicy:REALTIME];  //建议使用新方法
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onlineConfigCallBack:) name:UMOnlineConfigDidFinishedNotification object:nil];
    
}

- (void)onlineConfigCallBack:(NSNotification *)note {
    
    NSLog(@"online config has fininshed and note = %@", note.userInfo);
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [UIApplication sharedApplication].statusBarHidden = NO;
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self setupViewControllers];
    [self.window setRootViewController:self.viewController];
    
    [self resigerListener];//注册监听消息
    [self.window makeKeyAndVisible];
    
    [self customizeInterface];
    
//    [WXApi registerApp:@"wx447b1d0be6b17ca0" withDescription:@"篮球大联盟"];
    [WXApi registerApp:@"wx5e7b88b791551353" withDescription:@"水泥联赛（安踏）"];
    // Required
    [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                   UIRemoteNotificationTypeSound |
                                                   UIRemoteNotificationTypeAlert)];
    // Required
    [APService setupWithOption:launchOptions];
    NSString *uid = [[BLUtils globalCache]stringForKey:@"uid"];
    if (uid.length>0) {
        [self setAPTags:uid];
    }
    
    //  友盟的方法本身是异步执行，所以不需要再异步调用
    [self umengTrack];
//    [self requestAD];
    
    return YES;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        //        _tabBarController selectedViewController
//        [[BLUtils globalCache]setString:@"有消息" forKey:@"push"];
//        [_tabBarController setSelectedIndex:2];
        
//        BLMyMessageViewController *messageView = [[BLMyMessageViewController alloc]initWithNibName:nil bundle:nil];
//        
//        [self.viewController.navigationController pushViewController:messageView animated:YES];
        
//        [self pu];
        [[BLUtils globalCache]setString:@"有消息" forKey:@"push"];
        [_tabBarController setSelectedIndex:3];
    }
}


-(void)setAPTags:(NSString *)uid{
    
    [APService setTags:[NSSet setWithObjects:@"tag1",@"tag2",@"tag3",nil] alias:[NSString stringWithFormat:@"app_%@",uid] callbackSelector:@selector(tagsAliasCallback:tags:alias:) target:self];
}

-(void)resigerListener{
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    
    [defaultCenter addObserver:self selector:@selector(networkDidSetup:) name:kAPNetworkDidSetupNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(networkDidClose:) name:kAPNetworkDidCloseNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(networkDidRegister:) name:kAPNetworkDidRegisterNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(networkDidLogin:) name:kAPNetworkDidLoginNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kAPNetworkDidReceiveMessageNotification object:nil];
}

#pragma mark - Methods

- (void)setupViewControllers {
    BLHomeViewController *homeView = [[BLHomeViewController alloc] initWithNibName:nil bundle:nil];
    _homeViewController = homeView;
    MLNavigationController *homeNavigationController = [[MLNavigationController alloc]initWithRootViewController:homeView];
    
    BLMyViewController *myViewController = [[BLMyViewController alloc] initWithNibName:nil bundle:nil];
    UIViewController *myNavigationController = [[MLNavigationController alloc]
                                                initWithRootViewController:myViewController];
    
    BLMore1ViewController *moreViewController = [[BLMore1ViewController alloc] initWithNibName:nil bundle:nil];
    UINavigationController *moreNavigationController = [[UINavigationController alloc]initWithRootViewController:moreViewController];
    
    BLGuessViewController *guessViewController = [[BLGuessViewController alloc] initWithNibName:nil bundle:nil];
    MLNavigationController *guessNavigationController = [[MLNavigationController alloc]initWithRootViewController:guessViewController];
    
    _tabBarController = [[RDVTabBarController alloc] init];
    _tabBarController.delegate = self;
    
    [_tabBarController setViewControllers:@[homeNavigationController,guessNavigationController,myNavigationController,moreNavigationController]];
    
    //    _tabBarController.view.backgroundColor = [UIColor whiteColor];
    
    self.viewController = _tabBarController;
    
    [self customizeTabBarForController:_tabBarController];
    
}

- (void)customizeTabBarForController:(RDVTabBarController *)tabBarController {
    
    //    UIImage *finishedImage = [UIImage imageNamed:@"tabbar_selected_background"];
    UIImage *finishedImage = [UIImage imageNamed:@"baritem"];
    UIImage *unfinishedImage = [UIImage imageNamed:@"tabbar_normal_background"];
    NSArray *tabBarItemImages = @[@"first",@"竞猜", @"second", @"third"];
    NSInteger index = 0;
    for (RDVTabBarItem *item in [[tabBarController tabBar] items]) {
        [item setBackgroundSelectedImage:finishedImage withUnselectedImage:unfinishedImage];
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",
                                                      [tabBarItemImages objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_normal",
                                                        [tabBarItemImages objectAtIndex:index]]];
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        
        index++;
    }
}

- (void)customizeInterface {
    
    NSDictionary *textAttributes = nil;
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    if ([[[UIDevice currentDevice] systemVersion] integerValue] >= 7.0) {
       
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        
        [navigationBarAppearance setBackgroundImage:[UIImage imageNamed:@"navigationbar_background"]
                                      forBarMetrics:UIBarMetricsDefault];
        textAttributes = @{
                           NSFontAttributeName: [UIFont boldSystemFontOfSize:20],
                           NSForegroundColorAttributeName: [UIColor whiteColor],
                           };
    } else {
        
        [navigationBarAppearance setBackgroundImage:[UIImage imageNamed:@"navigationbar_background"]
                                      forBarMetrics:UIBarMetricsDefault];
        
        if ([[[UIDevice currentDevice] systemVersion] integerValue] >= 7.0) {
            textAttributes = @{
                               NSFontAttributeName: [UIFont boldSystemFontOfSize:20],
                               NSForegroundColorAttributeName: [UIColor whiteColor],
                               };
        } else {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
            textAttributes = @{
                               UITextAttributeFont: [UIFont boldSystemFontOfSize:20],
                               UITextAttributeTextColor: [UIColor whiteColor],
                               UITextAttributeTextShadowColor: [UIColor whiteColor],
                               UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetZero],
                               };
#endif
        }
        
    }
    
    [navigationBarAppearance setTitleTextAttributes:textAttributes];
    
}

- (void)tabBarController:(RDVTabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{

}


 *
 * 可能收到的请求有GetMessageFromWXReq、ShowMessageFromWXReq等。
 * @param req 具体请求内容，是自动释放的
 */
-(void) onReq:(BaseReq*)req{
    
}

/*! @brief 发送一个sendReq后，收到微信的回应
 *
 * 可能收到的处理结果有SendMessageToWXResp、SendAuthResp等。
 * @param resp具体的回应内容，是自动释放的
 */
-(void) onResp:(BaseResp*)resp{
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        
        if (resp.errCode == 0) {
            NSString *tempString = [[BLUtils globalCache]stringForKey:@"myhonour"];
            if ([tempString isEqualToString:@"我的荣耀"]) {
                [MobClick event:@"我的荣耀-分享成功" label:@"我的荣耀-分享成功"];
            }else if ([tempString isEqualToString:@"单场比赛-分享成功"]){
                [MobClick event:@"单场比赛-分享成功" label:@"单场比赛-分享成功"];
            }else if ([tempString isEqualToString:@"我的荣耀-某个荣耀-分享成功"]){
                [MobClick event:@"我的荣耀-某个荣耀-分享成功" label:@"我的荣耀-某个荣耀-分享成功"];
            }
            [ShowLoading showSuccView:self.window message:@"分享成功！"];
        }else{
            [ShowLoading showErrorMessage:@"分享失败！" view:self.window];
        }
        
        [[BLUtils globalCache]setString:@"" forKey:@"myhonour"];
    }
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL isSuc = [WXApi handleOpenURL:url delegate:self];
    NSLog(@"url %@ isSuc %d",url,isSuc == YES ? 1 : 0);
    return  isSuc;
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required
    [APService handleRemoteNotification:userInfo];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [APService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *) error {
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [application setApplicationIconBadgeNumber:0];
}

//avoid compile error for sdk under 7.0
#ifdef __IPHONE_7_0
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    [APService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNoData);
}
#endif

#pragma mark -

- (void)networkDidSetup:(NSNotification *)notification {
    NSLog(@"已连接");
}

- (void)networkDidClose:(NSNotification *)notification {
    NSLog(@"未连接。。。");
}

- (void)networkDidRegister:(NSNotification *)notification {
    NSLog(@"已注册");
}

- (void)networkDidLogin:(NSNotification *)notification {
    NSLog(@"已登录");
}

- (void)networkDidReceiveMessage:(NSNotification *)notification {
    NSDictionary * userInfo = [notification userInfo];
    NSString *title = [userInfo valueForKey:@"title"];
    NSString *content = [userInfo valueForKey:@"content"];
    
    NSDictionary *extras = [userInfo valueForKey:@"extras"];
    NSLog(@"%@",[extras valueForKey:@"uid"]);
    NSLog(@"%@",[extras valueForKey:@"teamid"]);
    NSLog(@"%@",[extras valueForKey:@"teamName"]);
    NSLog(@"%@",[extras valueForKey:@"roleName"]);
    NSLog(@"%@",[extras valueForKey:@"leaderID"]);
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"消息" message:[NSString stringWithFormat:@"时间:%@\n标题:%@\n内容:%@", [dateFormatter stringFromDate:[NSDate date]],title,content] delegate:nil cancelButtonTitle:@"忽略" otherButtonTitles:@"查看", nil];
    alert.delegate = self;
    [alert show];
//    [_infoLabel setText:[NSString stringWithFormat:@"收到消息\ndate:%@\ntitle:%@\ncontent:%@", [dateFormatter stringFromDate:[NSDate date]],title,content]];
    
}

- (void)tagsAliasCallback:(int)iResCode tags:(NSSet*)tags alias:(NSString*)alias {
    NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, tags , alias);
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    [[BLUtils globalCache]setString:@"" forKey:@"load"];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
}

- (void)applicationWillTerminate:(UIApplication *)application
{
}

@end
