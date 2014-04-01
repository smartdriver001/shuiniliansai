//
//  BLMyTeamStatisticsViewController.m
//  BasketballLeague
//
//  Created by 崔洪禄 on 14-3-4.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLMyTeamStatisticsViewController.h"
#import "BLBaseObject.h"
#import "BLData.h"
#import "BLTotalAndAvg.h"
#import "UIColor+Hex.h"
#import "BLMyTeamStantisCell.h"
#import "BLMyViewController.h"

@interface BLMyTeamStatisticsViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * _tableView;
    float navHigh;
    UIButton * averageButton;
    UIButton * totalButton;
}

@property (nonatomic,strong) NSMutableArray * totalArray;
@property (nonatomic,strong) NSMutableArray * avgArray;

@property (nonatomic,strong) NSMutableArray * allArray;

@end

@implementation BLMyTeamStatisticsViewController

@synthesize totalArray;
@synthesize avgArray;
@synthesize allArray;

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
    self.totalArray = [NSMutableArray arrayWithCapacity:0];
    self.avgArray = [NSMutableArray arrayWithCapacity:0];
    self.allArray = [NSMutableArray arrayWithCapacity:0];
    
//    NSString * nav = [[BLUtils globalCache]stringForKey:@"navigation"];
//    if ([nav isEqualToString:@"noNav"]) {
//        if (ios7) {
//            navHigh = 64;
//        }else{
//            navHigh = 44;
//        }
//        [self addNavBar];
//        [self addNavBarTitle:@"技术统计" action:nil];
//        [self addLeftNavBarItem:@selector(leftButtonClick)];
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
//            [self addNavBarTitle:@"技术统计" action:nil];
//            [self addLeftNavBarItem:@selector(leftButtonClick)];
//            
//        }else{
//            navHigh = 0;
//            [self addNavText:@"技术统计" action:nil];
//            [self addLeftNavItem:@selector(leftButtonClick)];
//        }
//    }
    
//    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, navHigh, 320, 44)];
//    view.backgroundColor = [UIColor colorWithHexString:@"3E4149"];
//    [self.view addSubview:view];
    
    _tableView = [[UITableView alloc]init];

    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
//    [self performSelector:@selector(requestTotalAndAvg) withObject:nil afterDelay:0.2];
}

-(void)setTeamName:(NSString *)teamName
{
    UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
    headerView.backgroundColor = [UIColor clearColor];
    
    UILabel * teamLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, 89, 30)];
    teamLabel.text = teamName;
    teamLabel.textColor = [UIColor whiteColor];
    teamLabel.textAlignment = UITextAlignmentCenter;
    teamLabel.font = [UIFont systemFontOfSize:15];
    teamLabel.backgroundColor = [UIColor colorWithHexString:@"55585F"];
    [headerView addSubview:teamLabel];
    
    NSArray * array = [NSArray arrayWithObjects:@"得分",@"篮板",@"助攻",@"远投",@"抢断",@"盖帽", nil];
    for (int i = 0; i < 6; i++) {
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(89 + i*38.5, 10, 38.5, 30)];
        label.backgroundColor = [UIColor clearColor];
        label.text = [array objectAtIndex:i];
        label.textAlignment = UITextAlignmentCenter;
        label.textColor = [UIColor colorWithHexString:@"FBB03B"];
        label.font = [UIFont systemFontOfSize:15];
        label.backgroundColor = [UIColor colorWithHexString:@"3C3E45"];
        [headerView addSubview:label];
    }
    
    _tableView.tableHeaderView = headerView;
}

- (UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * footer = [[UIView alloc]init];
    footer.backgroundColor = [UIColor clearColor];
    UILabel * teamLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 89, 30)];
    teamLabel.text = @"总计";
    teamLabel.textColor = [UIColor colorWithHexString:@"FF0000"];
    teamLabel.textAlignment = UITextAlignmentCenter;
    teamLabel.font = [UIFont systemFontOfSize:15];
    if (totalArray.count % 2 == 1) {
        teamLabel.backgroundColor = [UIColor colorWithHexString:@"55585F"];
    }else{
        teamLabel.backgroundColor = [UIColor colorWithHexString:@"3D3E43"];
    }
    [footer addSubview:teamLabel];
    
    [allArray removeAllObjects];
    if (totalButton.selected == YES) {
        if (totalArray.count > 0) {
            BLTotalAndAvg * total = [totalArray objectAtIndex:totalArray.count - 1];
            
            [allArray addObject:[NSString stringWithFormat:@"%@",total.defen]];
            [allArray addObject:[NSString stringWithFormat:@"%@",total.lanban]];
            [allArray addObject:[NSString stringWithFormat:@"%@",total.zhugong]];
            [allArray addObject:[NSString stringWithFormat:@"%@",total.yuantou]];
            [allArray addObject:[NSString stringWithFormat:@"%@",total.qiangduan]];
            [allArray addObject:[NSString stringWithFormat:@"%@",total.gaimao]];
        }
    }else if (averageButton.selected == YES){
        if (avgArray.count > 0) {
            BLTotalAndAvg * avg = [avgArray objectAtIndex:avgArray.count - 1];
            
            [allArray addObject:[NSString stringWithFormat:@"%@",avg.defen]];
            [allArray addObject:[NSString stringWithFormat:@"%@",avg.lanban]];
            [allArray addObject:[NSString stringWithFormat:@"%@",avg.zhugong]];
            [allArray addObject:[NSString stringWithFormat:@"%@",avg.yuantou]];
            [allArray addObject:[NSString stringWithFormat:@"%@",avg.qiangduan]];
            [allArray addObject:[NSString stringWithFormat:@"%@",avg.gaimao]];
        }
    }
    
    for (int i = 0; i < allArray.count; i++) {
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(89 + i*38.5, 0, 38.5, 30)];
        label.backgroundColor = [UIColor clearColor];
        label.text = [allArray objectAtIndex:i];
        label.textAlignment = UITextAlignmentCenter;
        label.textColor = [UIColor colorWithHexString:@"FF0000"];
        label.font = [UIFont systemFontOfSize:15];
        label.backgroundColor = [UIColor colorWithHexString:@"36383F"];
        if (totalArray.count % 2 == 1) {
            teamLabel.backgroundColor = [UIColor colorWithHexString:@"3C3E45"];
        }else{
            teamLabel.backgroundColor = [UIColor colorWithHexString:@"36383F"];
        }
        [footer addSubview:label];
    }
    
    return footer;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 30;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return totalArray.count - 1;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BLMyTeamStantisCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[BLMyTeamStantisCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    BLTotalAndAvg * total = [totalArray objectAtIndex:indexPath.row];
    
    BLTotalAndAvg * avg = [avgArray objectAtIndex:indexPath.row];
    
    if (totalButton.selected == YES) {
        [cell setData:total :indexPath];
    }else if (averageButton.selected == YES){
        [cell setData:avg :indexPath];
    }
    
    return cell;
}

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    
//    BLMyViewController *myView = [[BLMyViewController alloc]initWithNibName:nil bundle:nil];
//    
//    BLTotalAndAvg * total = [totalArray objectAtIndex:indexPath.row];
//    
//    [myView setVisitid:@"" andName:@"" from:@"技术统计"];
//}

-(void)requestData:(NSString *)matchId from:(NSString *)from{
    
    NSString *homeString = [[BLUtils globalCache]stringForKey:@"home"];
    if (from && [homeString isEqualToString:@""]) {
        [self addNavText:@"技术统计" action:nil];
        [self addLeftNavItem:@selector(leftButtonClick)];
        navHigh = 0;
        if (iPhone5) {
            _tableView.frame = CGRectMake(0, navHigh + 44, 320, 548 - 88);
        }else{
            _tableView.frame = CGRectMake(0, navHigh + 44, 320, 460 - 88);
        }
    }else{
        [self addNavBar];
        [self addNavBarTitle:@"技术统计" action:nil];
        [self addLeftNavBarItem:@selector(leftButtonClick)];
        
        if (ios7) {
            navHigh = 64;
        }else{
            navHigh = 44;
        }
        
        if (iPhone5) {
            _tableView.frame = CGRectMake(0, navHigh + 44, 320, 548 - 88);
        }else{
            _tableView.frame = CGRectMake(0, navHigh + 44, 320, 460 - 88);
        }
    }
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, navHigh, 320, 44)];
    view.backgroundColor = [UIColor colorWithHexString:@"43464D"];
    [self.view addSubview:view];
    
    totalButton = [UIButton buttonWithType:UIButtonTypeCustom];
    totalButton.frame = CGRectMake(30, 7, 110, 30);
    [totalButton setBackgroundImage:[UIImage imageNamed:@"button_Click"] forState:UIControlStateNormal];
    [totalButton setBackgroundImage:[UIImage imageNamed:@"tableViewCellBlack"] forState:UIControlStateSelected];
    [totalButton setTitle:@"总计" forState:UIControlStateNormal];
    [totalButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [totalButton addTarget:self action:@selector(totalButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:totalButton];
    
    totalButton.selected = YES;
    
    averageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    averageButton.frame = CGRectMake(320-110-30, 7, 110, 30);
    [averageButton setBackgroundImage:[UIImage imageNamed:@"button_Click"] forState:UIControlStateNormal];
    [averageButton setBackgroundImage:[UIImage imageNamed:@"tableViewCellBlack"] forState:UIControlStateSelected];
    [averageButton setTitle:@"场均" forState:UIControlStateNormal];
    [averageButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [averageButton addTarget:self action:@selector(averageButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:averageButton];
    
    [self requestTotalAndAvg:matchId];
}

-(void)totalButtonClick
{
    totalButton.selected = YES;
    averageButton.selected = NO;
    
    [_tableView reloadData];
}

-(void)averageButtonClick
{
    averageButton.selected = YES;
    totalButton.selected = NO;
    
    [_tableView reloadData];
}

-(void)requestTotalAndAvg:(NSString *)matchid
{
    NSString *path = [NSString stringWithFormat:@"my_teamstatistics?teamid=%d",[matchid intValue]];
    [ShowLoading showWithMessage:showloading view:self.view];
    [BLBaseObject globalTimelinePostsWithBlock:^(NSArray *posts, NSError *error) {
        
        [ShowLoading hideLoading:self.view];
        
        if (error) {
            
        }
        if (posts.count > 0) {
            BLBaseObject *base = [posts objectAtIndex:0];
            if ([base.msg isEqualToString:@"succ"]) {
                
                totalArray = [NSMutableArray arrayWithArray:base.data.totalArray];
                avgArray = [NSMutableArray arrayWithArray:base.data.avgArray];
                
                [_tableView reloadData];
                
            }else{
                [ShowLoading showErrorMessage:base.msg view:self.view];
            }
        }
        
    } path:path];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
