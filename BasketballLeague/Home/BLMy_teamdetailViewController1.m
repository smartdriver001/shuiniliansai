//
//  BLMy_teamdetailViewController1.m
//  BasketballLeague
//
//  Created by 崔洪禄 on 14-3-9.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLMy_teamdetailViewController1.h"
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

@interface BLMy_teamdetailViewController1 ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    UITableView * _tableView;
    UIImageView * myTeamDetailImages;
    BLMy_teamMembers * myMember;
    NSString * imagesUrl;
    NSString * teamid;
}

@property (nonatomic,strong) NSMutableArray * myTeamDetailArray;

@end

@implementation BLMy_teamdetailViewController1

@synthesize myTeamDetailArray;

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
    [self.navigationController pushViewController:myTeamDitView animated:YES];
    if (myTeamDetailArray.count > 0) {
        BLData * data = [myTeamDetailArray objectAtIndex:0];
        [myTeamDitView setData:data :myMember :imagesUrl];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
//    [self addNavText:@"我的战队" action:nil];
//    [self addLeftNavItem:@selector(leftButtonClick)];
    [self addNavBar];
    [self addLeftNavBarItem:@selector(leftButtonClick)];
    
    self.myTeamDetailArray = [NSMutableArray array];
    imagesUrl = @"";
    
    [self requestMy_teamdetail];
    
    _tableView = [[UITableView alloc]init];
    _tableView.frame = [BLUtils frame];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    
    [self createTableHeaderView];
}

-(void)createTableHeaderView
{
    UIView * tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 160)];
    
    myTeamDetailImages = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 160)];
    myTeamDetailImages.userInteractionEnabled = YES;
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
    joinButton.frame = CGRectMake(320 - 30 - 70, 130 + 2.5, 70, 25);
    UIImage * normalRedImage = [[UIImage imageNamed:@"redButton_normal"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    UIImage * pressRedImage = [[UIImage imageNamed:@"redButton_press"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    [joinButton setBackgroundImage:normalRedImage forState:UIControlStateNormal];
    [joinButton setBackgroundImage:pressRedImage forState:UIControlStateNormal];
    [joinButton setTitleColor:[UIColor colorWithHexString:@"FFFFFF"] forState:UIControlStateNormal];
    joinButton.titleLabel.font = [UIFont systemFontOfSize:13];
    joinButton.tag = 100;
    [joinButton addTarget:self action:@selector(joinButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [myTeamDetailImages addSubview:joinButton];
    
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
    NSLog(@"imagesButton");
    
    BLMyImagesViewController * myImagesView = [[BLMyImagesViewController alloc]init];
    if (myTeamDetailArray.count > 0) {
        BLData * data = [myTeamDetailArray objectAtIndex:0];
        [myImagesView setImages:data.imagesArray];
    }
    [self.navigationController pushViewController:myImagesView animated:YES];
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
        
    }else if ([joinButton.titleLabel.text isEqualToString:@"加入球队"]){
        
        if (myTeamDetailArray.count > 0) {
            BLData * data = [myTeamDetailArray objectAtIndex:0];
            if (data.membersArray.count < 4) {
                //可以加入球队
                
            }else{
                //人员已满
                
            }
        }
        
    }
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
        return 220 + size.height + 30;
    }else{
        return 220 + 30;
    }
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * header = [[UIView alloc]init];
    header.backgroundColor = [UIColor clearColor];
    
    NSArray * array = [NSArray arrayWithObjects:@"成立时间",@"队长",@"口号",@"等级",@"经验值", nil];
    for (int i = 0; i < 5; i++) {
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
        NSArray * dataArray = [NSArray arrayWithObjects:[NSString stringWithFormat:@"  %@",data.createtime],[NSString stringWithFormat:@"  %@",data.captain],[NSString stringWithFormat:@"  %@",data.slogan],[NSString stringWithFormat:@"  %@",data.ranking],[NSString stringWithFormat:@"  %@",data.exprienceValue], nil];
        for (int i = 0; i < 5; i++) {
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
        rankingButton.frame = CGRectMake(85, 44 * 3, 320 - 85, 44);
        rankingButton.backgroundColor = [UIColor clearColor];
        [rankingButton addTarget:self action:@selector(rankingButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [header addSubview:rankingButton];
        
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(320 - 32, 44 * 3 + 12, 20, 20)];
        imageView.image = [UIImage imageNamed:@"arrow"];
        [header addSubview:imageView];
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
        introView.frame = CGRectMake(0, 220, 320, 30 + size.height);
        introLabel.frame = CGRectMake(15, 235, 290, size.height);
    }else{
        introView.frame = CGRectMake(0, 220, 320, 30);
        introLabel.frame = CGRectMake(15, 235, 290, 30);
    }
    [header addSubview:introView];
    [header addSubview:introLabel];
    
    return header;
}

-(void)rankingButtonClick
{
    NSLog(@"ranking");
    BLRankingViewController * rankingView = [[BLRankingViewController alloc]init];
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
    
    if (myTeamDetailArray.count > 0) {
        BLData * data = [myTeamDetailArray objectAtIndex:0];
        int count;
        if (data.membersArray.count > 4) {
            count = 4;
        }else{
            count = data.membersArray.count;
        }
        for (int i = 0; i < count; i++) {
            BLMy_teamMembers * member = [data.membersArray objectAtIndex:i];
            UIImageView * memberImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15 + i * 73.33f, 28.5, 70, 70)];
            [memberImageView setImageWithURL:[NSURL URLWithString:member.icon] placeholderImage:[UIImage imageNamed:@"placeholder"]];
            memberImageView.userInteractionEnabled = YES;
            [footer addSubview:memberImageView];
            
            UIButton * memButton = [UIButton buttonWithType:UIButtonTypeCustom];
            memButton.frame = CGRectMake(0, 0, 70, 70);
            memButton.backgroundColor = [UIColor clearColor];
            [memButton addTarget:self action:@selector(memButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            memButton.tag = 200 + i;
            [memberImageView addSubview:memButton];
        }
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
    switch (memButton.tag) {
        case 200:{
            NSLog(@"members1");
            break;
        }case 201:{
            NSLog(@"members2");
            break;
        }case 202:{
            NSLog(@"members3");
            break;
        }case 203:{
            NSLog(@"members4");
            break;
        }
        default:
            break;
    }
}

-(void)myTeamgameListbuttonClick
{
    NSLog(@"比赛情况");
    BLMyTeamGameListViewController * bmtglView = [[BLMyTeamGameListViewController alloc]init];
    if (myTeamDetailArray.count > 0) {
        BLData * data = [myTeamDetailArray objectAtIndex:0];
        [bmtglView requestData:data.teamid titile:data.teamname from:nil];
//        [bmtglView setNavTitle:[NSString stringWithFormat:@"%@",data.teamname]];
//        bmtglView.teamId = data.teamid;
        [self.navigationController pushViewController:bmtglView animated:YES];
    }
}

-(void)myTeamstatisticsbuttonClick
{
//    NSLog(@"技术统计");
    BLMyTeamStatisticsViewController * statisticsView = [[BLMyTeamStatisticsViewController alloc]init];
    [self.navigationController pushViewController:statisticsView animated:YES];
}

-(void)myTeamMaxbuttonClick
{
//    NSLog(@"各项最高");
    BLMyTeamMaxViewController * teamMaxView = [[BLMyTeamMaxViewController alloc]init];
//    teamMaxView.teamid = teamid;
    [teamMaxView requestMyTeamMax:teamid from:nil];
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

-(void)requestMy_teamdetail
{
    NSString * uid = @"2";
    
    NSString *path = [NSString stringWithFormat:@"my_teamdetail?uid=%@",uid];
    
    [BLBaseObject globalTimelinePostsWithBlock:^(NSArray *posts, NSError *error) {
        
        [ShowLoading hideLoading:self.view];
        
        if (error) {
            
        }
        if (posts.count > 0) {
            BLBaseObject *base = [posts objectAtIndex:0];
            if ([base.msg isEqualToString:@"succ"]) {
                
                [self performSelector:@selector(addNavTextAndDetailTextPerform) withObject:self afterDelay:.5];
                
                [myTeamDetailArray addObject:base.data];
                
                UIButton * joinButton = (UIButton *)[self.view viewWithTag:100];
                BOOL isMembers = NO;
                for (int i = 0; i < base.data.membersArray.count; i++) {
                    BLMy_teamMembers * members = [base.data.membersArray objectAtIndex:i];
                    if ([members.uid isEqualToString:uid]) {
                        if ([members.iscaptain intValue] == 1) {
                            [joinButton setTitle:@"解散球队" forState:UIControlStateNormal];
                            [self addRightNavItemWithImg:@"edit_normal" hImg:@"edit_press" action:@selector(rightButtonClick)];
                        }else{
                            [joinButton setTitle:@"退出球队" forState:UIControlStateNormal];
                        }
                        isMembers = YES;
                        myMember = members;
                    }
                }
                if (!isMembers){
                    [joinButton setTitle:@"加入本队" forState:UIControlStateNormal];
                }
                
                UILabel * imagesNumberLabel = (UILabel *)[self.view viewWithTag:101];
                imagesNumberLabel.text = [NSString stringWithFormat:@"共%d张",base.data.imagesArray.count];
                
                if (base.data.imagesArray.count > 0) {
                    BLMyteamImages * images = [base.data.imagesArray objectAtIndex:0];
                    [myTeamDetailImages setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",images.imgURL]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
                }
                
                UILabel * winCntLabel = (UILabel *)[self.view viewWithTag:102];
                winCntLabel.text = [NSString stringWithFormat:@"胜率：%@%@",base.data.winCnt,@"%"];
                
                imagesUrl = [NSString stringWithFormat:@"%@",base.data.icon];
                
                [_tableView reloadData];
                
                [self requestMyTeamGameList:[NSString stringWithFormat:@"%@",base.data.teamid]];
                
            }else{
                [ShowLoading showErrorMessage:base.msg view:self.view];
            }
        }
        
    } path:path];
}

-(void)requestMyTeamGameList:(NSString *)teamID
{
    teamid = teamID;
    //    NSString * uid = @"2";
    
    NSString *path = [NSString stringWithFormat:@"my_teamgamelist?teamid=%@",teamID];
    
    [BLBaseObject globalTimelinePostsWithBlock:^(NSArray *posts, NSError *error) {
        
        [ShowLoading hideLoading:self.view];
        
        if (error) {
            
        }
        if (posts.count > 0) {
            BLBaseObject *base = [posts objectAtIndex:0];
            if ([base.msg isEqualToString:@"succ"]) {
                
                UIButton * button = (UIButton *)[self.view viewWithTag:150];
                UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(85, 0, 40, 30)];
                label.textColor = [UIColor grayColor];
                label.textAlignment = UITextAlignmentCenter;
                label.font = [UIFont systemFontOfSize:13];
                label.backgroundColor = [UIColor clearColor];
                label.text = [NSString stringWithFormat:@"%d场",base.data.listsArray.count];
                [button addSubview:label];
                
            }else{
                [ShowLoading showErrorMessage:base.msg view:self.view];
            }
        }
        
    } path:path];
}

-(void)addNavTextAndDetailTextPerform
{
    BLData * data = [myTeamDetailArray objectAtIndex:0];
    [self addNavTextAndDetailText:@"我的战队" :[NSString stringWithFormat:@"%@",data.teamname] action:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
