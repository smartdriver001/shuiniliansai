//
//  BLSearchViewController.m
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-3-30.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLSearchViewController.h"
#import "BLSearchBarView.h"
#import "BLAlphaView.h"
#import "BLSearchTeam.h"
#import "BLTeamListCell.h"
#import "BLCommentCell.h"
#import "BLMy_teamdetailViewController.h"
#import "UIColor+Hex.h"
#import "BLMyViewController.h"

@interface BLSearchViewController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>{
    
    BLSearchBarView *searchView;
    BLAlphaView *MYalphaView;
    
    UITableView *_tableView;
    
    UITableView *_tableView1;
    
    BOOL isTeam;
    
    NSMutableArray *teamsArr;
    NSMutableArray *playersArr;
    
    UIButton *sortBtn;
    NSArray *sortArr;
}

@end

@implementation BLSearchViewController

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
    
//    [self initSearchBar];
    
    [self performSelector:@selector(initSearchBar) withObject:nil afterDelay:0.1];
    
    [self initTableViews];
    
    isTeam = NO;//默认搜索球员
    teamsArr = [NSMutableArray array];
    playersArr = [NSMutableArray array];
    sortArr = @[@"搜索球员",@"搜索球队"];

}

-(void)initTableViews{
    _tableView = [[UITableView alloc]init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.frame = [BLUtils frame1];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.tag == 101){
        return 30.0f;
    }else{
        if (isTeam) {
            return 90.0f;
        }else{
            return 60.0f;
        }
    }
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView.tag == 101){
        return sortArr.count;
    }else{
        if (isTeam) {
            return teamsArr.count;
        }else{
            return teamsArr.count;
        }
    }
    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.tag == 101){
        
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyCell"];
            cell.backgroundColor = [UIColor clearColor];
        }
        if(indexPath.row == 0){
            cell.imageView.image = [UIImage imageNamed:@"searchQY@2x"];
        }else{
            cell.imageView.image = [UIImage imageNamed:@"searchQD"];
        }
        cell.textLabel.font = [UIFont boldSystemFontOfSize:16.0f];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.text = sortArr[indexPath.row];
        
        return cell;
        
    }else{
        
        if (isTeam) {
            
            BLTeamListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            if (cell == nil) {
                cell = [[BLTeamListCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
            }
            cell.backgroundColor = [UIColor clearColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            BLTeamListLists * list = [teamsArr objectAtIndex:indexPath.row];
            
            [cell setData:list];
            
            return cell;
            
        }else{
            
            BLCommentCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell"];
            if (cell == nil) {
                cell = [[BLCommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyCell"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.backgroundColor = [UIColor clearColor];
            }
            BLTeamListLists * list = [teamsArr objectAtIndex:indexPath.row];
            [cell initPlayer:list];
//            [cell initData:[playersArr objectAtIndex:indexPath.row] index:indexPath.row];
            return cell;
        }
        
    }
    return nil;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(tableView.tag == 101){
        if (indexPath.row==0) {
            isTeam = NO;
            _tableView.frame = [BLUtils frame1];
        }else{
            isTeam = YES;
            _tableView.frame = [BLUtils frame];
        }
        _tableView1.hidden = YES;
        MYalphaView.hidden = YES;
        [sortBtn setTitle:sortArr[indexPath.row] forState:UIControlStateNormal];
    }else{
        
        if (isTeam) {
            BLMy_teamdetailViewController * teamDetailView = [[BLMy_teamdetailViewController alloc]init];
            
            BLTeamListLists * list = [teamsArr objectAtIndex:indexPath.row];
            [teamDetailView requestMy_teamdetail:list.teamId from:@"全国球队"];
            [self.navigationController pushViewController:teamDetailView animated:YES];
        }else{
            BLMyViewController * myView = [[BLMyViewController alloc]init];
            BLTeamListLists * list = [teamsArr objectAtIndex:indexPath.row];
            [myView setVisitid:list.uid andName:list.realname from:@"visitor"];
            [self.navigationController pushViewController:myView animated:YES];
        }
    }
}

-(void)initSearchBar{
    int y = 0;
    if (ios7) {
        y = 20;
    }
    
    searchView = [[BLSearchBarView alloc]initWithFrame:CGRectMake(0, 0+y, 320, 44)];
    searchView.searchField.frame = CGRectMake(searchView.frame.origin.x+110, 0, searchView.frame.size.width, searchView.frame.size.height);
    UIImageView *searchImageView = (UIImageView *)[searchView viewWithTag:19876];
    searchImageView.image = [[UIImage imageNamed:@"searchBG"]resizableImageWithCapInsets:UIEdgeInsetsMake(0, 25, 0, 20)];
    searchView.searchField.delegate = self ;
    searchView.searchField.placeholder = @"" ;
    [searchView.searchField setReturnKeyType:UIReturnKeyDone];
    [searchView.cancelButton addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [searchView.searchField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged]; // textField的文本发生变化时相应事件
    [self.navigationController.view addSubview:searchView];
    
    MYalphaView = [[BLAlphaView alloc]initWithFrame:CGRectMake(0, searchView.frame.size.height, 320, self.view.frame.size.height)];
    
    [self.navigationController.view addSubview:MYalphaView];
    
    sortBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sortBtn.frame = CGRectMake(20, 7, 70, 30);
    sortBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [sortBtn setTitle:@"球员搜索" forState:UIControlStateNormal];
    [sortBtn addTarget:self action:@selector(sortAction) forControlEvents:UIControlEventTouchUpInside];
    [sortBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [searchView addSubview:sortBtn];
    
    UIImageView * sortImage = [[UIImageView alloc]initWithFrame:CGRectMake(70, 10, 10, 10)];
    sortImage.image = [UIImage imageNamed:@"Pulldown"];
    [sortBtn addSubview:sortImage];
    
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, 0, 35, 15)];
    imageView.tag = 123;
    imageView.image = [UIImage imageNamed:@"orderArrow"];
    [MYalphaView addSubview:imageView];
    imageView.hidden = YES;
    
    _tableView1 = [[UITableView alloc]initWithFrame:CGRectMake(10, 15, 150, 60)];
    _tableView1.delegate = self;
    _tableView1.dataSource = self;
    _tableView1.tag = 101;
    _tableView1.backgroundColor = [UIColor colorWithHexString:@"#3d3e43"];
    _tableView1.separatorStyle = UITableViewCellSeparatorStyleNone;
    [MYalphaView addSubview:_tableView1];
    [_tableView1 reloadData];
    _tableView1.hidden = YES;
    MYalphaView.hidden = YES;
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame = CGRectMake(220, 12, 20, 20);
    [searchBtn setBackgroundImage:[UIImage imageNamed:@"searchIcon"] forState:UIControlStateNormal];
    [searchView addSubview:searchBtn];
    
}

-(void)sortAction{
    
    [teamsArr removeAllObjects];
    [_tableView reloadData];
    searchView.searchField.text = @"";
    
    if (MYalphaView.hidden == YES) {
        _tableView1.hidden = NO;
        MYalphaView.hidden = NO;
    }else{
        MYalphaView.hidden = YES;
        _tableView1.hidden = YES;
    }
}

- (void) textFieldDidChange:(UITextField*)textField{
    
    [self requestDataWithKey:textField.text];
    
//    if (textField.text.length == 0) {
//        MYalphaView.hidden = NO;
//    }else{
        MYalphaView.hidden = YES;
        _tableView1.hidden = YES;
        [MYalphaView viewWithTag:123].hidden = YES;
//    }
    
}

-(void)requestDataWithKey:(NSString *)keyword{
    
    NSString *path;
    [teamsArr removeAllObjects];
    [_tableView reloadData];
    
    if (isTeam) {
        path = [NSString stringWithFormat:@"teams/search/?keyword=%@",keyword];
    }else{
        path = [NSString stringWithFormat:@"user/search/?keyword=%@",keyword];
    }
    path = [BLUtils encode:path];
    
    
    UIApplication *app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = YES;
    [BLSearchTeam globalTimelinePostsWithBlock:^(NSArray *posts, NSError *error) {
        app.networkActivityIndicatorVisible = NO;
        
        if (error) {
            return ;
        }
        if (posts.count > 0) {
            
            BLSearchTeam *team = [posts objectAtIndex:0];
            if (team.teams.count > 0) {
//                [searchView.searchField resignFirstResponder];
                teamsArr = team.teams;
                [_tableView reloadData];
            }else{
                [ShowLoading showErrorMessage:@"无搜索结果" view:self.navigationController.view];
            }
            
        }
    } path:path];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)cancel{
    [searchView.searchField resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];

    [self addNavBar];
    searchView.hidden = NO;
    MYalphaView.hidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    searchView.hidden = YES;
    MYalphaView.hidden = YES;
//    [MYalphaView removeFromSuperview];
//    [searchView removeFromSuperview];
//    [MYalphaView removeFromSuperview];
    [searchView.searchField resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
