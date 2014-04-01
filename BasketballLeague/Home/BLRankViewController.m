//
//  BLRankViewController.m
//  BasketballLeague
//
//  Created by 崔洪禄 on 14-3-8.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLRankViewController.h"
#import "BLRankViewCell.h"
#import "BLDetailRankViewController.h"

@interface BLRankViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
}
@end

@implementation BLRankViewController

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
//    [self addLeftNavItem:@selector(leftButtonClick)];
//    
//    [self addNavText:@"排行榜" action:nil];
    
//    [self addNavBar];
//    [self addNavBarTitle:@"排行榜" action:nil];
//    [self addLeftNavBarItem:@selector(leftButtonClick)];
    
    _tableView = [[UITableView alloc]init];
    _tableView.frame = [BLUtils frame1];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BLRankViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[BLRankViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSArray * array = [NSArray arrayWithObjects:@"得分排行榜",@"篮板排行榜",@"盖帽排行榜",@"助攻排行榜",@"远投排行榜",@"抢断排行榜", nil];
    [cell setData:[array objectAtIndex:indexPath.row]];
    
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray * array = [NSArray arrayWithObjects:@"得分排行榜",@"篮板排行榜",@"盖帽排行榜",@"助攻排行榜",@"远投排行榜",@"抢断排行榜", nil];
    BLDetailRankViewController * dRankView = [[BLDetailRankViewController alloc]init];
    [dRankView setNavTitle:[array objectAtIndex:indexPath.row]];
    [dRankView requestPaihangbang];
    [self.navigationController pushViewController:dRankView animated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self addNavBar];
    [self initURLS];
    [self addNavBarTitle:@"排行榜" action:nil];
    [self addLeftNavBarItem:@selector(leftButtonClick)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
