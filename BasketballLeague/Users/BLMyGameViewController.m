//
//  BLMyGameViewController.m
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-3-8.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLMyGameViewController.h"
#import "BLBaseObject.h"
#import "BLLists.h"
#import "BLScheduleCell.h"
#import "BLScheduleTitleCell.h"
#import "UIColor+Hex.h"
#import "BLsinglegameViewController.h"
#import "UIImageView+WebCache.h"
#import "BLMySingleGameViewController.h"
@interface BLMyGameViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
}

@property (nonatomic,strong) NSMutableArray * scheduleArray;

@end

@implementation BLMyGameViewController

@synthesize scheduleArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}


-(void)leftButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightButtonClick
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.scheduleArray = [NSMutableArray arrayWithCapacity:0];
    
    _tableView = [[UITableView alloc]init];
//    NSString * nav1 = [[BLUtils globalCache]stringForKey:@"per"];
//    if ([nav1 isEqualToString:@"homePer"]) {
//        _tableView.frame = [BLUtils frame];
//        [self addNavBar];
//        [self addNavBarTitle:@"我的比赛" action:nil];
//        [self addLeftNavBarItem:@selector(leftButtonClick)];
//    }else{
//        _tableView.frame = [BLUtils frameHasBar];
//        [self addLeftNavItem:@selector(leftButtonClick)];
//
//    }
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    //    [self schedulelist];
//    [self performSelector:@selector(schedulelist) withObject:nil afterDelay:0.0];
    
}

-(void)dismiss{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)initRightButton{
    
    [self addRightNavBarItem:@"筛选" action:@selector(rightButtonClick)];
//    [self addRightNavItemWithImg:@"Filter_normal" hImg:@"Filter_selected" action:@selector(rightButtonClick)];
    
}

-(void)requestData:(NSString *)uid page:(NSString *)page size:(NSString *)size{
    
    tempUid = uid;
    NSString *home = [[BLUtils globalCache]stringForKey:@"home"];
    NSString *whose = [[BLUtils globalCache]stringForKey:@"whose"];
    
    if ([whose isEqualToString:@"TA的"]) {
        if ([home isEqualToString:@""]) {
            if (iPhone5) {
                _tableView.frame = iPhone5_frame;
            }else{
                _tableView.frame = iPhone4_frame;
            }
            [self addNavText:@"TA的比赛" action:nil];
            [self addLeftNavItem:@selector(leftButtonClick)];
        }else{
            [self addNavBar];
            [self addNavBarTitle:@"TA的比赛" action:nil];
            [self addLeftNavBarItem:@selector(leftButtonClick)];
            
            _tableView.frame = [BLUtils frame1];
        }
        tempHeight = 64;
    }else{
        if (iPhone5) {
            _tableView.frame = iPhone5_frame;
        }else{
            _tableView.frame = iPhone4_frame;
        }
        [self addNavText:@"我的比赛" action:nil];
        [self addLeftNavItem:@selector(leftButtonClick)];
        tempHeight = 0;
    }
    
    [self removeNOdataView];
    
    NSString *path = [NSString stringWithFormat:@"my_gamelist/?uid=%@&page=%@&size=%@",uid,page,size];
    
    [ShowLoading showWithMessage:showloading view:self.view];
    [BLBaseObject globalTimelinePostsWithBlock:^(NSArray *posts, NSError *error) {
        
        [ShowLoading hideLoading:self.view];
        
        if (error) {
            
        }
        if (posts.count > 0) {
            BLBaseObject *base = [posts objectAtIndex:0];
            if ([base.msg isEqualToString:@"succ"] && base.data.listsArray.count > 0) {
                scheduleArray = [NSMutableArray arrayWithArray:base.data.listsArray];
                [_tableView reloadData];
            }else{
                
                [self addNoScheduleView];
                
            }
        }
        
    } path:path];
}

-(void)schedulelist{
    
    [self removeNOdataView];
    
    NSString *path = [NSString stringWithFormat:@"my_gamelist/?uid=%@&page=%@&size=%@",tempUid,@"1",@"10"];
    
    [ShowLoading showWithMessage:showloading view:self.view];
    [BLBaseObject globalTimelinePostsWithBlock:^(NSArray *posts, NSError *error) {
        
        [ShowLoading hideLoading:self.view];
        
        if (error) {
            
        }
        if (posts.count > 0) {
            BLBaseObject *base = [posts objectAtIndex:0];
            if ([base.msg isEqualToString:@"succ"] && base.data.listsArray.count > 0) {
                
                [scheduleArray removeAllObjects];
                
                scheduleArray = [NSMutableArray arrayWithArray:base.data.listsArray];
                [_tableView reloadData];
            }else{
                
                [self addNoScheduleView];
                
            }
        }
        
    } path:path];
}

-(void)addNoScheduleView{
    UIView *noDataView = [[UIView alloc]initWithFrame:CGRectMake(0, 0+tempHeight, 320, 480)];
    noDataView.backgroundColor = [UIColor clearColor];
    
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(110, 20, 100, 100)];
    imageview.image = [UIImage imageNamed:@"noDataBG@2x"];
    [noDataView addSubview:imageview];
    
    UILabel *noteLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 120, 200, 64)];
    noteLabel.backgroundColor = [UIColor clearColor];
    noteLabel.textColor = [UIColor grayColor] ;
    noteLabel.textAlignment = UITextAlignmentCenter;
    noteLabel.text = @"目前暂无比赛，\n但是队长可以带队参加比赛哦！";
    noteLabel.font = [UIFont boldSystemFontOfSize:14.0];
    noteLabel.numberOfLines = 0;
    [noDataView addSubview:noteLabel];
    noDataView.tag = 12300;
    [self.view addSubview:noDataView];
}

-(void)removeNOdataView{
    [[self.view viewWithTag:12300] removeFromSuperview];
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
   
//    BLMySingleGameViewController * singleGameVC = [[BLMySingleGameViewController alloc]init];
//    [singleGameVC requestSingleGame:[NSString stringWithFormat:@"%@",lists.matchid] uid:tempUid from:@"我的比赛"];
//    [self.navigationController pushViewController:singleGameVC animated:YES];
    
    BLsinglegameViewController * singleGameVC = [[BLsinglegameViewController alloc]init];
    [singleGameVC requestSingleGame:[NSString stringWithFormat:@"%@",lists.matchid]];
    [self.navigationController pushViewController:singleGameVC animated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
