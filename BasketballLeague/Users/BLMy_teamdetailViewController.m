//
//  BLMy_teamdetailViewController.m
//  BasketballLeague
//
//  Created by 崔洪禄 on 14-3-2.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//  我的战队

#import "BLMy_teamdetailViewController.h"
#import "BLBaseObject.h"
#import "BLMy_teamMembers.h"
#import "BLMyteamImages.h"
#import "UIColor+Hex.h"
#import "UIImageView+WebCache.h"
#import "BLMyTeamDitViewController.h"
#import "BLMyTeamGameListViewController.h"
#import "BLMyTeamMaxViewController.h"
#import "BLRankingViewController.h"
#import "BLMyTeamStatisticsViewController.h"
#import "BLMyImagesViewController.h"
#import "IBActionSheet.h"
#import "BLAFAppAPIClient.h"
#import "AFHTTPRequestOperation.h"
#import "UIViewController+MJPopupViewController.h"
#import "BLAlertViewController.h"
#import "CXPhotoBrowser.h"
#import "DemoPhoto.h"
#import "SDImageCache.h"
#import <QuartzCore/QuartzCore.h>
#import "BLPhoto.h"
#import "BLErrorView.h"
#import "BLRoleAlertViewController.h"
#import "BLMyViewController.h"

@interface BLMy_teamdetailViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,CXPhotoBrowserDataSource, CXPhotoBrowserDelegate,IBActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate,didClickDelegate,MyTeamDitDelegate,ResultClickDelegate>
{
    UITableView * _tableView;
    UIImageView * myTeamDetailImages;
    BLMy_teamMembers * myMember;
    NSString * imagesUrl;
    NSString * teamid;
    
    CXBrowserNavBarView *navBarView;
    //    CXBrowserToolBarView *toolBarView;
    IBActionSheet *sexAction;
    
    float navHigh;
    BLErrorView *errorView;
    
    NSString * perUID;
    
    BOOL isJoin;
}

@property (nonatomic,strong) NSMutableArray * myTeamDetailArray;

@property (nonatomic, strong) CXPhotoBrowser *browser;
@property (nonatomic, strong) NSMutableArray *photoDataSource;

- (void)uploadFailed:(ASIHTTPRequest *)theRequest;
- (void)uploadFinished:(ASIHTTPRequest *)theRequest;

@end

#define BROWSER_TITLE_LBL_TAG 12731

@implementation BLMy_teamdetailViewController

@synthesize myTeamDetailArray;
@synthesize request ;

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

-(void)rightButtonClick
{
    BLMyTeamDitViewController * myTeamDitView = [[BLMyTeamDitViewController alloc]init];
    myTeamDitView.delegate = self;
    [self.navigationController pushViewController:myTeamDitView animated:YES];
    if (myTeamDetailArray.count > 0) {
        BLData * data = [myTeamDetailArray objectAtIndex:0];
        [myTeamDitView setData:data :myMember :imagesUrl];
    }
}
//rightbuttonclick delegate
-(void)reloadMyTeamDetail
{
    [self requestMy_teamdetail:perUID];
}

-(void)initErrorView:(NSString *)msg{
    
    NSString *home = [[BLUtils globalCache]stringForKey:@"home"];
    NSString *whose = [[BLUtils globalCache]stringForKey:@"whose"];
    
    errorView = [[BLErrorView alloc]init];
    if ([whose isEqualToString:@"TA的"]) {
        if ([home isEqualToString:@""]) {
            errorView.frame = CGRectMake(0, self.view.frame.origin.y, 320, self.view.frame.size.height);
        }else{
            if (ios7) {
                errorView.frame = CGRectMake(0, 64, 320, self.view.frame.size.height-64);
            }else{
                
                errorView.frame = CGRectMake(0, 44, 320, self.view.frame.size.height-44);
            }
        }
        
    }else{
        errorView.frame = CGRectMake(0, self.view.frame.origin.y, 320, self.view.frame.size.height);
    }
    errorView.titleLabel.text = [NSString stringWithFormat:@"%@",msg];
    errorView.tag = 12345;
    [self.view addSubview:errorView];
}

-(void)removeErrorView{
    [[self.view viewWithTag:12345]removeFromSuperview];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.myTeamDetailArray = [NSMutableArray array];
    imagesUrl = @"";
    
    _tableView = [[UITableView alloc]init];
    
//    NSString * nav = [[BLUtils globalCache]stringForKey:@"navigation"];
//    if ([nav isEqualToString:@"noNav"]) {
//        if (ios7) {
//            navHigh = 64;
//        }else{
//            navHigh = 44;
//        }
//        [self addNavBar];
//        [self addNavBarTitle:@"我的战队" action:nil];
//        [self addLeftNavBarItem:@selector(leftButtonClick)];
//        _tableView.frame = [BLUtils frame];
//        
//    }else{
//        NSString * nav1 = [[BLUtils globalCache]stringForKey:@"per"];
//        if ([nav1 isEqualToString:@"homePer"]) {
//            if (ios7) {
//                navHigh = 64;
//            }else{
//                navHigh = 44;
//            }
//            [self addNavBar];
//            [self addNavBarTitle:@"我的战队" action:nil];
//            [self addLeftNavBarItem:@selector(leftButtonClick)];
//            _tableView.frame = [BLUtils frame];
//
//        }else{
//            navHigh = 0;
//            
//            [self addNavText:@"我的战队" action:nil];
//            [self addLeftNavItem:@selector(leftButtonClick)];
//            
//            if (iPhone5) {
//                _tableView.frame = iPhone5_frame;
//            }else{
//                _tableView.frame = iPhone4_frame;
//            }
//        }
//    }
    NSString *home = [[BLUtils globalCache]stringForKey:@"home"];
    NSString *whose = [[BLUtils globalCache]stringForKey:@"whose"];
    
    if ([whose isEqualToString:@"TA的"]) {
        if ([home isEqualToString:@""]) {
            if (iPhone5) {
                _tableView.frame = iPhone5_frame;
            }else{
                _tableView.frame = iPhone4_frame;
            }
            [self addNavText:@"我的战队" action:nil];
            [self addLeftNavItem:@selector(leftButtonClick)];
        }else{
            [self addNavBar];
            [self addNavBarTitle:@"我的战队" action:nil];
            [self addLeftNavBarItem:@selector(leftButtonClick)];
            
            _tableView.frame = [BLUtils frame];
        }
        
    }else{
        if (iPhone5) {
            _tableView.frame = iPhone5_frame;
        }else{
            _tableView.frame = iPhone4_frame;
        }
        [self addNavText:@"我的战队" action:nil];
        [self addLeftNavItem:@selector(leftButtonClick)];
    }
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    
//    [self requestMy_teamdetail];
    
    [self createTableHeaderView];
}

-(void)createTableHeaderView
{
    UIView * tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 160)];
    
    myTeamDetailImages = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 160)];
    myTeamDetailImages.userInteractionEnabled = YES;
    myTeamDetailImages.contentMode = UIViewContentModeScaleAspectFill;
    myTeamDetailImages.image = [UIImage imageNamed:@"PhotoPlaceholder"];
    [tableHeaderView addSubview:myTeamDetailImages];
    
    UIButton * imagesButton = [UIButton buttonWithType:UIButtonTypeCustom];
    imagesButton.frame = CGRectMake(0, 0, 320, 130);
    imagesButton.backgroundColor = [UIColor clearColor];
    [imagesButton addTarget:self action:@selector(imagesButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [myTeamDetailImages addSubview:imagesButton];
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 130, 320, 30)];
    view.backgroundColor = [UIColor blackColor];
    view.alpha = 0.5;
    [myTeamDetailImages addSubview:view];
    
    UIButton * joinButton = [UIButton buttonWithType:UIButtonTypeCustom];
    joinButton.frame = CGRectMake(320 - 30 - 60, 130 + 2.5, 70, 25);
    UIImage * normalRedImage = [[UIImage imageNamed:@"redButton_normal"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    UIImage * pressRedImage = [[UIImage imageNamed:@"redButton_press"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    [joinButton setBackgroundImage:normalRedImage forState:UIControlStateNormal];
    [joinButton setBackgroundImage:pressRedImage forState:UIControlStateHighlighted];
    [joinButton setTitleColor:[UIColor colorWithHexString:@"FFFFFF"] forState:UIControlStateNormal];
    joinButton.titleLabel.font = [UIFont systemFontOfSize:13];
    joinButton.tag = 100;
    [joinButton addTarget:self action:@selector(joinButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    [myTeamDetailImages addSubview:joinButton];
    
    UILabel * imagesNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 130, 80, 30)];
    imagesNumberLabel.backgroundColor = [UIColor clearColor];
    imagesNumberLabel.textColor = [UIColor colorWithHexString:@"FFFFFF"];
    imagesNumberLabel.font = [UIFont systemFontOfSize:13];
    imagesNumberLabel.textAlignment = UITextAlignmentCenter;
    imagesNumberLabel.tag = 101;
    [myTeamDetailImages addSubview:imagesNumberLabel];
    
    UILabel * winCntLabel = [[UILabel alloc]initWithFrame:CGRectMake(110, 130, 100, 30)];
    winCntLabel.backgroundColor = [UIColor clearColor];
    winCntLabel.textColor = [UIColor colorWithHexString:@"FBB03B"];
    winCntLabel.font = [UIFont systemFontOfSize:13];
    winCntLabel.textAlignment = UITextAlignmentCenter;
    winCntLabel.tag = 102;
    [myTeamDetailImages addSubview:winCntLabel];
    
    _tableView.tableHeaderView = tableHeaderView;
}

-(void)imagesButtonClick
{
//    NSLog(@"imagesButton");
//    
//    BLMyImagesViewController * myImagesView = [[BLMyImagesViewController alloc]init];
//    if (myTeamDetailArray.count > 0) {
//        BLData * data = [myTeamDetailArray objectAtIndex:0];
//        [myImagesView setImages:data.imagesArray];
//    }
//    [self.navigationController pushViewController:myImagesView animated:YES];
    NSString *home = [[BLUtils globalCache]stringForKey:@"home"];
    NSString *whose = [[BLUtils globalCache]stringForKey:@"whose"];
    if ([whose isEqualToString:@"TA的"]) {
        if ([home isEqualToString:@""]) {
            showAddDel = NO;
        }else{
            showAddDel = NO;
        }
        
    }else{
        showAddDel = YES;
    }
    [self requestPhotoData:YES];
}

-(void)joinButtonClick:(id)sender
{
    UIButton * joinButton = (UIButton *)sender;
    NSLog(@"%@",joinButton.titleLabel.text);
    if ([joinButton.titleLabel.text isEqualToString:@"解散球队"]) {
        
        UIAlertView * alt = [[UIAlertView alloc]initWithTitle:@"解散球队" message:@"确定要解散球队吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alt show];
        
    }else if ([joinButton.titleLabel.text isEqualToString:@"退出球队"]){
        
        UIAlertView * alt = [[UIAlertView alloc]initWithTitle:@"退出球队" message:@"确定要退出球队吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alt show];
        
    }else if ([joinButton.titleLabel.text isEqualToString:@"加入本队"]){
        
        if (isJoin) {
            BLRoleAlertViewController *roleAlert = [[BLRoleAlertViewController alloc]initWithNibName:nil bundle:nil];
            roleAlert.delegate = self;
            roleAlert.role = @"100";
            [self presentPopupViewController:roleAlert animationType:MJPopupViewAnimationSlideBottomBottom];
        }
    }
}

//BLRoleAlertViewController  delegate
-(void)didClickWhenCommit:(NSString *)result
{
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationSlideBottomBottom];
    
    if (result != nil) {
        [self requestApplyjointeam:result];
    }
}

-(void)requestApplyjointeam:(NSString *)roleIndex
{
    NSString * uid = [[BLUtils globalCache]stringForKey:@"uid"];
    NSString * path = [NSString stringWithFormat:@"applyjointeam/?uid=%@&teamid=%@&role=%@",uid,perUID,roleIndex];
    
    [ShowLoading showWithMessage:showloading view:self.view];
    
    [BLBaseObject globalTimelinePostsWithBlock:^(NSArray *posts, NSError *error) {
        [ShowLoading hideLoading:self.view];
        if (error) {
            return ;
        }
        if (posts.count > 0) {
            BLBaseObject * base = [posts objectAtIndex:0];
            [ShowLoading showErrorMessage:[NSString stringWithFormat:@"%@",base.msg] view:self.view];
        }
    } path:path];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (myTeamDetailArray.count > 0) {
        BLData * data = [myTeamDetailArray objectAtIndex:0];
        CGSize size = [data.intro sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(290, 1000) lineBreakMode:NSLineBreakByWordWrapping];
        return 44*5 + size.height + 30 + 20;
    }else{
        return 220 + 30;
    }
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * header = [[UIView alloc]init];
    header.backgroundColor = [UIColor clearColor];
    
    NSArray * array = [NSArray arrayWithObjects:@"成立时间",@"队长",@"口号",@"学校",@"院系", nil];
    for (int i = 0; i < array.count; i++) {
        UILabel * headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, i * 44, 85, 44)];
        headerLabel.textAlignment = UITextAlignmentCenter;
        headerLabel.textColor = [UIColor colorWithHexString:@"FFFFFF"];
        headerLabel.text = [array objectAtIndex:i];
        headerLabel.font = [UIFont systemFontOfSize:15];
        if (i %2 == 1) {
            headerLabel.backgroundColor = [UIColor colorWithHexString:@"55585F"];
        }else{
            headerLabel.backgroundColor = [UIColor colorWithHexString:@"3D3E43"];
        }
        [header addSubview:headerLabel];
    }
    
    if (myTeamDetailArray.count > 0) {
        BLData * data = [myTeamDetailArray objectAtIndex:0];
        NSArray * dataArray = [NSArray arrayWithObjects:[NSString stringWithFormat:@"  %@",data.createtime],[NSString stringWithFormat:@"  %@",data.captain],[NSString stringWithFormat:@"  %@",data.slogan],[NSString stringWithFormat:@"  %@",data.school],[NSString stringWithFormat:@"  %@",data.college],[NSString stringWithFormat:@"  %@",data.ranking],[NSString stringWithFormat:@"  %@",data.exprienceValue], nil];
        for (int i = 0; i < dataArray.count-1; i++) {
            UILabel * headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(85, i * 44, 320 - 85, 44)];
            headerLabel.textAlignment = UITextAlignmentLeft;
            headerLabel.textColor = [UIColor colorWithHexString:@"FFFFFF"];
            headerLabel.text = [dataArray objectAtIndex:i];
            headerLabel.font = [UIFont systemFontOfSize:15];
            if (i %2 == 1) {
                headerLabel.backgroundColor = [UIColor colorWithHexString:@"3C3E45"];
            }else{
                headerLabel.backgroundColor = [UIColor colorWithHexString:@"36383F"];
            }
            [header addSubview:headerLabel];
        }
        
        UIButton * rankingButton = [UIButton buttonWithType:UIButtonTypeCustom];
        rankingButton.frame = CGRectMake(85, 44 * 5, 320 - 85, 44);
        rankingButton.backgroundColor = [UIColor clearColor];
        [rankingButton addTarget:self action:@selector(rankingButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [header addSubview:rankingButton];
        
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(320 - 32, 44 * 5 + 12, 20, 20)];
        imageView.image = [UIImage imageNamed:@"arrow"];
        [header addSubview:imageView];
        
/////////////////经验值
        
        UIImageView *jyzBG = [[UIImageView alloc]init];
        jyzBG.frame = CGRectMake(136, 44*(dataArray.count-1)+19, 140, 6);
        jyzBG.image = [UIImage imageNamed:@"jyz_bg"];
//        [header addSubview:jyzBG];
        
        UIImageView *jyzProgress = [[UIImageView alloc]init];
        jyzProgress.image = [UIImage imageNamed:@"jyz_progress"];
//        [header addSubview:jyzProgress];
        
        UILabel *jyzPer = [[UILabel alloc]initWithFrame:CGRectMake(274, 44*(dataArray.count-1)+8, 320-274, 25)];
        jyzPer.backgroundColor = [UIColor clearColor];
        jyzPer.textColor = [UIColor whiteColor];
        jyzPer.textAlignment = UITextAlignmentCenter;
        jyzPer.font = [UIFont boldSystemFontOfSize:13.0f];
//        [header addSubview:jyzPer];
        
        /*[NSArray arrayWithObjects:@"等级",@"村代表队",@"乡镇代表队",@"县代表队",@"市代表队",@"省代表队",@"国家代表队", nil];*/
        float max = 0;
        if ([data.ranking isEqualToString:@"村代表队"]) {
            max = 100;
        }else if([data.ranking isEqualToString:@"乡镇代表队"]){
            max = 200;
        }else if([data.ranking isEqualToString:@"县代表队"]){
            max = 300;
        }else if([data.ranking isEqualToString:@"市代表队"]){
            max = 400;
        }else if([data.ranking isEqualToString:@"省代表队"]){
            max = 500;
        }else{
            max = 1000;
        }
        
        float per = [data.exprienceValue floatValue]/max;
        if (per>1.0) {
            per = 1.0;
        }
//        jyzPer.text = [NSString stringWithFormat:@"%.0f%@",per*100,@"%"];
        
//        float progress =  138.0/100.0;
        
//        jyzProgress.frame = CGRectMake(137, 44*(dataArray.count-1)+19+1, progress*per*100, 4);
/////////////////经验值
        
    }
    
    UIView * introView = [[UIView alloc]init];
    introView.backgroundColor = [UIColor colorWithHexString:@"323437"];
    UILabel * introLabel = [[UILabel alloc]init];
    introLabel.textAlignment = UITextAlignmentLeft;
    introLabel.textColor = [UIColor colorWithHexString:@"FFFFFF"];
    introLabel.font = [UIFont systemFontOfSize:15];
    introLabel.backgroundColor = [UIColor clearColor];
    if (myTeamDetailArray.count > 0) {
        BLData * data = [myTeamDetailArray objectAtIndex:0];
        CGSize size = [data.intro sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(290, 1000) lineBreakMode:NSLineBreakByWordWrapping];
        introView.frame = CGRectMake(0, array.count*44, 320, 30 + size.height+20);
        introLabel.frame = CGRectMake(15, array.count*44+15, 290, size.height+20);
        if (data.intro != NULL || ![data.intro isEqualToString:@""]) {
            introLabel.text = [NSString stringWithFormat:@"%@",data.intro];
            introLabel.numberOfLines = 0;
        }
    }else{
        introView.frame = CGRectMake(0, array.count*44, 320, 30);
        introLabel.frame = CGRectMake(15, array.count*44+15, 290, 30);
    }
    introLabel.numberOfLines = 0;
    [header addSubview:introView];
    [header addSubview:introLabel];
    
    return header;
}

-(void)rankingButtonClick
{
    BLRankingViewController * rankingView = [[BLRankingViewController alloc]init];
    [rankingView from:@"等级"];
    [self.navigationController pushViewController:rankingView animated:YES];
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 220;
}

- (UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * footer = [[UIView alloc]init];
    
    UILabel * memberLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 290, 28.5)];
    memberLabel.textAlignment = UITextAlignmentLeft;
    memberLabel.textColor = [UIColor colorWithHexString:@"FFFFFF"];
    memberLabel.font = [UIFont systemFontOfSize:15];
    memberLabel.backgroundColor = [UIColor clearColor];
    memberLabel.text = @"队友";
    [footer addSubview:memberLabel];
    BLData * data;
    if (myTeamDetailArray.count > 0) {
        data = [myTeamDetailArray objectAtIndex:0];
        
        UIScrollView *scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(15, 28.5, 290, 70)];
        scrollview.backgroundColor = [UIColor clearColor];
        scrollview.contentSize = CGSizeMake(73.33f*data.membersArray.count, 70);
        
        for (int i = 0; i < data.membersArray.count; i++) {
            BLMy_teamMembers * member = [data.membersArray objectAtIndex:i];
            UIImageView * memberImageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*73.33f, 0, 70, 70)];
            [memberImageView setImageWithURL:[NSURL URLWithString:member.icon] placeholderImage:[UIImage imageNamed:@"placeholder"]];
            memberImageView.userInteractionEnabled = YES;
            [scrollview addSubview:memberImageView];
            if (i == 0) {
                UIImageView *leaderImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 35, 35)];
                leaderImageView.image = [UIImage imageNamed:@"ic_teamleader"];
                [memberImageView addSubview:leaderImageView];
            }
            UIButton * memButton = [UIButton buttonWithType:UIButtonTypeCustom];
            memButton.frame = CGRectMake(0, 0, 70, 70);
            memButton.backgroundColor = [UIColor clearColor];
            [memButton addTarget:self action:@selector(memButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            memButton.tag = 200 + i;
            [memberImageView addSubview:memButton];
        }
        [footer addSubview:scrollview];
    }
    
    UIButton * myTeamgameListbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    myTeamgameListbutton.frame = CGRectMake(23, 117, 130, 30);
    [myTeamgameListbutton setBackgroundImage:[[UIImage imageNamed:@"textBg"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)] forState:UIControlStateNormal];
//    [myTeamgameListbutton setBackgroundImage:[UIImage imageNamed:@"textBg"] forState:UIControlStateHighlighted];
    [myTeamgameListbutton setTitle:@"比赛情况" forState:UIControlStateNormal];
    [myTeamgameListbutton setTitleEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
    [myTeamgameListbutton setTitleColor:[UIColor colorWithHexString:@"FFFFFF"] forState:UIControlStateNormal];
    myTeamgameListbutton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [myTeamgameListbutton addTarget:self action:@selector(myTeamgameListbuttonClick) forControlEvents:UIControlEventTouchUpInside];
    myTeamgameListbutton.tag = 150;
    [footer addSubview:myTeamgameListbutton];
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(85, 0, 40, 30)];
    label.textColor = [UIColor grayColor];
    label.textAlignment = UITextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:13];
    label.backgroundColor = [UIColor clearColor];
    label.text = [NSString stringWithFormat:@"%@场",data.matchCnt];
    [myTeamgameListbutton addSubview:label];
    
    UIButton * myTeamStatisticsbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    myTeamStatisticsbutton.frame = CGRectMake(320 - 23 - 130, 117, 130, 30);
    [myTeamStatisticsbutton setBackgroundImage:[[UIImage imageNamed:@"textBg"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)] forState:UIControlStateNormal];
    [myTeamStatisticsbutton setTitle:@"技术统计" forState:UIControlStateNormal];
    [myTeamStatisticsbutton setTitleColor:[UIColor colorWithHexString:@"FFFFFF"] forState:UIControlStateNormal];
    myTeamStatisticsbutton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [myTeamStatisticsbutton addTarget:self action:@selector(myTeamstatisticsbuttonClick) forControlEvents:UIControlEventTouchUpInside];
    [footer addSubview:myTeamStatisticsbutton];
    
    UIButton * myTeamMaxbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    myTeamMaxbutton.frame = CGRectMake(23, 147 + 12, 130, 30);
    [myTeamMaxbutton setBackgroundImage:[[UIImage imageNamed:@"textBg"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)] forState:UIControlStateNormal];
    //    [myTeamgameListbutton setBackgroundImage:[UIImage imageNamed:@"textBg"] forState:UIControlStateHighlighted];
    [myTeamMaxbutton setTitle:@"各项最高" forState:UIControlStateNormal];
    [myTeamMaxbutton setTitleColor:[UIColor colorWithHexString:@"FFFFFF"] forState:UIControlStateNormal];
    myTeamMaxbutton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [myTeamMaxbutton addTarget:self action:@selector(myTeamMaxbuttonClick) forControlEvents:UIControlEventTouchUpInside];
    [footer addSubview:myTeamMaxbutton];
    
    return footer;
}

-(void)memButtonClick:(id)sender
{
    UIButton * memButton = (UIButton *)sender;
    
    BLData * data = [myTeamDetailArray objectAtIndex:0];
    
    BLMyViewController *myView = [[BLMyViewController alloc]initWithNibName:nil bundle:nil];
    
    BLMy_teamMembers * member = [data.membersArray objectAtIndex:memButton.tag-200];

    [myView setVisitid:member.uid andName:@"" from:@"我的"];
    [self.navigationController pushViewController:myView animated:YES];

}

-(void)myTeamgameListbuttonClick
{
//    NSLog(@"比赛情况");
    BLMyTeamGameListViewController * bmtglView = [[BLMyTeamGameListViewController alloc]initWithNibName:nil bundle:nil];
    
//    [bmtglView setNavTitle:[NSString stringWithFormat:@"%@",myData.teamname]];
    [bmtglView requestData:myData.teamid titile:titleName from:@"比赛情况"];
//    bmtglView.teamId = myData.teamid;

    [self.navigationController pushViewController:bmtglView animated:YES];
}

-(void)myTeamstatisticsbuttonClick
{
    //技术统计
    BLMyTeamStatisticsViewController * statisticsView = [[BLMyTeamStatisticsViewController alloc]init];
    [statisticsView requestData:myData.teamid from:@"我的战队"];
    [statisticsView setTeamName:[NSString stringWithFormat:@"%@",myData.teamname]];
    [self.navigationController pushViewController:statisticsView animated:YES];
}

-(void)myTeamMaxbuttonClick
{
//    NSLog(@"各项最高");
    BLMyTeamMaxViewController * teamMaxView = [[BLMyTeamMaxViewController alloc]init];
//    teamMaxView.teamid = myData.teamid;
    [teamMaxView requestMyTeamMax:myData.teamid from:@"我的战队"];
    [self.navigationController pushViewController:teamMaxView animated:YES];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 0;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)requestMy_teamdetail:(NSString *)uid from:(NSString *)from{
   
    [self requestMy_teamdetail:uid];
    
}

-(void)requestMy_teamdetail:(NSString *)uid
{
    perUID = uid;
    
    NSString *home = [[BLUtils globalCache]stringForKey:@"home"];
    NSString *whose = [[BLUtils globalCache]stringForKey:@"whose"];
    NSString *path;
    if ([whose isEqualToString:@"TA的"]) {
        if ([home isEqualToString:@""]) {
            path = [NSString stringWithFormat:@"my_teamdetailByteamid/?teamid=%@",perUID];
        }else{
            
            path = [NSString stringWithFormat:@"my_teamdetailByteamid/?teamid=%@",perUID];
        }
        
    }else{
        path = [NSString stringWithFormat:@"my_teamdetail?uid=%@",perUID];

    }
    
    [ShowLoading showWithMessage:showloading view:self.view];
    [BLBaseObject globalTimelinePostsWithBlock:^(NSArray *posts, NSError *error) {
        
        if (error) {
            
        }
        if (posts.count > 0) {
            BLBaseObject *base = [posts objectAtIndex:0];
            if ([base.msg isEqualToString:@"succ"]) {
                
//                [self performSelector:@selector(addNavTextAndDetailTextPerform) withObject:nil afterDelay:.5];
                [myTeamDetailArray removeAllObjects];
                [myTeamDetailArray addObject:base.data];
                myData = base.data;
                UIButton * joinButton = (UIButton *)[self.view viewWithTag:100];
                
                if ([whose isEqualToString:@"TA的"]) {
                    [joinButton setTitle:@"加入本队" forState:UIControlStateNormal];
                    if (base.data.membersArray.count < 4) {
                        NSString * str = [[BLUtils globalCache] stringForKey:@"isTeam"];
                        if (![str isEqualToString:@"No"]) {
                            [joinButton setBackgroundImage:[UIImage imageNamed:@"button_normal"] forState:UIControlStateNormal];
                            [joinButton setBackgroundImage:[UIImage imageNamed:@"button_normal"] forState:UIControlStateHighlighted];
                        }else{
                            isJoin = YES;
                        }
                    }else{
                        [joinButton setBackgroundImage:[UIImage imageNamed:@"button_normal"] forState:UIControlStateNormal];
                        [joinButton setBackgroundImage:[UIImage imageNamed:@"button_normal"] forState:UIControlStateHighlighted];
                    }
                    
                }else{
                    
                    if (base.data.membersArray.count > 0) {
                        BLMy_teamMembers * members = [base.data.membersArray objectAtIndex:0];
                        if ([members.uid isEqualToString:perUID]) {
                            [joinButton setTitle:@"解散球队" forState:UIControlStateNormal];
                            myMember = members;
                            [self addNavRightText:@"编辑" action:@selector(rightButtonClick)];
//                            [self addRightNavItemWithImg:@"edit_normal" hImg:@"edit_press" action:@selector(rightButtonClick)];
                            
                        }else{
                            [joinButton setTitle:@"退出球队" forState:UIControlStateNormal];
                        }
                    }
                    
                }
                
                UILabel * imagesNumberLabel = (UILabel *)[self.view viewWithTag:101];
                imagesNumberLabel.text = [NSString stringWithFormat:@"共%d张",base.data.imagesArray.count];
                
                if (base.data.imagesArray.count > 0) {
                    
                    BLMyteamImages * images = [base.data.imagesArray objectAtIndex:0];
                    [myTeamDetailImages setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",images.imgURL]] placeholderImage:[UIImage imageNamed:@"PhotoPlaceholder"]];
                }else{
                    myTeamDetailImages.image = [UIImage imageNamed:@"PhotoPlaceholder"];
                }
                
                UILabel * winCntLabel = (UILabel *)[self.view viewWithTag:102];
                winCntLabel.text = [NSString stringWithFormat:@"胜率：%@%@",base.data.winCnt,@"%"];
                
                imagesUrl = [NSString stringWithFormat:@"%@",base.data.icon];
                
                [_tableView reloadData];
                [ShowLoading hideLoading:self.view];

            }else{
                [ShowLoading hideLoading:self.view];
                [self initErrorView:base.msg];
                [ShowLoading showErrorMessage:base.msg view:self.view];
//                [self.navigationController popViewControllerAnimated:YES];
            }
        }
        
    } path:path];
}

-(void)addNavTextAndDetailTextPerform
{
    BLData * data = [myTeamDetailArray objectAtIndex:0];
    
//    NSString *homeString = (NSString *)[[BLUtils globalCache]stringForKey:@"home"];
    NSString *whose = [[BLUtils globalCache]stringForKey:@"whose"];
    NSString *home = [[BLUtils globalCache]stringForKey:@"home"];
    
    if ([whose isEqualToString:@"TA的"]) {
        if ([home isEqualToString:@""]) {
            [self addNavTextAndDetailText:@"TA的战队" :[NSString stringWithFormat:@"%@",data.teamname] action:nil];
        }else{
            [self addNavBarTitle:@"TA的战队" andDetailTitle:data.teamname action:nil];
        }
        
        titleName = @"TA的比赛";
        
    }else{
        [self addNavTextAndDetailText:@"我的战队" :[NSString stringWithFormat:@"%@",data.teamname] action:nil];
        titleName = @"我的比赛";
    }
//    if ([homeString isEqualToString:@"首页"]) {
//        [self addNavBarTitle:@"TA的战队" andDetailTitle:data.teamname action:nil];
//    }else{
//        [self addNavTextAndDetailText:@"我的战队" :[NSString stringWithFormat:@"%@",data.teamname] action:nil];
//    }
}

#pragma mark - CXPhotoBrowserDataSource
- (NSUInteger)numberOfPhotosInPhotoBrowser:(CXPhotoBrowser *)photoBrowser
{
    return [self.photoDataSource count];
}
- (id <CXPhotoProtocol>)photoBrowser:(CXPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index
{
    if (index < self.photoDataSource.count){
        //        currentIndex = index;
        return [self.photoDataSource objectAtIndex:index];
    }
    return nil;
}

- (CXBrowserNavBarView *)browserNavigationBarViewOfOfPhotoBrowser:(CXPhotoBrowser *)photoBrowser withSize:(CGSize)size
{
    CGRect frame;
    frame.origin = CGPointZero;
    frame.size = size;
    
    NSString *whose = [[BLUtils globalCache]stringForKey:@"whose"];
    NSString *home = [[BLUtils globalCache]stringForKey:@"home"];
    
    if (!navBarView)
    {
        int y=0;
        if (ios7) {
            y = 20;
            navBarView = [[CXBrowserNavBarView alloc] initWithFrame:CGRectMake(0, 0, 320, 64)];
        }else{
            y = 20;
            navBarView = [[CXBrowserNavBarView alloc] initWithFrame:CGRectMake(0, 20, 320, 44)];
        }
        
        [navBarView setBackgroundColor:[UIColor blackColor]];
        UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, y, 320, 44)];
        imageview.image = [UIImage imageNamed:@"navigationbar_background"];
        [navBarView addSubview:imageview];
        
        UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        deleteBtn.frame = CGRectMake(size.width-40, 9.5+y, 25, 25);
        [deleteBtn setBackgroundImage:[UIImage imageNamed:@"Delete_normal"]
                             forState:UIControlStateNormal];
        [deleteBtn setBackgroundImage:[UIImage imageNamed:@"Delete_press"]
                             forState:UIControlStateHighlighted];
        [deleteBtn addTarget:self action:@selector(delete) forControlEvents:UIControlEventTouchUpInside];
        deleteBtn.tag = 1000010;
        
        addBtn.frame = CGRectMake(size.width-80, 9.5+y, 25, 25);
        [addBtn setBackgroundImage:[UIImage imageNamed:@"addRightBtn_normal"]
                          forState:UIControlStateNormal];
        [addBtn setBackgroundImage:[UIImage imageNamed:@"addRightBtn_press"]
                          forState:UIControlStateHighlighted];
        [addBtn addTarget:self action:@selector(showAddPhotoAction:) forControlEvents:UIControlEventTouchUpInside];
        addBtn.tag = 1000011;
        if ([whose isEqualToString:@"TA的"]) {
            if ([home isEqualToString:@""]) {
                
            }else{
//                if (showAddDel) {
                    [navBarView addSubview:addBtn];
                    [navBarView addSubview:deleteBtn];
//                }else{
//                    
//                }
            }
            
        }else{
//            if (showAddDel) {
                [navBarView addSubview:addBtn];
                [navBarView addSubview:deleteBtn];
//            }
        }
        
        UILabel *titleLabel = [[UILabel alloc] init];
        [titleLabel setFrame:CGRectMake(60, 0+y, 200, 40)];
        //        [titleLabel setCenter:navBarView.center];
        [titleLabel setTextAlignment:NSTextAlignmentCenter];
        [titleLabel setFont:[UIFont boldSystemFontOfSize:20.]];
        [titleLabel setTextColor:[UIColor whiteColor]];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        titleLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        [titleLabel setTag:BROWSER_TITLE_LBL_TAG];
        [navBarView addSubview:titleLabel];
        
        
        //        UIView  *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 44)];
        //        view.backgroundColor = [UIColor clearColor];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        
        btn2.frame = CGRectMake(0, 0+y, 60, 44+y);
        btn.frame = CGRectMake(17.5, 9.5+y, 25, 25);
        
        [btn2 addTarget:self action:@selector(dismissMod:) forControlEvents:UIControlEventTouchUpInside];
        [btn2 setBackgroundColor:[UIColor clearColor]];
        [btn setBackgroundImage:[UIImage imageNamed:@"back_normal"]
                       forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"back_selected"]
                       forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(dismissMod:) forControlEvents:UIControlEventTouchUpInside];
        //        [view addSubview:btn];
        //        [view addSubview:btn2];
        [navBarView addSubview:btn2];
        [navBarView addSubview:btn];
    }
    
    if ([whose isEqualToString:@"TA的"]) {
        if ([home isEqualToString:@""]) {
            
        }else{
            if (showAddDel) {
                [navBarView viewWithTag:1000010].hidden = NO;
                [navBarView viewWithTag:1000011].hidden = NO;
            }else{
                [navBarView viewWithTag:1000010].hidden = YES;
                [navBarView viewWithTag:1000011].hidden = YES;
            }
        }
        
    }else{
        if (showAddDel) {
            [navBarView viewWithTag:1000010].hidden = NO;
            [navBarView viewWithTag:1000011].hidden = NO;
        }else{
            [navBarView viewWithTag:1000010].hidden = YES;
            [navBarView viewWithTag:1000011].hidden = YES;
        }
    }
    
    return navBarView;
}


-(void)showAddPhotoAction:(UIButton *)button{
    sexAction = [[IBActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitlesArray:@[@"照相机", @"相册"]];
    [sexAction setButtonBackgroundColor:[UIColor colorWithHexString:@"#55585f"]];
    [sexAction setButtonTextColor:[UIColor whiteColor]];
    [sexAction setButtonBackgroundColor:[UIColor colorWithHexString:@"#ac3726"] forButtonAtIndex:2];

    [sexAction showInView:self.browser.view];
}

-(void)dismissMod:(UIButton *)closeBtn{
//    [closeBtn superview].backgroundColor = [UIColor clearColor];
//    navBarView.backgroundColor = [UIColor clearColor];
//    [navBarView removeFromSuperview];
//    navBarView = nil;
//    button.superview.backgroundColor = [UIColor clearColor];
    [self dismissModalViewControllerAnimated:YES];
}

-(void)actionSheet:(IBActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex >= 2) {
        return;
    }
    if (buttonIndex == 0) {
        [self openCamera];
    }else if (buttonIndex == 1){
        [self openPics];
    }
}

// 打开相机
- (void)openCamera {
    // UIImagePickerControllerCameraDeviceRear 后置摄像头
    // UIImagePickerControllerCameraDeviceFront 前置摄像头
    BOOL isCamera = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
    if (!isCamera) {
        [ShowLoading showErrorMessage:@"无摄像头！" view:self.browser.view];
        return ;
    }
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.delegate = self;
    // 编辑模式
    imagePicker.allowsEditing = YES;
    
//    if (isIcon) {
//        [self presentViewController:imagePicker animated:YES completion:^{
//        }];
//    }else{
    
        [self.browser presentViewController:imagePicker animated:YES completion:^{
        }];
//    }
    
    
}


// 打开相册
- (void)openPics {
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate = self;

        [self.browser presentViewController:imagePicker animated:YES completion:^{
        }];
}

// 选中照片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    // UIImagePickerControllerOriginalImage 原始图片
    // UIImagePickerControllerEditedImage 编辑后图片
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    if (!image) {
        image = [info objectForKey:UIImagePickerControllerEditedImage];
    }
    //    imageView.image = image;
    
    //    int NUMBER_OF_CHARS = 10;
    //    char data[NUMBER_OF_CHARS];
    //    for (int x=0;x<NUMBER_OF_CHARS;data[x++] = (char)('A' + (arc4random_uniform(26))));
    //    NSString *file = [[NSString alloc] initWithBytes:data length:NUMBER_OF_CHARS encoding:NSUTF8StringEncoding];
    NSString *mfilePath = [NSString stringWithFormat:@"photo.jpg"];
    [self saveImage:image WithName:mfilePath];
    
    [self upload];
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

-(void)upload{
    
    [request cancel];

//    teamid	int	true		球队主键	>0 的int
//    Teamimages[file]	file	true
    NSString *path = [NSString stringWithFormat:@"%@my_teamaddimg/",base_url];
    
    self.request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:path]];
	[request setPostValue:myData.teamid forKey:@"teamid"];
    
    [request setTimeOutSeconds:60];
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0
	[request setShouldContinueWhenAppEntersBackground:YES];
#endif
    //	[request setUploadProgressDelegate:progressIndicator];
	[request setDelegate:self];
	[request setDidFailSelector:@selector(uploadFailed:)];
	[request setDidFinishSelector:@selector(uploadFinished:)];

    [request setFile:filePath forKey:[NSString stringWithFormat:@"Teamimages[file]"]];
    
	[request startAsynchronous];
    
}

- (void)uploadFailed:(ASIHTTPRequest *)theRequest
{
	[ShowLoading showErrorMessage:@"上传失败!" view:self.browser.view];
}

- (void)uploadFinished:(ASIHTTPRequest *)theRequest
{
    [ShowLoading showSuccView:self.browser.view message:@"上传成功！"];
    //    CXPhoto *photo = [[CXPhoto alloc]initWithFilePath:filePath];
    //    [self.photoDataSource addObject:photo];
    //    [self.browser reloadData];
//    if (!isIcon) {
        [self requestPhotoData:NO];
    [self requestMy_teamdetail:perUID];
//    }
}

- (void)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName
{
    NSData *imageData = UIImageJPEGRepresentation(tempImage,0.3f);
    NSArray*paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];
    // Now we get the full path to the file
    NSString* fullPathToFile = [documentsDirectory stringByAppendingPathComponent:imageName];
    filePath = fullPathToFile;
    // and then we write it out
    [imageData writeToFile:fullPathToFile atomically:NO];
}

// 取消相册
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

#pragma mark - CXPhotoBrowserDelegate
- (void)photoBrowser:(CXPhotoBrowser *)photoBrowser didChangedToPageAtIndex:(NSUInteger)index
{
    UILabel *titleLabel = (UILabel *)[navBarView viewWithTag:BROWSER_TITLE_LBL_TAG];
    if (titleLabel)
    {
        currentIndex = index;
        if (photoBrowser.photoCount == 0) {
            titleLabel.text = [NSString stringWithFormat:@"%i/%i", index, photoBrowser.photoCount];
        }else{
            titleLabel.text = [NSString stringWithFormat:@"%i/%i", index+1, photoBrowser.photoCount];
        }
    }
    
}

-(void)delete{
    
    BLAlertViewController *alertView = [[BLAlertViewController alloc]initWithNibName:@"BLAlertViewController" bundle:nil];
    alertView.delegate = self;
    [self.browser presentPopupViewController:alertView animationType:MJPopupViewAnimationSlideBottomBottom];
}

-(void)didClickButton:(UIButton *)button{
    
    [self.browser dismissPopupViewControllerWithanimationType:MJPopupViewAnimationSlideBottomBottom];
    
    if (button.tag == 100) {
        BLPhoto *photo = [photosArray objectAtIndex:currentIndex];
        [self sendToServerDelId:photo.imgid];
        [_photoDataSource removeObjectAtIndex:currentIndex];
        [self.browser reloadData];
    }
}

-(void)requestPersonPhoto:(NSString *)uid push:(BOOL)push{
    
    NSString *path = [NSString stringWithFormat:@"my_albumlist/?uid=%@",uid];
    
    [ShowLoading showWithMessage:showloading view:self.view];
    
    [BLPhoto globalTimelinePostsWithBlock:^(NSArray *posts, NSError *error) {
        [ShowLoading hideLoading:self.view];
        if (error) {
            return ;
        }
        if (posts.count > 0) {
            BLPhoto *photo = [posts objectAtIndex:0];
            if (photo.msg == nil) {
                if (push) {
                    [self initPhotos:posts];
                }else{
                    [self initPhotoDataSource:posts];
                }
                photosArray = posts;
            }else{
                [ShowLoading showErrorMessage:@"暂无数据" view:self.view];
            }
        }
    } path:path];
}

-(void)requestPhotoData:(BOOL)push{
    NSString *path = [NSString stringWithFormat:@"my_teamimgs/?teamid=%@",myData.teamid];
    
    [ShowLoading showWithMessage:showloading view:self.view];
    [BLPhoto globalTimelinePostsWithBlock:^(NSArray *posts, NSError *error) {
        [ShowLoading hideLoading:self.view];
        if (error) {
            return ;
        }
        if (posts.count > 0) {
            BLPhoto *photo = [posts objectAtIndex:0];
            if (photo.msg == nil) {
                if (push) {
                    [self initPhotos:posts];
                }else{
                    [self initPhotoDataSource:posts];
                }
                photosArray = posts;
            }else{
//                [ShowLoading showErrorMessage:@"暂无数据" view:self.view];
//                if (push) {
//                    [self initPhotos:posts];
//                }else{
//                    [self initPhotoDataSource:posts];
//                }
//                photosArray = posts;
                if (push) {
                    self.photoDataSource = [NSMutableArray array];
                    self.browser = [[CXPhotoBrowser alloc] initWithDataSource:self delegate:self];
                    self.browser.wantsFullScreenLayout = YES;
                    
                    [self presentModalViewController:self.browser animated:YES];
                }
            }
        }
    } path:path];
}

-(void)initPhotoDataSource:(NSArray *)posts{
    [self.photoDataSource removeAllObjects];
    for (int i = 0; i < [posts count]; i++)
    {
        BLPhoto *myPhoto = [posts objectAtIndex:i];
        NSURL *imgURL = [NSURL URLWithString:myPhoto.url];
        
        DemoPhoto *photo = [[DemoPhoto alloc] initWithURL:imgURL];
        
        [self.photoDataSource addObject:photo];
    }
    [self.browser reloadData];
}

-(void)initPhotos:(NSArray *)posts{
    
    //    [[SDImageCache sharedImageCache] clearDisk];
    //    [[SDImageCache sharedImageCache] clearMemory];
    self.photoDataSource = [NSMutableArray array];
    self.browser = [[CXPhotoBrowser alloc] initWithDataSource:self delegate:self];
    self.browser.wantsFullScreenLayout = YES;
    
    for (int i = 0; i < [posts count]; i++)
    {
        BLPhoto *myPhoto = [posts objectAtIndex:i];
        NSURL *imgURL = [NSURL URLWithString:myPhoto.url];
        
        DemoPhoto *photo = [[DemoPhoto alloc] initWithURL:imgURL];
        
        [self.photoDataSource addObject:photo];
    }
    
    [self presentModalViewController:self.browser animated:YES];
    
}

-(void)sendToServerDelId:(NSString *)imgId{
    NSString *path = [NSString stringWithFormat:@"my_teamdelimg/?id=%@",imgId];
    [BLPhoto globalTimelinePostsWithBlock:^(NSArray *posts, NSError *error) {
        if (error) {
            return ;
        }
        if (posts.count > 0) {
            
            BLPhoto *photo = [posts objectAtIndex:0];
            
            if ([photo.msg isEqualToString:@"succ"]) {
                [ShowLoading showSuccView:self.browser.view message:@"删除成功！"];
//                [self requestPhotoData:NO];
                [self requestMy_teamdetail:perUID];
            }else{
                [ShowLoading showErrorMessage:@"删除失败！" view:self.browser.view];
            }
        }
    } path:path];
}

- (BOOL)supportReload
{
    return YES;
}

//-(void)viewWillAppear:(BOOL)animated
//{
//    [ShowLoading hideLoading:self.view];
//    
//}

- (void)viewDidAppear:(BOOL)animated{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        //刷新状态条
        //从拍照返回后强制设置
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
        [self setNeedsStatusBarAppearanceUpdate];
    }
    [ShowLoading hideLoading:self.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
