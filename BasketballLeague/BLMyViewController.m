//
//  BLMyViewController.m
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-2-17.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLMyViewController.h"
#import "RDVTabBarController.h"
#import "RDVTabBarItem.h"
#import "BLAppDelegate.h"
#import "BLLoginViewController.h"
#import "MLNavigationController.h"
#import "BLEditingViewController.h"
#import "UIButton+Bootstrap.h"
#import "BLMyHeaderView.h"
#import "BLLevelCell.h"
#import "BLRongYaoCell.h"
#import "BLJinBiCell.h"
#import "BLJingYanZhiCell.h"
#import "BLVisiterCell.h"
#import "BLMyCrewCell.h"
#import "BLMyButonsCell.h"
#import "BLLoffCell.h"
#import "BLPerson.h"
#import "BLPersonData.h"
#import "BLMyVisitorsViewController.h"
#import "BLMyHonourViewController.h"
#import "CXPhotoBrowser.h"
#import "DemoPhoto.h"
#import "SDImageCache.h"
#import <QuartzCore/QuartzCore.h>
#import "BLFollowersViewController.h"
#import "BLMyGameViewController.h"
#import "BLPhoto.h"
#import "BLMyPhotoViewController.h"
#import "IBActionSheet.h"
#import "BLAFAppAPIClient.h"
#import "AFHTTPRequestOperation.h"
#import "UIViewController+MJPopupViewController.h"
#import "BLAlertViewController.h"
#import "BLMyNewHeaderView.h"
#import "BLCommenNewCell.h"
#import "BLFollowersViewController.h"
#import "BLMyGameViewController.h"
#import "BLMyPhotoViewController.h"
#import "BLMy_teamdetailViewController.h"
#import "BLMyLevelViewController.h"
#import "BLNoTeamDetailViewController.h"
#import "BLTextField.h"
#import "BLFindPwdViewController.h"
#import "BLRegViewController.h"
#import "BLGoldViewController.h"

@interface BLMyViewController ()<CXPhotoBrowserDataSource, CXPhotoBrowserDelegate,buttonClickDelegate,IBActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate,didClickDelegate,ChangeIconDelegate,LogOffDelegate,InitUID,UITextFieldDelegate>
{
    NSArray *imageURLs;
    NSArray *descriptions;
    
    CXBrowserNavBarView *navBarView;
    
    IBActionSheet *sexAction;

    NSArray *titleArray;
    BLMyNewHeaderView *newHeaderView;

    BLPersonData *personData;
    
    NSString * personUID;
}

@property (nonatomic, strong) CXPhotoBrowser *browser;
@property (nonatomic, strong) NSMutableArray *photoDataSource;

- (void)uploadFailed:(ASIHTTPRequest *)theRequest;
- (void)uploadFinished:(ASIHTTPRequest *)theRequest;
@end

#define BROWSER_TITLE_LBL_TAG 12731


@implementation BLMyViewController

@synthesize request ;
@synthesize isFromeGoldRank;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"我";
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
    
    titleArray = @[@"荣耀",@"等级",@"经验值",@"金币"];
  
    uid = [[BLUtils globalCache]stringForKey:@"uid"];
    [self initTableView];

}

-(void)setVisitid:(NSString *)visitid andName:(NSString *)name from:(NSString *)from{
    
    fromString = from;
    personUID = visitid;

    NSString *home = [[BLUtils globalCache]stringForKey:@"home"];
    NSString *whose = [[BLUtils globalCache]stringForKey:@"whose"];
    
    if ([whose isEqualToString:@"TA的"]) {
        if ([home isEqualToString:@""]) {
            if (iPhone5) {
                _tableView.frame = iPhone5_frame;
            }else{
                _tableView.frame = iPhone4_frame;
            }
            [self addNavBarTitle:[NSString stringWithFormat:@"%@",name] action:nil];
            personUID = [NSString stringWithFormat:@"%@",visitid];
            
            [self addLeftNavItem:@selector(dismiss)];
        }else{
            _tableView.frame = [BLUtils frame1];

            if (isFromeGoldRank) {
                _tableView.frame = [BLUtils frameHasBar];
                [self addLeftNavItem:@selector(leftButtonClick)];
            }
            else{
                [self addNavBar];
                [self addLeftNavBarItem:@selector(leftButtonClick)];
                [self addNavBarTitle:name action:nil];
            }
            
            
        }
        
    }else{
        if (iPhone5) {
            _tableView.frame = iPhone5_frame;
        }else{
            _tableView.frame = iPhone4_frame;
        }
        [self addNavBarTitle:[NSString stringWithFormat:@"%@",name] action:nil];
        personUID = [NSString stringWithFormat:@"%@",visitid];
        
        [self addLeftNavItem:@selector(dismiss)];
    }
    
    [self requestData:visitid];
}

-(void)dismiss{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setVisitid:(NSString *)visitid andName:(NSString *)name
{
    [self addNavBarTitle:[NSString stringWithFormat:@"%@",name] action:nil];
    personUID = [NSString stringWithFormat:@"%@",visitid];
    
    [self requestData:visitid];
}

-(void)initTableView{
    [_tableView removeFromSuperview];
    _tableView = nil;
    _tableView = [[UITableView alloc]init];

    if (iPhone5) {
        _tableView.frame = iPhone5_frame_tab;
    }else{
        _tableView.frame = iPhone4_frame_tab;
    }
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    newHeaderView = [[BLMyNewHeaderView alloc]initWithFrame:CGRectMake(0, 0, 320, 232)];
    _tableView.tableHeaderView = newHeaderView;
    newHeaderView.delegate = self;
    [self.view addSubview:_tableView];
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2) {
        return 105.0f;
    }else if (indexPath.row == 7){
        return 94.0f;
    }
    return 45.0f;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (fromString) {
        return 7;
    }else{
        return 8;
    }
    return 0;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.row == 0){
        BLRongYaoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell0"];
        if (cell == nil) {
            cell = [[BLRongYaoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyCell0"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
        }
        [cell initData:personData];
        return cell;
    }
    
    /*else if (indexPath.row == 1){
        BLLevelCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell1"];
        if (cell == nil) {
            cell = [[BLLevelCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyCell1"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
        }
        [cell initData:personData];
        return cell;
    }else if (indexPath.row == 2){
        BLJingYanZhiCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell2"];
        if (cell == nil) {
            cell = [[BLJingYanZhiCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyCell2"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
        }
        [cell initData:personData];
        return cell;
    }*/
     else if(indexPath.row == 1){//改动
         BLJinBiCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell3"];
         cell = [[BLJinBiCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyCell3"];
         if (fromString) {
             cell.selectionStyle = UITableViewCellSelectionStyleNone;
         }
         cell.backgroundColor = [UIColor clearColor];
         if (fromString) {
             cell.jinbiBtn.hidden = YES;
         }else{
             cell.jinbiBtn.hidden = NO;
         }
         [cell initData:personData];
         return cell;
    }
     else if(indexPath.row == 2){
        BLVisiterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell4"];
        if (cell == nil) {
            cell = [[BLVisiterCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyCell4"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
        }
        [cell initData:personData];
        return cell;
    }else if(indexPath.row == 3){
        BLCommenNewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell5"];
        if (cell == nil) {
            cell = [[BLCommenNewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyCell5"];
            cell.bgView.backgroundColor = [UIColor colorWithHexString:@"#3e4149"];
            cell.icon.image = [UIImage imageNamed:@"zhandui"];
            cell.backgroundColor = [UIColor clearColor];
        }
        if (fromString) {
            cell.title.text = @"TA的战队";
        }else{
            cell.title.text = @"我的战队";
        }

        return cell;
    }else if(indexPath.row == 4){
        BLCommenNewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell6"];
        if (cell == nil) {
            cell = [[BLCommenNewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyCell6"];
            cell.icon.image = [UIImage imageNamed:@"bisai"];
            cell.backgroundColor = [UIColor clearColor];
        }
        if (fromString) {
            cell.title.text = @"TA的比赛";
        }else{
            cell.title.text = @"我的比赛";
        }
        cell.count.text = [NSString stringWithFormat:@"%@",personData.matchCnt];
        cell.bgView.backgroundColor = [UIColor colorWithHexString:@"#36383f"];
        return cell;
    }/*
    else if(indexPath.row == 7){
        BLCommenNewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell7"];
        if (cell == nil) {
            cell = [[BLCommenNewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyCell7"];
            cell.backgroundColor = [UIColor clearColor];
        }
        cell.icon.image = [UIImage imageNamed:@"guangzhu"];
        if (fromString) {
            cell.title.text = @"TA的关注";
        }else{
            cell.title.text = @"我的关注";
        }
        cell.count.text = [NSString stringWithFormat:@"%d",personData.guanzhuArray.count];
        cell.bgView.backgroundColor = [UIColor colorWithHexString:@"#3e4149"];
        return cell;
    }else if(indexPath.row == 8){
        BLCommenNewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell8"];
        if (cell == nil) {
            
            cell = [[BLCommenNewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyCell8"];
            cell.backgroundColor = [UIColor clearColor];
        }
        cell.icon.image = [UIImage imageNamed:@"fensi"];
        if (fromString) {
            cell.title.text = @"TA的粉丝";
        }else{
            cell.title.text = @"我的粉丝";
        }
        cell.count.text = [NSString stringWithFormat:@"%d",personData.funsArray.count];
        cell.bgView.backgroundColor = [UIColor colorWithHexString:@"#36383f"];
        return cell;
    }*/
      else if(indexPath.row == 5){
        BLCommenNewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell9"];
        if (cell == nil) {
            
            cell = [[BLCommenNewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyCell9"];
            cell.backgroundColor = [UIColor clearColor];
        }
        cell.icon.image = [UIImage imageNamed:@"xiangce"];
        if (fromString) {
            cell.title.text = @"TA的相册";
        }else{
            cell.title.text = @"我的相册";
        }
        cell.count.text = [NSString stringWithFormat:@"%@",personData.albumCnt];
        cell.bgView.backgroundColor = [UIColor colorWithHexString:@"#3e4149"];
        return cell;
    }else if(indexPath.row == 7){
        BLLoffCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell10"];
        if (cell == nil) {
            cell = [[BLLoffCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyCell10"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
            cell.delegate = self;
        }
        return cell;
    }
    else if (indexPath.row == 6){
        BLCommenNewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell11"];
        cell = [[BLCommenNewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyCell11"];
        cell.icon.image = [UIImage imageNamed:@"xiangce"];
        if (fromString) {
            cell.title.text = @"TA的竞猜";
        }else{
            cell.title.text = @"我的竞猜";
        }
        cell.count.text = [NSString stringWithFormat:@"%d",0];
        cell.bgView.backgroundColor = [UIColor colorWithHexString:@"#36383f"];
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }
    
    return nil;
    
}

#pragma mark - 退出登陆 -
-(void)logOff{
    [[BLUtils globalCache]setString:@"" forKey:@"uid"];
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.frame = CGRectMake((320-120)/2, self.view.frame.size.height/2, 120, 45);
//    [button setTitle:@"登录" forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(push:) forControlEvents:UIControlEventTouchUpInside];
//    [button dangerStyle];
//    
//    UIView *loginBG = [[UIView alloc]initWithFrame:self.view.bounds];
//    loginBG.tag = 9090;
//    loginBG.backgroundColor = [UIColor colorWithHexString:@"#383b44"];
//    [loginBG addSubview:button];
//    [self.view addSubview:loginBG];
//    
//    [self.view bringSubviewToFront:loginBG];
//    [self.view addSubview:button];
//    _tableView.hidden = YES;
    personData = nil;
    [self initLoginView];
    
//    [self addRightNavItemWithImg:@"" hImg:@"" action:nil];
    
//    self.title = @"我";
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (fromString) {
        postId = personUID;//personData.teamid;
    }else{
        postId = uid;
    }
    if (indexPath.row == 2) {
        BLMyVisitorsViewController *visitor = [[BLMyVisitorsViewController alloc]initWithNibName:nil bundle:nil];
        [self.navigationController pushViewController:visitor animated:YES];
//        NSLog(@"uid=%@",personData.uid);
        [visitor requestData:personData.uid];
        [[[BLUtils appDelegate] tabBarController]setTabBarHidden:YES animated:YES];
    }else if (indexPath.row == 0){
        BLMyHonourViewController *honour = [[BLMyHonourViewController alloc]initWithNibName:nil bundle:nil];
        honour.title = @"我的荣耀";
        if (personUID) {
            [honour requestData:nil uid:personUID from:fromString isAll:YES];
        }else{
            [honour requestData:nil uid:uid from:fromString isAll:YES];
        }

        [self.navigationController pushViewController:honour animated:YES];
        [[[BLUtils appDelegate] tabBarController]setTabBarHidden:YES animated:YES];
    }else if (indexPath.row == 3){
        
        NSString *myPostId;
        if (fromString) {
            myPostId = personData.teamid;
        }else{
            myPostId = uid;
        }
        
        if (personUID == NULL) {
            if (personData.teamid == NULL || [personData.teamid isEqual:@""]) {
                BLNoTeamDetailViewController * noteamView = [[BLNoTeamDetailViewController alloc]init];
                [self.navigationController pushViewController:noteamView animated:YES];
                [[[BLUtils appDelegate] tabBarController]setTabBarHidden:YES animated:YES];
            }else{
                BLMy_teamdetailViewController * teamsView = [[BLMy_teamdetailViewController alloc]init];
                teamsView.title = @"我的战队";
                [teamsView requestMy_teamdetail:myPostId from:fromString];
                [self.navigationController pushViewController:teamsView animated:YES];
                [[[BLUtils appDelegate] tabBarController]setTabBarHidden:YES animated:YES];
            }
        }else{
            if (personData.teamid == NULL || [personData.teamid isEqual:@""]) {
                [ShowLoading showErrorMessage:@"无战队" view:self.view];
            }else{
                BLMy_teamdetailViewController * teamsView = [[BLMy_teamdetailViewController alloc]init];
                teamsView.title = @"我的战队";
                
                [teamsView requestMy_teamdetail:myPostId from:fromString];
                
                [self.navigationController pushViewController:teamsView animated:YES];
                [[[BLUtils appDelegate] tabBarController]setTabBarHidden:YES animated:YES];
            }
        }
        
    }else if (indexPath.row == 4){
        BLMyGameViewController *myGame = [[BLMyGameViewController alloc]initWithNibName:nil bundle:nil];
        myGame.title = @"我的比赛";
        if (personUID) {
            [myGame requestData:personUID page:@"1" size:@"100"];
        }else{
            [myGame requestData:uid page:@"1" size:@"100"];
        }
        
        [self.navigationController pushViewController:myGame animated:YES];
        [[[BLUtils appDelegate] tabBarController]setTabBarHidden:YES animated:YES];
    }else if (indexPath.row == 7){
//        //关注
//        BLFollowersViewController *follower = [[BLFollowersViewController alloc]initWithNibName:nil bundle:nil];
//        follower.title = @"我的关注";
//        follower.funsORfollowers = @"followers";
//        if (personUID) {
//            [follower requestData:personUID funsORfollowers:@"followers"];
//        }else{
//             [follower requestData:uid funsORfollowers:@"followers"];
//        }
//        
//        [self.navigationController pushViewController:follower animated:YES];
//        [[[BLUtils appDelegate] tabBarController]setTabBarHidden:YES animated:YES];
    }else if (indexPath.row == 8){
        //粉丝
        BLFollowersViewController *funs = [[BLFollowersViewController alloc]initWithNibName:nil bundle:nil];
//        funs.funsORfollowers = @"funs";
        if (personUID) {
            [funs requestData:personUID funsORfollowers:@"funs"];
        }else{
            [funs requestData:uid funsORfollowers:@"funs"];
        }
        funs.title = @"我的粉丝";
        [self.navigationController pushViewController:funs animated:YES];
        [[[BLUtils appDelegate] tabBarController]setTabBarHidden:YES animated:YES];
    }else if (indexPath.row == 5){
        
        if (photosArray.count > 0) {
            [self presentModalViewController:self.browser animated:YES];
        }else{
            [self requestPhotoData:YES];
        }
        
    }else if (indexPath.row == 1){
        //改动
        if (fromString) {
            return;
        }
        BLGoldViewController * goldViewController = [[BLGoldViewController alloc] init];
        [goldViewController setGoldStr:[NSString stringWithFormat:@"%@",personData.coinCnt]];
        [self.navigationController pushViewController:goldViewController animated:YES];
        [[[BLUtils appDelegate] tabBarController]setTabBarHidden:YES animated:YES];
        
/*        ==============
        BLMyLevelViewController *levelViewController = [[BLMyLevelViewController alloc]initWithNibName:nil bundle:nil];
        [levelViewController from:personData.level];
        [self.navigationController pushViewController:levelViewController animated:YES];
        [[[BLUtils appDelegate] tabBarController]setTabBarHidden:YES animated:YES];
*/
    }
    else if (indexPath.row == 6){
        
    }
}

-(void)requestData:(NSString *)visitid{
//    NSString *path = @"signin/?tel=13718360863&passwd=5544";
    NSString *path;
//    NSString * nav = [[BLUtils globalCache]stringForKey:@"per"];
    if (personUID != nil) {
        path = [NSString stringWithFormat:@"my_infodetail/?uid=%@&visitid=%@",personUID,uid];
    }else{
        path = [NSString stringWithFormat:@"my_infodetail/?uid=%@",uid];
    }
    
    [ShowLoading showWithMessage:showloading view:self.view];
    [BLPersonData globalTimelinePostsWithBlock:^(NSArray *posts, NSError *error) {
        [ShowLoading hideLoading:self.view];
        [[BLUtils globalCache]setString:@"" forKey:@"reload"];
        if (error) {
            return ;
        }
        personData = [posts objectAtIndex:0];
        if ([personData.msg isEqualToString:@"succ"]) {
            [newHeaderView setDatas:personData];
            if (personUID) {
                newHeaderView.idLabel.text = [NSString stringWithFormat:@"ID：%@",personUID];;
            }else{
                newHeaderView.idLabel.text = [NSString stringWithFormat:@"ID：%@",uid];
            }
            if (fromString) {
               newHeaderView.takePhotoBtn.hidden = YES;
            }else{
                newHeaderView.takePhotoBtn.hidden = NO;
            }
            [self addNavBarTitle:personData.name action:nil];
            self.title = personData.name;
            
            [[BLUtils globalCache]setString:[NSString stringWithFormat:@"%@",personData.teamid] forKey:@"teamid"];
            
            if (personUID == nil) {
                if (personData.teamid == NULL || [personData.teamid isEqual:@""]) {
                    [[BLUtils globalCache]setString:@"No" forKey:@"isTeam"];
                }else{
                    [[BLUtils globalCache]setString:@"Yes" forKey:@"isTeam"];
                }
            }
            
            [[self.view viewWithTag:9090]removeFromSuperview];
            [_tableView reloadData];
//            _tableView.hidden = NO;
        }else{
            [ShowLoading showErrorMessage:personData.msg view:self.view];
        }
        
    } path:path];
}

-(void)initRgithButton{
    
//    [self addRightNavItemWithImg:@"edit_normal" hImg:@"edit_press" action:@selector(pushToMyEditView)];
    [self addNavRightText:@"编辑" action:@selector(pushToMyEditView)];
}

-(void)pushToMyEditView{
    BLEditingViewController *editView = [[BLEditingViewController alloc]initWithNibName:@"BLEditingViewController" bundle:nil];
    
    [self.navigationController pushViewController:editView animated:YES];
    
    NSArray *personInfo = @[personData.sex,personData.birth,personData.heightS,personData.weightS,personData.ballnumber,personData.school,personData.college,personData.shoes,personData.size];
    
    editView.personData = personInfo;
    [[BLUtils appDelegate].tabBarController setTabBarHidden:YES animated:YES];
}

-(void)didclick:(UIButton *)button{
    if (button.tag == 99) {

        [self requestPhotoData:YES];
        return;
        //相册

    }else if (button.tag == 100){
        //关注
        BLFollowersViewController *follower = [[BLFollowersViewController alloc]initWithNibName:nil bundle:nil];
        follower.title = @"我的关注";
        follower.funsORfollowers = @"followers";
        //        follower.followers = personData.guanzhuArray;
        [self.navigationController pushViewController:follower animated:YES];
        
    }else if (button.tag == 101){
        //粉丝
        BLFollowersViewController *funs = [[BLFollowersViewController alloc]initWithNibName:nil bundle:nil];
        funs.funsORfollowers = @"funs";
        funs.title = @"我的粉丝";
        //        follower.followers = personData.guanzhuArray;
        [self.navigationController pushViewController:funs animated:YES];
    }else if (button.tag == 98){
        //比赛
        BLMyGameViewController * scheduleView = [[BLMyGameViewController alloc]init];
        scheduleView.title = @"我的比赛";
        [self.navigationController pushViewController:scheduleView animated:YES];
    }
    isIcon = NO;
    [[BLUtils appDelegate].tabBarController setTabBarHidden:YES animated:YES];

}

-(void)requestPhotoData:(BOOL)push{
    NSString *path = [NSString stringWithFormat:@"my_albumlist/?uid=%@",postId];
    
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
                [self.photoDataSource removeAllObjects];
                [self initPhotos:nil];
                [ShowLoading showErrorMessage:@"暂无数据" view:self.view];
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
    UILabel *titleLabel = (UILabel *)[navBarView viewWithTag:BROWSER_TITLE_LBL_TAG];
    if (self.photoDataSource.count == 1 || self.photoDataSource.count == 0) {
        titleLabel.text = [NSString stringWithFormat:@"%i/%i", self.photoDataSource.count, self.photoDataSource.count];
    }
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
    
//    [self.navigationController pushViewController:self.browser animated:YES];
    
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

        UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        deleteBtn.frame = CGRectMake(size.width-40, 9.5+y, 25, 25);
        [deleteBtn setBackgroundImage:[UIImage imageNamed:@"Delete_normal"]
                       forState:UIControlStateNormal];
        [deleteBtn setBackgroundImage:[UIImage imageNamed:@"Delete_press"]
                       forState:UIControlStateHighlighted];
        [deleteBtn addTarget:self action:@selector(delete) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        addBtn.frame = CGRectMake(size.width-80, 9.5+y, 25, 25);
        [addBtn setBackgroundImage:[UIImage imageNamed:@"addRightBtn_normal"]
                             forState:UIControlStateNormal];
        [addBtn setBackgroundImage:[UIImage imageNamed:@"addRightBtn_press"]
                             forState:UIControlStateHighlighted];
        [addBtn addTarget:self action:@selector(addPhoto) forControlEvents:UIControlEventTouchUpInside];
        
        if (!fromString) {
            [navBarView addSubview:addBtn];
            [navBarView addSubview:deleteBtn];
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
        
        [btn2 addTarget:self action:@selector(dismissMod) forControlEvents:UIControlEventTouchUpInside];
        [btn2 setBackgroundColor:[UIColor clearColor]];
        [btn setBackgroundImage:[UIImage imageNamed:@"back_normal"]
                       forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"back_selected"]
                       forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(dismissMod) forControlEvents:UIControlEventTouchUpInside];
//        [view addSubview:btn];
//        [view addSubview:btn2];
        [navBarView addSubview:btn2];
        [navBarView addSubview:btn];
    }
    
    return navBarView;
}

//更换头像
-(void)changeIcon{
    isIcon = YES;
    [self showAddPhotoAction:nil];
}

-(void)dismissMod{
    
    [personData setAlbumCnt:[NSString stringWithFormat:@"%d",_photoDataSource.count]];
    
    [self dismissModalViewControllerAnimated:YES];
}

-(void)delete{
    
    BLAlertViewController *alertView = [[BLAlertViewController alloc]initWithNibName:@"BLAlertViewController" bundle:nil];
    alertView.delegate = self;
    [self.browser presentPopupViewController:alertView animationType:MJPopupViewAnimationSlideBottomBottom];
//    BLPhoto *photo = [photosArray objectAtIndex:currentIndex];
//    [self sendToServerDelId:photo.imgid];
//    [_photoDataSource removeObjectAtIndex:currentIndex];
//    [self.browser reloadData];
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

-(void)sendToServerDelId:(NSString *)imgId{
    NSString *path = [NSString stringWithFormat:@"my_albumdel/?id=%@",imgId];//@"my_albumdel/?id=20"
    [BLPhoto globalTimelinePostsWithBlock:^(NSArray *posts, NSError *error) {
        if (error) {
            return ;
        }
        if (posts.count > 0) {
            
            BLPhoto *photo = [posts objectAtIndex:0];
            
            if ([photo.msg isEqualToString:@"succ"]) {
                [ShowLoading showSuccView:self.browser.view message:@"删除成功！"];
                [self requestPhotoData:NO];
            }else{
                [ShowLoading showErrorMessage:@"删除失败！" view:self.browser.view];
            }
        }
    } path:path];
}

-(void)addPhoto{
//    NSURL *imgURL = [NSURL URLWithString:@"http://h.hiphotos.baidu.com/image/w%3D2048/sign=7b61fe27d488d43ff0a996f24926d31b/4afbfbedab64034fff929b54adc379310a551d00.jpg"];
//    DemoPhoto *photo = [[DemoPhoto alloc] initWithURL:imgURL];
//    [self.photoDataSource addObject:photo];
//    [self.browser reloadData];
    
    isIcon = NO;
    
    [self showAddPhotoAction:nil];
    
}

-(void)showAddPhotoAction:(UIButton *)button{
    sexAction = [[IBActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitlesArray:@[@"照相机", @"相册"]];
    [sexAction setButtonBackgroundColor:[UIColor colorWithHexString:@"#55585f"]];
    [sexAction setButtonTextColor:[UIColor whiteColor]];
    [sexAction setButtonBackgroundColor:[UIColor colorWithHexString:@"#ac3726"] forButtonAtIndex:2];
    if (isIcon) {
        [[[BLUtils appDelegate] tabBarController] view];
        [sexAction showInView:[[[BLUtils appDelegate] tabBarController] view]];
    }else{
        [sexAction showInView:self.browser.view];
    }
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
    
    if (isIcon) {
        [self presentViewController:imagePicker animated:YES completion:^{
        }];
    }else{
        
        [self.browser presentViewController:imagePicker animated:YES completion:^{
        }];
    }
    
    
}


// 打开相册
- (void)openPics {
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate = self;
//    [self.browser  presentViewController:imagePicker animated:YES completion:^{
//    }];
    
    if (isIcon) {
        [self presentViewController:imagePicker animated:YES completion:^{
        }];
    }else{
        
        [self.browser presentViewController:imagePicker animated:YES completion:^{
        }];
    }
    
}

// 选中照片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSLog(@"%@", info);
//    UIImageView  *imageView = (UIImageView *)[self.view viewWithTag:101];
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
    
    UIImage *tempImage = [self scaleImage:image toScale:0.3];
    [self saveImage:tempImage WithName:mfilePath];
    iconImage = tempImage;
    [self upload];
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

-(void)upload{
    
//    [request cancel];
//	[self setRequest:[ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"http://115.29.137.26/interface/my_albumadd/"]]];
    
    NSString *path ;
    if (isIcon) {
        path = [NSString stringWithFormat:@"%@my_icon/",base_url];
    }else{
        path = [NSString stringWithFormat:@"%@my_albumadd/",base_url];
    }
    
    self.request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:path]];
	[request setPostValue:uid forKey:@"uid"];

    [request setTimeOutSeconds:60];
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0
	[request setShouldContinueWhenAppEntersBackground:YES];
#endif
//	[request setUploadProgressDelegate:progressIndicator];
	[request setDelegate:self];
	[request setDidFailSelector:@selector(uploadFailed:)];
	[request setDidFinishSelector:@selector(uploadFinished:)];
    if(isIcon){
        [request setFile:filePath forKey:[NSString stringWithFormat:@"Icons[file]"]];
    }else{
        [request setFile:filePath forKey:[NSString stringWithFormat:@"Album[file]"]];
    }

	[request startAsynchronous];

}

- (void)uploadFailed:(ASIHTTPRequest *)theRequest
{
	[ShowLoading showErrorMessage:@"上传失败!" view:self.browser.view];
}

- (void)uploadFinished:(ASIHTTPRequest *)theRequest
{
//	[ShowLoading showSuccView:self.browser.view message:@"上传成功！"];
//    CXPhoto *photo = [[CXPhoto alloc]initWithFilePath:filePath];
//    [self.photoDataSource addObject:photo];
//    [self.browser reloadData];
    if (!isIcon) {
        [self requestPhotoData:NO];
    }else{
        [newHeaderView.loadPersonIcon setImage:iconImage];
    }
}

#pragma mark- 缩放图片
-(UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize
{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width*scaleSize,image.size.height*scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height *scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}


- (void)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName
{
    NSData *imageData = UIImageJPEGRepresentation(tempImage,.50f);
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
        if (photoBrowser.photoCount==0) {
            titleLabel.text = [NSString stringWithFormat:@"%i/%i", index, photoBrowser.photoCount];
        }else{
           titleLabel.text = [NSString stringWithFormat:@"%i/%i", index+1, photoBrowser.photoCount];
        }
        
    }
    
}

- (BOOL)supportReload
{
    return YES;
}

-(void)initUID:(BLPersonData *)loginPersonData{
//    uid = loginUid;
    personData = loginPersonData;
    postId = loginPersonData.uid;
    uid = loginPersonData.uid;
    if (!personData) {
        [self performSelector:@selector(requestData:) withObject:nil afterDelay:0.3];
//        [self requestData:nil];
    }
    [_tableView reloadData];
    self.photoDataSource = [NSMutableArray array];
    [self initRgithButton];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
        [self setNeedsStatusBarAppearanceUpdate];
    }
    
    NSString *reload = [[BLUtils globalCache]stringForKey:@"reload"];
    if (reload.length > 0) {
       [self requestData:nil];
    }
    if (!fromString) {
        if (!personData) {
            
            uid = [[BLUtils globalCache]stringForKey:@"uid"];
            if (uid.length > 0) {
                [self requestData:nil];
                [self initRgithButton];
            }else{
                [self initLoginView];
            }
        }else{
            _tableView.hidden = NO;
            [newHeaderView setDatas:personData];
            newHeaderView.idLabel.text = [NSString stringWithFormat:@"ID：%@",uid];
            newHeaderView.takePhotoBtn.hidden = NO;
            [_tableView reloadData];
        }
        
        [[BLUtils appDelegate].tabBarController setTabBarHidden:NO animated:NO];
        if (iPhone5) {
            _tableView.frame = iPhone5_frame_tab;
        }else{
            _tableView.frame = iPhone4_frame_tab;
        }
//        [self initRgithButton];
        [[BLUtils globalCache]setString:@"" forKey:@"home"];
        [[BLUtils globalCache]setString:@"我的" forKey:@"whose"];
    }else if([fromString isEqualToString:@"visitor"]){
        [[BLUtils globalCache]setString:@"首页" forKey:@"home"];
    }
    else{
        [[BLUtils globalCache]setString:@"TA的" forKey:@"whose"];
    }
    
}

-(void)removeLoginView{
    [username removeFromSuperview];
    [password removeFromSuperview];
    [[self.view viewWithTag:1213]removeFromSuperview];
    [[self.view viewWithTag:1212]removeFromSuperview];
    [[self.view viewWithTag:1211]removeFromSuperview];
    [[self.view viewWithTag:111]removeFromSuperview];
    [_loginButton removeFromSuperview];
    [loginView removeFromSuperview];
}

-(void)initLoginView{
    
    [self showKeyboard];
    [loginView removeFromSuperview];
    loginView = nil;
    CGRect cgrect = self.view.frame;
    cgrect.origin = CGPointMake(0, 0);
    loginView = [[UIView alloc]initWithFrame:cgrect];
    
    _tableView.hidden = YES;
    /* 输入框背景图 */
    UIImage *image = [[UIImage imageNamed:@"textBg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 176+44+4, 281, 44)];
    imageView.image = image;
    imageView.tag = 1211;
    [loginView addSubview:imageView];
    
    UIImageView *textImg = [[UIImageView alloc]initWithFrame:CGRectMake(23, 12, 20, 20)];
    textImg.image = [UIImage imageNamed:@"pwdIcon.png"];
    [imageView addSubview:textImg];
    
    UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(20, 176, 281, 44)];
    imageView1.image = image;
    imageView1.tag = 1212;
    [loginView addSubview:imageView1];
    
    UIImageView *imageView3 = [[UIImageView alloc]initWithFrame:CGRectMake(98, 25, 125, 125)];
    imageView3.image = [UIImage imageNamed:@"loginLOGO.png"];
    imageView3.tag = 1213;
    [loginView addSubview:imageView3];
    
    UIImageView *textImg1 = [[UIImageView alloc]initWithFrame:CGRectMake(23, 12, 20, 20)];
    textImg1.image = [UIImage imageNamed:@"loginTextIcon.png"];
    [imageView1 addSubview:textImg1];
    
    /*用户名 和 密码*/
    username = [[BLTextField alloc]initWithFrame:CGRectMake(80, 176+6, 200, 32)];
    username.font = [UIFont boldSystemFontOfSize:17.0f];
    username.backgroundColor = [UIColor clearColor];
    username.textColor = [UIColor grayColor];
    username.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    username.placeholder = @"账号";
    username.delegate = self;
    username.tag = 9080;
    [username setReturnKeyType:UIReturnKeyNext];
    [loginView addSubview:username];
    
    password = [[BLTextField alloc]initWithFrame:CGRectMake(80, 176+6+44+4, 200, 32)];
    password.font = [UIFont boldSystemFontOfSize:17.0f];
    password.backgroundColor = [UIColor clearColor];
    password.textColor = [UIColor colorWithHexString:@"#666666"];
    password.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    password.placeholder = @"密码";
    password.secureTextEntry = YES;
    password.delegate = self;
    [password setReturnKeyType:UIReturnKeyDone];
    [loginView addSubview:password];
    
    //忘记密码 // 变为注册
    UIButton *forgetPwd = [UIButton buttonWithType:UIButtonTypeCustom];
    forgetPwd.frame = CGRectMake(200, 336-64+5, 80, 21);
    [forgetPwd setTitle:@"注册" forState:UIControlStateNormal];
    forgetPwd.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    [forgetPwd setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [forgetPwd addTarget:self action:@selector(clickRightButton) forControlEvents:UIControlEventTouchUpInside];
    [loginView addSubview:forgetPwd];
    
    UIButton *regBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    regBtn.frame = CGRectMake(221+40, 336-64+5, 20, 20);
    [regBtn setBackgroundImage:[UIImage imageNamed:@"zhuce@2x"] forState:UIControlStateNormal];
    [regBtn addTarget:self action:@selector(clickRightButton) forControlEvents:UIControlEventTouchUpInside];
    [loginView addSubview:regBtn];
    
    UILabel *tipsLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 336-65, 220, 20)];
    tipsLabel.backgroundColor = [UIColor clearColor];
    tipsLabel.font = [UIFont systemFontOfSize:13.0f];
    tipsLabel.textColor = [UIColor grayColor];
    tipsLabel.text = @"如忘记密码,请联系现场工作人员";
    [loginView addSubview:tipsLabel];
    
    _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _loginButton.frame = CGRectMake(20, 312, 281, 44);
    [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [_loginButton dangerStyle];
    _loginButton.tag = 112;
    [_loginButton addTarget:self action:@selector(dissmis:) forControlEvents:UIControlEventTouchUpInside];
    [loginView addSubview:_loginButton];
    
    [self.view addSubview:loginView];
    [self addNavRightText:@"" action:nil];
    
}

-(void)login:(UIButton *)sender{
    
    if ([sender tag] == 110) {
        
    }else if([sender tag] == 111){
        
        [self removeLoginView];
        BLFindPwdViewController *findPwd = [[BLFindPwdViewController alloc]initWithNibName:nil bundle:nil];
        findPwd.title = @"找回密码" ;
        //
        [self.navigationController pushViewController:findPwd animated:YES];
        [[BLUtils appDelegate].tabBarController setTabBarHidden:YES animated:YES];
        
    }else if ([sender tag] == 112){
        
        [self LoginAction];
            
    }
}

- (IBAction)dissmis:(UIButton *)sender {
    [self resignResponer];
    [self performSelector:@selector(login:) withObject:sender afterDelay:0.35];
}

-(void)LoginAction{
    
    if (username.text.length <4) {
        [ShowLoading showErrorMessage:@"账号不能小于4位！" view:self.view];
        return;
    }else if (password.text.length < 6){
        [ShowLoading showErrorMessage:@"密码不能小于6位！" view:self.view];
        return;
    }
    
    [ShowLoading showWithMessage:@"登录中..." view:self.view];
    NSString *path = [NSString stringWithFormat:@"signin/?username=%@&passwd=%@",username.text,password.text];
    
    [BLPersonData globalTimelinePostsWithBlock:^(NSArray *posts, NSError *error) {
        
        [ShowLoading hideLoading:self.view];
        
        if (error) {
            
        }
        if (posts.count > 0) {
            personData = [posts objectAtIndex:0];
            if ([personData.msg isEqualToString:@"succ"]) {
                
                [[BLUtils globalCache]setString:personData.uid forKey:@"uid"];
                uid = personData.uid;
                [[BLUtils appDelegate]setAPTags:personData.uid];//像服务器发送uid
                [self removeLoginView];
                
                [newHeaderView setDatas:personData];
                if (personUID) {
                    newHeaderView.idLabel.text = [NSString stringWithFormat:@"ID：%@",personUID];;
                }else{
                    newHeaderView.idLabel.text = [NSString stringWithFormat:@"ID：%@",uid];
                }
                if (fromString) {
                    newHeaderView.takePhotoBtn.hidden = YES;
                }else{
                    newHeaderView.takePhotoBtn.hidden = NO;
                }
                [self addNavBarTitle:personData.name action:nil];
                self.title = personData.name;
                
                [[BLUtils globalCache]setString:[NSString stringWithFormat:@"%@",personData.teamid] forKey:@"teamid"];
                
                if (personUID == nil) {
                    if (personData.teamid == NULL || [personData.teamid isEqual:@""]) {
                        [[BLUtils globalCache]setString:@"No" forKey:@"isTeam"];
                    }else{
                        [[BLUtils globalCache]setString:@"Yes" forKey:@"isTeam"];
                    }
                }
                
                _tableView.hidden = NO;
                [_tableView reloadData];
                [self initRgithButton];
                
            }else{
                [ShowLoading showErrorMessage:personData.msg view:self.view];
            }
        }
        
    } path:path];
}

-(void)clickRightButton{
    
    [self resignResponer];
    [self removeLoginView];
    BLRegViewController *regViewController = [[BLRegViewController alloc]initWithNibName:@"BLRegViewController" bundle:nil];
    regViewController.isNext = @"YES";
    regViewController.title = @"注册" ;
    [self.navigationController pushViewController:regViewController animated:YES];
    [[BLUtils appDelegate].tabBarController setTabBarHidden:YES animated:YES];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.tag == 9080) {
        [password becomeFirstResponder];
    }else{
        [self resignResponer];
        [self LoginAction];
    }
    return YES;
}// called when 'return' key pressed. return NO to ignore.


//注册键盘通知事件
-(void)showKeyboard{
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center  addObserver:self selector:@selector(keyboardDidShow) name:UIKeyboardDidShowNotification  object:nil];
    [center addObserver:self selector:@selector(keyboardDidHide) name:UIKeyboardWillHideNotification object:nil];
    
}

-(void)resignResponer {
    [username resignFirstResponder];
    [password resignFirstResponder];
}

//显示键盘
-(void)keyboardDidShow{
    
    loginy = (password.frame.origin.y+216-3-64)-self.view.frame.size.height;
    [UIView animateWithDuration:0.3f animations:^{
        if (iPhone5 && ios7) {
            loginView.frame = CGRectMake(0, loginy,loginView.frame.size.width, loginView.frame.size.height);
        }else if (ios7){
            loginView.frame = CGRectMake(0, -160,loginView.frame.size.width, loginView.frame.size.height);
        }else{
            loginView.frame = CGRectMake(0, -160,loginView.frame.size.width, loginView.frame.size.height);
            
        }
        
    }];
}

//隐藏键盘
-(void)keyboardDidHide{
    [UIView animateWithDuration:0.2f animations:^{
        if (iPhone5 && ios7) {
            loginView.frame = CGRectMake(0, 0,loginView.frame.size.width, loginView.frame.size.height);
        }else if (ios7){
            loginView.frame = CGRectMake(0, 0,loginView.frame.size.width, loginView.frame.size.height);
        }else{
            loginView.frame = CGRectMake(0, 0,loginView.frame.size.width, loginView.frame.size.height);
        }
        
    }];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
