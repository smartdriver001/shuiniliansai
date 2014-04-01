//
//  BLMyVisitorsViewController.m
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-3-3.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLMyVisitorsViewController.h"
#import "BLMyVisitorCell.h"
#import "BLFollowers.h"
#import "BLMyViewController.h"
#import "BLErrorView.h"

@interface BLMyVisitorsViewController (){
    BLErrorView*errorView ;
}

@end

@implementation BLMyVisitorsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"我的来访";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _tableView = [[UITableView alloc]init];
    
    NSString *home = [[BLUtils globalCache]stringForKey:@"home"];
    NSString *whose = [[BLUtils globalCache]stringForKey:@"whose"];
    
    if ([whose isEqualToString:@"TA的"]) {
        if ([home isEqualToString:@""]) {
            [self addLeftNavItem:@selector(dismiss)];
            if (iPhone5) {
                _tableView.frame = iPhone5_frame;
            }else{
                _tableView.frame = iPhone4_frame;
            }
            [self initTableView];
        }else{
            [self addNavBar];
            [self addNavBarTitle:@"我的来访" action:nil];
            [self addLeftNavBarItem:@selector(dismiss)];
            _tableView.frame = [BLUtils frame];
            [self initTableView];
        }
        
    }else{
        [self addLeftNavItem:@selector(dismiss)];
        if (iPhone5) {
            _tableView.frame = iPhone5_frame;
        }else{
            _tableView.frame = iPhone4_frame;
        }
        [self initTableView];
    }
    
//    [self performSelector:@selector(requestData) withObject:nil afterDelay:0.0];
}

-(void)initTableView{
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_tableView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return visitorsArray.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BLMyVisitorCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell"];
    cell = [[BLMyVisitorCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    [cell initData:[visitorsArray objectAtIndex:indexPath.row]];
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BLFollowers *follower = [visitorsArray objectAtIndex:indexPath.row];
    BLMyViewController *myViewController = [[BLMyViewController alloc]initWithNibName:nil bundle:nil];
    [myViewController setVisitid:follower.uid andName:follower.name from:@""];
    [self.navigationController pushViewController:myViewController animated:YES];
}

-(void)requestData:(NSString *)uid{
    //    my_followers/?myid=2
    NSString *path = [NSString stringWithFormat:@"recentvisit/?uid=%@",uid];
    
    visitorsArray = [NSMutableArray array];
    [ShowLoading showWithMessage:showloading view:self.view];
    [BLFollowers globalTimelinePostsWithBlock:^(NSArray *posts, NSError *error) {
        [ShowLoading hideLoading:self.view];
        if (error) {
            return ;
        }
        if (posts.count>0) {
            BLFollowers *followers = [posts objectAtIndex:0];
            
            if (followers.msg == nil) {
                visitorsArray = [NSMutableArray arrayWithArray:posts];
                [_tableView reloadData];
            }else{
//                [ShowLoading showErrorMessage:@"暂无来访信息" view:self.view];
                [self initErrorView:@"暂无来访信息"];
            }
        }
    } path:path];
    
}

-(void)initErrorView:(NSString *)msg{
    
    errorView = [[BLErrorView alloc]init];
    errorView.frame = CGRectMake(0, 90, 320, self.view.frame.size.height-90);
    errorView.titleLabel.text = [NSString stringWithFormat:@"%@",msg];
    errorView.tag = 12345;
    [self.view addSubview:errorView];
}

-(void)removeErrorView{
    [[self.view viewWithTag:12345]removeFromSuperview];
}


-(void)dismiss{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
