//
//  BLMyTeamGameListViewController.m
//  BasketballLeague
//
//  Created by 崔洪禄 on 14-3-3.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLMyTeamGameListViewController.h"
#import "BLBaseObject.h"
#import "BLLists.h"
#import "BLScheduleTitleCell.h"
#import "BLScheduleCell.h"
#import "UIColor+Hex.h"
#import "UIImageView+WebCache.h"
#import "BLsinglegameViewController1.h"

@interface BLMyTeamGameListViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
    float navHigh;
}

@property (nonatomic,strong) NSMutableArray * scheduleArray;

@end

@implementation BLMyTeamGameListViewController
@synthesize scheduleArray;

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
    self.scheduleArray = [NSMutableArray arrayWithCapacity:0];
    
    _tableView = [[UITableView alloc]init];

//    NSString * nav = [[BLUtils globalCache]stringForKey:@"navigation"];
//    if ([nav isEqualToString:@"noNav"]) {
//        if (ios7) {
//            navHigh = 64;
//        }else{
//            navHigh = 44;
//        }
//        [self addNavBar];
//        [self addLeftNavBarItem:@selector(leftButtonClick)];
//        
//        _tableView.frame = [BLUtils frame];
//    }else{
//        NSString * nav1 = [[BLUtils globalCache]stringForKey:@"per"];
//        if ([nav1 isEqualToString:@"homePer"]) {
//            if (ios7) {
//                navHigh = 64;
//            }else{
//                navHigh = 44;
//            }
//            [self addNavBar];
//            [self addLeftNavBarItem:@selector(leftButtonClick)];
//            
//            _tableView.frame = [BLUtils frame];
//        }else{
//            navHigh = 0;
//            [self addLeftNavItem:@selector(leftButtonClick)];
//            
//            if (iPhone5) {
//                _tableView.frame = iPhone5_frame;
//            }else{
//                _tableView.frame = iPhone4_frame;
//            }
//        }
//    }
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
//    [self performSelector:@selector(requestMy_teamgamelist) withObject:nil afterDelay:0.3];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 32.5;
    }else{
        return 101;
    }
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return scheduleArray.count;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        BLScheduleTitleCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            cell = [[BLScheduleTitleCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        }
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        BLLists * lists = [scheduleArray objectAtIndex:indexPath.section];
        
        NSDateFormatter * dateformatter = [[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"yyyy-MM-dd"];
        NSString * str = [NSString stringWithFormat:@"%@",lists.date];
        NSDate * date = [dateformatter dateFromString:str];
        
        NSDateFormatter * dateformatter1 = [[NSDateFormatter alloc] init];
        [dateformatter1 setDateFormat:@"yy年MM月dd日"];
        NSString * dateStr = [dateformatter1 stringFromDate:date];
        
        cell.textLabel.text = [NSString stringWithFormat:@"%@(%@)(%@)",dateStr,lists.school,lists.type];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:12];
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.textColor = [UIColor colorWithHexString:@"909092"];
        
        return cell;
        
    }else{
        BLScheduleCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        if (cell == nil) {
            cell = [[BLScheduleCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell1"];
        }
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        BLLists * lists = [scheduleArray objectAtIndex:indexPath.section];
        //        cell.textLabel.text = [NSString stringWithFormat:@"%@ %@ - %@ %@",lists.teamNameA,lists.scoreA,lists.teamNameB,lists.scoreB];
        [cell setData:lists];
        
        [cell.iconAImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",lists.iconA]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        
        [cell.iconBImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",lists.iconB]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        
        //    NSURL * iconUrl = [NSURL URLWithString:lists.iconA];
        //    cell.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:iconUrl]];
        
        return cell;
    }
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    BLLists * lists = [scheduleArray objectAtIndex:indexPath.section];
    
    BLsinglegameViewController1 * singleGameVC = [[BLsinglegameViewController1 alloc]init];
    
    [singleGameVC requestSingleGame:[NSString stringWithFormat:@"%@",lists.matchid] from:@"我的战队"];
    [self.navigationController pushViewController:singleGameVC animated:YES];
}

-(void)requestData:(NSString *)teamId titile:(NSString *)title from:(NSString *)from{
    
    NSString *homeString = (NSString *)[[BLUtils globalCache]stringForKey:@"home"];
    if (from && [homeString isEqualToString:@""]) {
        
        [self addLeftNavItem:@selector(leftButtonClick)];
        if (iPhone5) {
            _tableView.frame = iPhone5_frame;
        }else{
            _tableView.frame = iPhone4_frame;
        }
        [self addNavText:title action:nil];
//        [self addNavTextAndDetailText:@"我的战队":title action:nil];
    }else{
        
        [self addNavBar];
        [self addLeftNavBarItem:@selector(leftButtonClick)];
        [self addNavBarTitle:title action:nil];
//        [self addNavBarTitle:@"我的战队" andDetailTitle:title action:nil];
        _tableView.frame = [BLUtils frame1];
    }
    
    [self requestMy_teamgamelist:teamId];
    
}

-(void)requestMy_teamgamelist:(NSString *)teamId{
    
    NSString *path = [NSString stringWithFormat:@"my_teamgamelist?teamid=%@",teamId];
    [ShowLoading showWithMessage:showloading view:self.view];
    [BLBaseObject globalTimelinePostsWithBlock:^(NSArray *posts, NSError *error) {
        
        [ShowLoading hideLoading:self.view];
        
        if (error) {
            
        }
        if (posts.count > 0) {
            BLBaseObject *base = [posts objectAtIndex:0];
            if ([base.msg isEqualToString:@"succ"]) {
                
                NSLog(@"%@",base.data.listsArray);
                
                scheduleArray = [NSMutableArray arrayWithArray:base.data.listsArray];
                
                if (scheduleArray.count == 0) {
                    
                    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(110, 30, 100, 100)];
                    imageView.image = [UIImage imageNamed:@"NoRespite"];
                    [self.view addSubview:imageView];
                    
                    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 150, 320, 40)];
                    label.text = @"目前暂无比赛，\n但是队长可以带队参加比赛哦！";
                    label.textAlignment = UITextAlignmentCenter;
                    label.textColor = [UIColor lightGrayColor];
                    label.backgroundColor = [UIColor clearColor];
                    label.font = [UIFont systemFontOfSize:16];
                    label.numberOfLines = 0;
                    [self.view addSubview:label];
                    
                }else{
                    [_tableView reloadData];
                }
                
            }else{
                [ShowLoading showErrorMessage:base.msg view:self.view];
            }
        }
        
    } path:path];
}

-(void)setNavTitle:(NSString *)teamName
{
    NSString * nav = [[BLUtils globalCache]stringForKey:@"navigation"];
    if ([nav isEqualToString:@"noNav"]) {
        [self addNavBarTitle:@"我的战队" andDetailTitle:teamName action:nil];
    }else{
        NSString * nav1 = [[BLUtils globalCache]stringForKey:@"per"];
        
        if ([nav1 isEqualToString:@"homePer"]) {
            [self addNavBarTitle:@"我的战队" andDetailTitle:teamName action:nil];

        }else{
            [self addNavTextAndDetailText:@"我的战队" :teamName action:nil];

        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
