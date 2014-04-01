//
//  BLsinglegameViewController1.m
//  BasketballLeague
//
//  Created by 崔洪禄 on 14-3-9.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLsinglegameViewController1.h"
#import "UIColor+Hex.h"
#import "BLBaseObject.h"
#import "BLSinglegameTableHeaderView.h"
#import "BLSingleUser.h"
#import "BLSinglegameCell.h"
#import "BLMyViewController.h"

@interface BLsinglegameViewController1 ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
    
    float navHigh;
}
@property (nonatomic,strong) NSMutableArray * singleArray;

@end

@implementation BLsinglegameViewController1

@synthesize singleArray;

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
    self.singleArray = [NSMutableArray arrayWithCapacity:0];
    
    _tableView = [[UITableView alloc]init];
    
//    NSString * nav = [[BLUtils globalCache]stringForKey:@"navigation"];
//    if ([nav isEqualToString:@"noNav"]) {
//        if (ios7) {
//            navHigh = 64;
//        }else{
//            navHigh = 44;
//        }
//        [self addNavBar];
//        [self addNavBarTitle:@"统计" action:nil];
//        [self addLeftNavBarItem:@selector(leftButtonClick)];
//        
//        _tableView.frame = [BLUtils frame];
//    }else{
//        NSString * nav1 = [[BLUtils globalCache]stringForKey:@"per"];
//        
//        if ([nav1 isEqualToString:@"homePer"]) {
//            if (ios7) {
//                navHigh = 64;
//            }else{
//                navHigh = 44;
//            }
//            [self addNavBar];
//            [self addNavBarTitle:@"统计" action:nil];
//            [self addLeftNavBarItem:@selector(leftButtonClick)];
//            
//            _tableView.frame = [BLUtils frame];
//        }else{
//            navHigh = 0;
//            [self addNavText:@"统计" action:nil];
//            [self addLeftNavItem:@selector(leftButtonClick)];
//            
//            if (iPhone5) {
//                _tableView.frame = iPhone5_frame;
//            }else{
//                _tableView.frame = iPhone4_frame;
//            }
//        }
//        
//    }
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
    header.backgroundColor = [UIColor colorWithHexString:@"#383b44"];
    
    if (singleArray.count > 0) {
        BLData * data = [singleArray objectAtIndex:0];
        
        UILabel * teamLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
        if (section == 0) {
            teamLabel.text = [NSString stringWithFormat:@"%@",data.teamNameA];
        }else if (section == 1){
            teamLabel.text = [NSString stringWithFormat:@"%@",data.teamNameB];
        }
        teamLabel.textColor = [UIColor colorWithHexString:@"FFFFFF"];
        teamLabel.textAlignment = UITextAlignmentCenter;
        teamLabel.font = [UIFont systemFontOfSize:14];
        teamLabel.backgroundColor = [UIColor colorWithHexString:@"55585F"];
        [header addSubview:teamLabel];
        
        NSArray * array = [NSArray arrayWithObjects:@"得分",@"篮板",@"助攻",@"远投",@"抢断",@"盖帽", nil];
        for (int i = 0; i < 6; i++) {
            UILabel * statisticsLabel = [[UILabel alloc]initWithFrame:CGRectMake(80 + i * 40, 0, 40, 30)];
            statisticsLabel.text = [array objectAtIndex:i];
            statisticsLabel.textAlignment = UITextAlignmentCenter;
            statisticsLabel.font = [UIFont systemFontOfSize:14];
            statisticsLabel.textColor = [UIColor colorWithHexString:@"FBB03B"];
            [header addSubview:statisticsLabel];
            statisticsLabel.backgroundColor = [UIColor colorWithHexString:@"3C3E45"];
        }
    }
    
    return header;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 40;
}

- (UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * footer = [[UIView alloc]init];
    footer.backgroundColor = [UIColor colorWithHexString:@"#383b44"];
    
    if (singleArray.count > 0) {
        BLData * data = [singleArray objectAtIndex:0];
        
        UILabel * teamLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
        teamLabel.text = @"总计";
        teamLabel.textColor = [UIColor colorWithHexString:@"FF0000"];
        teamLabel.textAlignment = UITextAlignmentCenter;
        teamLabel.font = [UIFont systemFontOfSize:14];
        if (section == 0) {
            if (data.teamA.userArray.count %2 == 0) {
                teamLabel.backgroundColor = [UIColor colorWithHexString:@"3D3E43"];
            }else{
                teamLabel.backgroundColor = [UIColor colorWithHexString:@"55585F"];
            }
        }else{
            if (data.teamB.userArray.count %2 == 0) {
                teamLabel.backgroundColor = [UIColor colorWithHexString:@"3D3E43"];
            }else{
                teamLabel.backgroundColor = [UIColor colorWithHexString:@"55585F"];
            }
        }
        
        [footer addSubview:teamLabel];
        
        NSArray * arrayA = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",data.teamACnt.defenCnt],[NSString stringWithFormat:@"%@",data.teamACnt.lanbanCnt],[NSString stringWithFormat:@"%@",data.teamACnt.zhugongCnt],[NSString stringWithFormat:@"%@",data.teamACnt.yuantouCnt],[NSString stringWithFormat:@"%@",data.teamACnt.qiangduanCnt],[NSString stringWithFormat:@"%@",data.teamACnt.gaimaoCnt], nil];
        
        NSArray * arrayB = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",data.teamBCnt.defenCnt],[NSString stringWithFormat:@"%@",data.teamBCnt.lanbanCnt],[NSString stringWithFormat:@"%@",data.teamBCnt.zhugongCnt],[NSString stringWithFormat:@"%@",data.teamBCnt.yuantouCnt],[NSString stringWithFormat:@"%@",data.teamBCnt.qiangduanCnt],[NSString stringWithFormat:@"%@",data.teamBCnt.gaimaoCnt], nil];
        
        for (int i = 0; i < 6; i++) {
            UILabel * statisticsLabel = [[UILabel alloc]initWithFrame:CGRectMake(80 + i * 40, 0, 40, 30)];
            if (section == 0) {
                statisticsLabel.text = [arrayA objectAtIndex:i];
            }else{
                statisticsLabel.text = [arrayB objectAtIndex:i];
            }
            statisticsLabel.textAlignment = UITextAlignmentCenter;
            statisticsLabel.font = [UIFont systemFontOfSize:14];
            statisticsLabel.textColor = [UIColor colorWithHexString:@"FF0000"];
            [footer addSubview:statisticsLabel];
            
            if (section == 0) {
                if (data.teamA.userArray.count %2 == 0) {
                    statisticsLabel.backgroundColor = [UIColor colorWithHexString:@"36383F"];
                }else{
                    statisticsLabel.backgroundColor = [UIColor colorWithHexString:@"3C3E45"];
                }
            }else{
                if (data.teamB.userArray.count %2 == 0) {
                    statisticsLabel.backgroundColor = [UIColor colorWithHexString:@"36383F"];
                }else{
                    statisticsLabel.backgroundColor = [UIColor colorWithHexString:@"3C3E45"];
                }
            }
        }
    }
    
    return footer;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (singleArray.count > 0) {
        BLData * data = [singleArray objectAtIndex:0];
        if (section == 0) {
            return data.teamA.userArray.count;
        }else if (section == 1){
            return data.teamB.userArray.count;
        }
    }
    return 0;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BLSinglegameCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[BLSinglegameCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    if (singleArray.count > 0) {
        if (indexPath.section == 0) {
            BLData * data = [singleArray objectAtIndex:0];
            BLSingleUser * user = [data.teamA.userArray objectAtIndex:indexPath.row];
            [cell setData:user :indexPath];
        }else if (indexPath.section == 1){
            BLData * data = [singleArray objectAtIndex:0];
            BLSingleUser * user = [data.teamB.userArray objectAtIndex:indexPath.row];
            [cell setData:user :indexPath];
        }
    }
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (singleArray.count > 0) {
        if (indexPath.section == 0) {
            
            BLData * data = [singleArray objectAtIndex:0];
            BLSingleUser * user = [data.teamA.userArray objectAtIndex:indexPath.row];
            
            BLMyViewController * myView = [[BLMyViewController alloc]init];
            [myView setVisitid:user.uid andName:user.username from:@"全国赛程"];
            [self.navigationController pushViewController:myView animated:YES];
            
        }else if (indexPath.section == 1){
            
            BLData * data = [singleArray objectAtIndex:0];
            BLSingleUser * user = [data.teamB.userArray objectAtIndex:indexPath.row];
            
            BLMyViewController * myView = [[BLMyViewController alloc]init];
            [myView setVisitid:user.uid andName:user.username from:@"全国赛程"];
            //            [myView setVisitid:user.uid andName:user.username];
            [self.navigationController pushViewController:myView animated:YES];
        }
    }
}


-(void)requestSingleGame:(NSString *)matchid from:(NSString *)from
{
    NSString *homeString = [[BLUtils globalCache]stringForKey:@"home"];
    if (from && [homeString isEqualToString:@""]) {
        
        [self addNavText:@"统计" action:nil];
        [self addLeftNavItem:@selector(leftButtonClick)];
        
        if (iPhone5) {
            _tableView.frame = iPhone5_frame;
        }else{
            _tableView.frame = iPhone4_frame;
        }

    }else{
        
        [self addNavBar];
        [self addNavBarTitle:@"统计" action:nil];
        [self addLeftNavBarItem:@selector(leftButtonClick)];
        
        _tableView.frame = [BLUtils frame1];
        
    }
    
    
    NSString *path = [NSString stringWithFormat:@"singlegame?id=%d",[matchid intValue]];
    
    [ShowLoading showWithMessage:showloading view:self.view];
    [BLBaseObject globalTimelinePostsWithBlock:^(NSArray *posts, NSError *error) {
        
        [ShowLoading hideLoading:self.view];
        
        if (error) {
            
        }
        if (posts.count > 0) {
            BLBaseObject *base = [posts objectAtIndex:0];
            if ([base.msg isEqualToString:@"succ"]) {
                
                [singleArray addObject:base.data];
                
                NSLog(@"%@",base.data.teamA.userArray);
                
                BLSinglegameTableHeaderView * sthView = [[BLSinglegameTableHeaderView alloc]initWithFrame:CGRectMake(0, 0, 320, 95) :base.data];
                _tableView.tableHeaderView = sthView;
                
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
