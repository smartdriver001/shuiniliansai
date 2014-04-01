//
//  BLFollowersViewController.m
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-3-2.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLFollowersViewController.h"
//#import "BLPersonData.h"
#import "BLFollowers.h"
#import "BLCommentCell.h"
#import "BLTextField.h"
#import "BLSearchBarView.h"
#import "BLAddfocusCell.h"
#import "BLErrorView.h"

@interface BLFollowersViewController ()
{
    float navHigh;
    
    BLErrorView *errorView ;
}
@end

@implementation BLFollowersViewController

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
//    NSString * nav1 = [[BLUtils globalCache]stringForKey:@"per"];
//    
//    if ([nav1 isEqualToString:@"homePer"]) {
//        if (ios7) {
//            navHigh = 64;
//        }else{
//            navHigh = 44;
//        }
//        [self addNavBar];
//        [self addLeftNavBarItem:@selector(dismiss)];
//    }else{
//        navHigh = 0;
//        [self addLeftNavItem:@selector(dismiss)];
//    }
    
    myId = [[BLUtils globalCache]stringForKey:@"uid"];
    
    [self initTableView];
    
//    [self performSelector:@selector(requestData) withObject:nil afterDelay:0.0];
//    [self performSelector:@selector(addRightButton) withObject:nil afterDelay:0.1];
}

-(void)addRightButton{
    NSString * nav1 = [[BLUtils globalCache]stringForKey:@"per"];

    if (![_funsORfollowers isEqualToString:@"funs"]) {
        
        if ([nav1 isEqualToString:@"homePer"]) {
            [self addRightNavBarItemImg:@"addRightBtn_normal" hImg:@"addRightBtn_press" action:@selector(addFocus:)];
            [self addNavBarTitle:@"我的关注" action:nil];
        }else{
            [self addRightNavItemWithImg:@"addRightBtn_normal" hImg:@"addRightBtn_press" action:@selector(addFocus:)];

        }
    }else{
        if ([nav1 isEqualToString:@"homePer"]) {
            [self addNavBarTitle:@"我的粉丝" action:nil];

        }
    }
}

-(void)requestData:(NSString *)uid funsORfollowers:(NSString *)funsORfollowers; {
    
    NSString *home = [[BLUtils globalCache]stringForKey:@"home"];
    NSString *whose = [[BLUtils globalCache]stringForKey:@"whose"];
    
    NSString *path;
    taId = uid;
    
    whoseId = uid;
    
    if ([whose isEqualToString:@"TA的"]) {
        if ([home isEqualToString:@""]) {
            if (iPhone5) {
                _tableView.frame = iPhone5_frame;
            }else{
                _tableView.frame = iPhone4_frame;
            }
            
            if (![funsORfollowers isEqualToString:@"funs"]) {
                [self addNavText:@"TA的关注" action:nil];
                path = [NSString stringWithFormat:@"taguanzhu/?myid=%@&taid=%@",myId,uid];
                [self addRightNavItemWithImg:@"addRightBtn_normal" hImg:@"addRightBtn_press" action:@selector(addFocus:)];
            }else{
                [self addNavText:@"TA的粉丝" action:nil];
                path = [NSString stringWithFormat:@"tafuns/?taid=%@&myid=%@",uid,myId];
            }
//            [self addNavText:@"TA的粉丝" action:nil];
            [self addLeftNavItem:@selector(dismiss)];
        }else{
            [self addNavBar];
//            [self addNavBarTitle:@"战队等级" action:nil];
            [self addLeftNavBarItem:@selector(dismiss)];
            
            if (![funsORfollowers isEqualToString:@"funs"]) {
                [self addRightNavBarItemImg:@"addRightBtn_normal" hImg:@"addRightBtn_press" action:@selector(addFocus:)];

                [self addNavBarTitle:@"TA的关注" action:nil];
               
                path = [NSString stringWithFormat:@"taguanzhu/?myid=%@&taid=%@",myId,uid];
            }else{
                
                [self addNavBarTitle:@"TA的粉丝" action:nil];

                path = [NSString stringWithFormat:@"tafuns/?taid=%@&myid=%@",uid,myId];
            }
            
            _tableView.frame = [BLUtils frame1];
        }
        
    }else{
        if (iPhone5) {
            _tableView.frame = iPhone5_frame;
        }else{
            _tableView.frame = iPhone4_frame;
        }
        
        if (![funsORfollowers isEqualToString:@"funs"]) {
            [self addNavText:@"我的关注" action:nil];
            path = [NSString stringWithFormat:@"my_friends/?myid=%@",myId];
            [self addRightNavItemWithImg:@"addRightBtn_normal" hImg:@"addRightBtn_press" action:@selector(addFocus:)];
        }else{
            [self addNavText:@"我的粉丝" action:nil];
            path = [NSString stringWithFormat:@"my_followers/?myid=%@",myId];
        }
        
        [self addLeftNavItem:@selector(dismiss)];
        
    }
    
   
//    if ([_funsORfollowers isEqualToString:@"funs"]) {
//        path = [NSString stringWithFormat:@"my_followers/?myid=%@",@"2"];
//    }else{
//        path = [NSString stringWithFormat:@"my_friends/?myid=%@",@"2"];
//    }
    [_followers removeAllObjects];
    _followers = [NSMutableArray array];
    [ShowLoading showWithMessage:showloading view:self.view];
    [BLFollowers globalTimelinePostsWithBlock:^(NSArray *posts, NSError *error) {
        [ShowLoading hideLoading:self.view];
        if (error) {
            return ;
        }
        if (posts.count>0) {
            BLFollowers *followers = [posts objectAtIndex:0];
            if (followers.msg == nil) {
                _followers = [NSMutableArray arrayWithArray:posts];
                [_tableView reloadData];
            }else{
                [self initErrorView:@"暂无数据"];
//                [ShowLoading showErrorMessage:@"暂无数据" view:self.view];
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

-(void)addFocus:(UIButton *)focus{
    focusCell = YES;
    int y = 0;
    if (ios7) {
        y = 20;
    }
    searchView = [[BLSearchBarView alloc]initWithFrame:CGRectMake(0, 0+y, 320, 44)];
    searchView.searchField.delegate = self ;
    [searchView.searchField setReturnKeyType:UIReturnKeyDone];
    [searchView.cancelButton addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [searchView.searchField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged]; // textField的文本发生变化时相应事件
    [self.navigationController.view addSubview:searchView];
    
    alphaView = [[BLAlphaView alloc]initWithFrame:CGRectMake(0, searchView.frame.size.height, 320, self.view.frame.size.height)];
    
    [self.navigationController.view addSubview:alphaView];
    
}

-(void)cancel{
    
    [alphaView removeFromSuperview];
    
    [searchView removeFromSuperview];
    [searchView.searchField resignFirstResponder];
    focusCell = NO;
    [self requestData];
}

- (BOOL)textFieldShouldReturn:(UITextField*)theTextField{
    
    [searchView.searchField resignFirstResponder];
//    [self requestDataWithKey:theTextField.text];
    return YES;
}

- (void) textFieldDidChange:(UITextField*)textField{
    
    [self requestDataWithKey:textField.text];
    [alphaView removeFromSuperview];

}


-(void)initTableView{
    _tableView = [[UITableView alloc]init];

    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_tableView];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _followers.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (focusCell) {
        BLAddfocusCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell"];
        cell = [[BLAddfocusCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        cell.delegate = self;
        [cell initData:[_followers objectAtIndex:indexPath.row] index:indexPath.row];
        return cell;
    }else{
        BLCommentCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell"];
        cell = [[BLCommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        cell.delegate = self;
        [cell initData:[_followers objectAtIndex:indexPath.row] index:indexPath.row];
        return cell;
    }
    return nil;
}



#pragma mark - 关注 -
-(void)didfocus:(BLFollowers *)follower index:(int)index add:(BOOL)add{
    
    NSString *friendid;
//    if (follower.fansid == nil) {
//        friendid = follower.uid;
//    }else{
        friendid = follower.uid;
//    }
    NSString *path ;
    if (add) {
        [follower setRelationship:@"1"];
//        my_addfriend/?myid=2&friendid=3
        
        path = [NSString stringWithFormat:@"my_addfriend/?myid=%@&friendid=%@",whoseId,friendid];
    }else{
        [follower setRelationship:@"0"];
        path = [NSString stringWithFormat:@"my_delfriend/?myid=%@&friendid=%@",whoseId,friendid];
    }
    
    [self focusFriend:path];
    
//    [_followers replaceObjectAtIndex:index withObject:follower];
//    [_tableView reloadData];
}

-(void)focusFriend:(NSString *)path{
    
    [BLFollowers globalTimelinePostsWithBlock:^(NSArray *posts, NSError *error) {
        if (error) {
            return ;
        }else{
            BLFollowers *followers = [posts objectAtIndex:0];
            if (followers.msg == nil) {
                _followers = [NSMutableArray arrayWithArray:posts];
                [_tableView reloadData];
            }else{
                if ([followers.msg isEqualToString:@"succ"]) {
                    [ShowLoading showSuccView:self.view message:@"关注成功！"];
                }else{
                    [ShowLoading showErrorMessage:followers.msg view:self.view];
                }
            }
        }
    } path:path];
}

-(void)requestDataWithKey:(NSString *)keywords{

    NSString *path = [NSString stringWithFormat:@"my_friends/?keywords=%@",keywords];
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [_followers removeAllObjects];
    _followers = [NSMutableArray array];

    [BLFollowers globalTimelinePostsWithBlock:^(NSArray *posts, NSError *error) {
        if (error) {
            return ;
        }
        if (posts.count>0) {
            BLFollowers *followers = [posts objectAtIndex:0];
            if (followers.msg == nil) {
                _followers = [NSMutableArray arrayWithArray:posts];
                [_tableView reloadData];
                if (posts.count > 0) {
                    [self removeErrorView];
                }else{
                    [self initErrorView:@"暂无数据"];
                }
            }else{
                [_tableView reloadData];
            }
        }
    } path:path];
    
}

-(void)requestData{
//    my_followers/?myid=2
//    NSString *uid = [[BLUtils globalCache]stringForKey:@"uid"];
    NSString *path;
    if ([_funsORfollowers isEqualToString:@"funs"]) {
       path = [NSString stringWithFormat:@"my_followers/?myid=%@",whoseId];
    }else{
       path = [NSString stringWithFormat:@"my_friends/?myid=%@",whoseId];
    }
    [_followers removeAllObjects];
    _followers = [NSMutableArray array];
    [ShowLoading showWithMessage:showloading view:self.view];
    [BLFollowers globalTimelinePostsWithBlock:^(NSArray *posts, NSError *error) {
        [ShowLoading hideLoading:self.view];
        if (error) {
            return ;
        }
        if (posts.count>0) {
            BLFollowers *followers = [posts objectAtIndex:0];
            if (followers.msg == nil) {
                _followers = [NSMutableArray arrayWithArray:posts];
                [_tableView reloadData];
                if(posts.count > 0){
                    [self removeErrorView];
                }else{
                    [self initErrorView:@"暂无数据"];
                }
            }else{
                [self initErrorView:@"暂无数据"];
                [ShowLoading showErrorMessage:@"暂无数据" view:self.view];
            }
        }
    } path:path];
    
}

-(void)dismiss{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
