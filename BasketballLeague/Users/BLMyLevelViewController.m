//
//  BLMyLevelViewController.m
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-3-17.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLMyLevelViewController.h"
#import "BLLevelHeaderView.h"
#import "BLMyLevelCell.h"
#import "BLMyLevel.h"
#import "UIColor+Hex.h"

@interface BLMyLevelViewController ()

@end

@implementation BLMyLevelViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    myTableView = [[UITableView alloc]init];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.backgroundColor = [UIColor clearColor];
    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:myTableView];
    
    [self initDa];
}

-(void)initDa{
    titleS = [NSMutableArray array];
    [titleS addObject:@"无牌"];
    for (int i=0; i<10; i++) {
        [titleS addObject:[NSString stringWithFormat:@"青铜%d级",i+1]];
    }
    for (int i=0; i<10; i++) {
        [titleS addObject:[NSString stringWithFormat:@"白银%d级",i+1]];
    }
    for (int i=0; i<10; i++) {
        [titleS addObject:[NSString stringWithFormat:@"黄金%d级",i+1]];
    }
    for (int i=0; i<10; i++) {
        [titleS addObject:[NSString stringWithFormat:@"白金%d级",i+1]];
    }
    for (int i=0; i<10; i++) {
        [titleS addObject:[NSString stringWithFormat:@"钻石%d级",i+1]];
    }
}

-(void)leftButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)from:(NSString *)from{
    
    myLevel = from;
    
    NSString *home = [[BLUtils globalCache]stringForKey:@"home"];
    NSString *whose = [[BLUtils globalCache]stringForKey:@"whose"];
    
    if ([whose isEqualToString:@"TA的"]) {
        if ([home isEqualToString:@""]) {
            if (iPhone5) {
                myTableView.frame = iPhone5_frame;
            }else{
                myTableView.frame = iPhone4_frame;
            }
            [self addNavText:@"战队等级" action:nil];
            [self addLeftNavItem:@selector(leftButtonClick)];
        }else{
            [self addNavBar];
            [self addNavBarTitle:@"战队等级" action:nil];
            [self addLeftNavBarItem:@selector(leftButtonClick)];
            
            myTableView.frame = [BLUtils frame1];
        }
        
    }else{
        if (iPhone5) {
            myTableView.frame = iPhone5_frame;
        }else{
            myTableView.frame = iPhone4_frame;
        }
        [self addNavText:@"战队等级" action:nil];
        [self addLeftNavItem:@selector(leftButtonClick)];
    }
    
    NSString *path = @"leveldata/";
    [ShowLoading showWithMessage:showloading view:self.view];
    [BLMyLevel globalTimelinePostsWithBlock:^(NSArray *posts, NSError *error) {
        [ShowLoading hideLoading:self.view];
        if (error) {
            return ;
        }
        
        if (posts.count > 0) {
            BLMyLevel *level = [posts objectAtIndex:0];
            if ([level.msg isEqualToString:@"succ"]) {
                dataSource = level.myLevels;
                [myTableView reloadData];
            }else{
                [ShowLoading showErrorMessage:@"暂无数据" view:self.view];
            }
        }
    } path:path];
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    BLLevelHeaderView *view = [[BLLevelHeaderView alloc]initWithFrame:CGRectMake(0, 0, 320, 60)];
    view.backgroundColor = [UIColor clearColor];
    
    return view;
}


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataSource.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BLMyLevelCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[BLMyLevelCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.backgroundColor = [UIColor clearColor];
    }
    
    if (indexPath.row%2 == 0) {
        cell.leftView.backgroundColor = [UIColor colorWithHexString:@"#55585f"];
        cell.rightView.backgroundColor = [UIColor colorWithHexString:@"#3e4149"];
    }else{
       cell.leftView.backgroundColor = [UIColor colorWithHexString:@"#3d3e43"];
        cell.rightView.backgroundColor = [UIColor colorWithHexString:@"#36383f"];
    }
    if (indexPath.row == [myLevel intValue]) {
        cell.icon.hidden = NO;
        cell.leftView.backgroundColor = [UIColor colorWithHexString:@"#736357"];
        cell.rightView.backgroundColor = [UIColor colorWithHexString:@"#736357"];
    }else{
        cell.icon.hidden = YES;
    }
    
    if (indexPath.row>0 && indexPath.row <= 10) {
        cell.leftLabel.textColor = [UIColor colorWithHexString:@"#00cac3"];
    }else if (indexPath.row>10 && indexPath.row <= 20){
        cell.leftLabel.textColor = [UIColor colorWithHexString:@"#ffffe4"];
    }else if (indexPath.row>20 && indexPath.row <= 30){
        cell.leftLabel.textColor = [UIColor colorWithHexString:@"#ffd43b"];
    }else{
        cell.leftLabel.textColor = [UIColor whiteColor];
    }
    
    [cell initData:[dataSource objectAtIndex:indexPath.row]];
    cell.leftLabel.text = [titleS objectAtIndex:indexPath.row];
    
    return cell;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
