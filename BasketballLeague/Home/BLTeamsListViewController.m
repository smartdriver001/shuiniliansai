//
//  BLTeamsListViewController.m
//  BasketballLeague
//
//  Created by 崔洪禄 on 14-3-1.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLTeamsListViewController.h"
#import "BLTeamListBase.h"
#import "BLTeamListLists.h"
#import "BLTeamListCell.h"
#import "UIColor+Hex.h"
#import "BLMy_teamdetailViewController.h"
#import "BLCityBase.h"
#import "BLCityLists.h"
#import "BLCounty.h"
#import "BLVillage.h"
#import "BLCityListViewController.h"
#import "BLSearchBarView.h"
#import "BLSchool.h"

@interface BLTeamsListViewController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,cityListDelegate>
{
    UITableView * _tableView;
    UIView * view1;
    UIView * view2;
    UITableView * _tableView1;
    UITableView * _tableView2;
    
    NSString * order;
    UIView * ordView;
    UIView * alphaView;
    UIView * alphaView1;

    NSString * localCity;
    
    int _tableView1Back[100];
    int _tableView2Back[100];
    
    UIButton * areaButton;
    UIButton * sortButton;
    
    NSString * areaStr;
    
    BLSearchBarView *searchView;
    NSMutableArray *scholls;
    
    NSString *schoolId;
    
}

@property (nonatomic,strong) NSMutableArray * teamListArray;
@property (nonatomic,strong) NSMutableArray * cityListArray;
@property (nonatomic,strong) NSMutableArray * countyListArray;
@property (nonatomic,strong) NSMutableArray * villageListArray;

@end

typedef enum {
    EGOHeaderView = 0,
    EGOBottomView
} EGORefreshView;


@implementation BLTeamsListViewController

@synthesize teamListArray;
@synthesize cityListArray;
@synthesize countyListArray;
@synthesize villageListArray;

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
    hideHeaderview = YES;
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
    
    MYalphaView = [[BLAlphaView alloc]initWithFrame:CGRectMake(0, searchView.frame.size.height, 320, self.view.frame.size.height)];
    
    [self.navigationController.view addSubview:MYalphaView];

}


-(void)cancel{
    
    hideHeaderview = NO;
    [searchView removeFromSuperview];
    [MYalphaView removeFromSuperview];
    
    [searchView.searchField resignFirstResponder];
//    [self requestTeamsList];
    [self requestDataWithKey:@""];
//    [self requestData];
}

- (BOOL)textFieldShouldReturn:(UITextField*)theTextField{
    
    [searchView.searchField resignFirstResponder];
    //    [self requestDataWithKey:theTextField.text];
    return YES;
}

- (void) textFieldDidChange:(UITextField*)textField{
    
    [self requestDataWithKey:textField.text];
    [MYalphaView removeFromSuperview];
}

-(void)titleClick
{
    BLCityListViewController * cityView = [[BLCityListViewController alloc]init];
    cityView.delegate = self;
    [self presentModalViewController:cityView animated:YES];
}

-(void)titleCityName:(NSString *)cityName
{
    localCity = cityName;
//    [self addNavBarTitle:@"全国球队" andDetailTitle:cityName action:@selector(titleClick)];
    
    for (int i = 0; i < cityListArray.count; i++) {
        BLCityLists * city = [cityListArray objectAtIndex:i];
        if ([[city.name substringToIndex:2] isEqualToString:[localCity substringToIndex:2]]) {
            countyListArray = [NSMutableArray arrayWithArray:city.countyArray];
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.teamListArray = [NSMutableArray arrayWithCapacity:0];
    self.cityListArray = [NSMutableArray arrayWithCapacity:0];
    self.countyListArray = [NSMutableArray arrayWithCapacity:0];
    self.villageListArray = [NSMutableArray arrayWithCapacity:0];
    teamListArray = [NSMutableArray array];
    
    order = @"matchCnt";
    localCity = @"北京";
    areaStr = @"全部学校";
    
    localCity = [[BLUtils globalCache]stringForKey:@"location"];
    
//    [self addNavBar];
//    [self addNavBarTitle:@"全国球队" andDetailTitle:localCity action:@selector(titleClick)];
//    [self addLeftNavBarItem:@selector(leftButtonClick)];
//    [self addRightNavBarItemImg:@"search_normal" hImg:@"search_press" action:@selector(rightButtonClick)];
//    
    _tableView = [[UITableView alloc]init];
    _tableView.frame = [BLUtils frame];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tag = 100;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [_tableView reloadData];
//    [self requestTeamsList];
    
    [self initRefreshView];
    
//    [self requestCity];
}

-(void)initRefreshView{
    if (_refreshHeaderView == nil) {
		
		EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame: CGRectMake(0.0f, _tableView.contentSize.height, _tableView.frame.size.width, _tableView.bounds.size.height)];
        view.backgroundColor = [UIColor colorWithHexString:@"#383b44"];
		view.delegate = self;
        view.tag = EGOBottomView;
		[_tableView addSubview:view];
		_refreshTailerView = view;
		
        view = [[EGORefreshTableHeaderView alloc] initWithFrame: CGRectMake(0.0f, - _tableView.bounds.size.height, _tableView.frame.size.width, _tableView.bounds.size.height)];
        view.backgroundColor = [UIColor colorWithHexString:@"#383b44"];
		view.delegate = self;
        view.tag = EGOHeaderView;
		[_tableView addSubview:view];
		_refreshHeaderView = view;
		
	}
	[_refreshHeaderView refreshLastUpdatedDate];
    pageIndex = 1;
    isReload = YES;
    
}

#pragma mark - tableview delegate & datasource -
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (hideHeaderview) {
        UIView * header = [[UIView alloc]init];
        header.backgroundColor = [UIColor clearColor];
        return header;
    }
    
    if (tableView.tag == 100) {
        UIView * header = [[UIView alloc]init];
        
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
        view.backgroundColor = [UIColor colorWithHexString:@"43464D"];
        [header addSubview:view];
        
        areaButton = [UIButton buttonWithType:UIButtonTypeCustom];
        areaButton.frame = CGRectMake(10, 7, 140, 30);
        [areaButton addTarget:self action:@selector(areaButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [areaButton setBackgroundImage:[[UIImage imageNamed:@"button_Click"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)] forState:UIControlStateNormal];
        [areaButton setBackgroundImage:[[UIImage imageNamed:@"tableViewCellBlack"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)] forState:UIControlStateSelected];
        [areaButton setTitle:areaStr forState:UIControlStateNormal];
        if (areaStr.length > 7) {
            areaButton.titleLabel.font = [UIFont systemFontOfSize:14];
            [areaButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 0)];
        }else if(areaStr.length <=4){
            [areaButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
            areaButton.titleLabel.font = [UIFont systemFontOfSize:17];
        }else{
            areaButton.titleLabel.font = [UIFont systemFontOfSize:17];
        }
//        [areaButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        [areaButton setTitleColor:[UIColor colorWithHexString:@"FFFFFF"] forState:UIControlStateNormal];
        [header addSubview:areaButton];
        
        UIImageView * areaImage = [[UIImageView alloc]initWithFrame:CGRectMake(140-15, 10, 10, 10)];
        areaImage.image = [UIImage imageNamed:@"Pulldown"];
        [areaButton addSubview:areaImage];
        
        sortButton = [UIButton buttonWithType:UIButtonTypeCustom];
        sortButton.frame = CGRectMake(320-24-125, 7, 125, 30);
        [sortButton addTarget:self action:@selector(sortButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [sortButton setBackgroundImage:[[UIImage imageNamed:@"button_Click"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)] forState:UIControlStateNormal];
        [sortButton setBackgroundImage:[[UIImage imageNamed:@"tableViewCellBlack"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)] forState:UIControlStateSelected];
        if ([order isEqualToString:@"matchCnt"]) {
            [sortButton setTitle:@"参赛次数" forState:UIControlStateNormal];
        }else{
            [sortButton setTitle:@"胜率" forState:UIControlStateNormal];
        }
        [sortButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
        sortButton.titleLabel.font = [UIFont systemFontOfSize:17];
        [sortButton setTitleColor:[UIColor colorWithHexString:@"FFFFFF"] forState:UIControlStateNormal];
        [header addSubview:sortButton];
        
        UIImageView * sortImage = [[UIImageView alloc]initWithFrame:CGRectMake(95, 10, 10, 10)];
        sortImage.image = [UIImage imageNamed:@"Pulldown"];
        [sortButton addSubview:sortImage];
        
        return header;
    }else{
        UIView * header = [[UIView alloc]init];
        header.backgroundColor = [UIColor clearColor];
        
        return header;
    }
}

-(void)areaButtonClick:(id)sender
{
    [self removeOrdView];
    
    NSData *data = [[BLUtils globalCache]dataForKey:@"schools"];
    scholls = [NSMutableArray arrayWithArray:[BLSchool parseJsonToArray:data]];
    
    [scholls insertObject:@"全部学校" atIndex:0];
    
    if (view1) {
        [self removeView1AndView2];
    }else{
        areaButton.selected = YES;
        float y;
        if (ios7) {
            y = 20;
        }else{
            y = 0;
        }
        float high = (scholls.count+1)*25;

        alphaView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 88 + y, 320, 548 - 88)];
        alphaView1.backgroundColor = [UIColor blackColor];
        alphaView1.alpha = 0.5;
        [self.view addSubview:alphaView1];
        
        view1 = [[UIView alloc]initWithFrame:CGRectMake(10, 84 + y, 150, high)];
        view1.backgroundColor = [UIColor clearColor];
        [self.view addSubview:view1];
        
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake((150-35)/2, 0, 35, 15)];
        imageView.image = [UIImage imageNamed:@"orderArrow"];
        [view1 addSubview:imageView];
        
        _tableView1 = [[UITableView alloc]initWithFrame:CGRectMake(0, 15, 150, high - 15)];
        _tableView1.delegate = self;
        _tableView1.dataSource = self;
        _tableView1.tag = 101;
        _tableView1.backgroundColor = [UIColor colorWithHexString:@"27292E"];
        _tableView1.separatorStyle = UITableViewCellSeparatorStyleNone;
        [view1 addSubview:_tableView1];
        
//        for (int i = 0; i < 100; i ++) {
//            if (_tableView1Back[i] == 1) {
//                NSIndexPath * indexPath = [NSIndexPath indexPathForRow:i inSection:0];
//                [self tableView:_tableView1 didSelectRowAtIndexPath:indexPath];
//            }
//        }
    }
}

-(void)sortButtonClick:(id)sender
{
    [self removeView1AndView2];
    
    if (ordView) {
        sortButton.selected = NO;
        [self removeOrdView];
    }else{
        sortButton.selected = YES;
        float y;
        if (ios7) {
            y = 20;
        }else{
            y = 0;
        }
        alphaView = [[UIView alloc]initWithFrame:CGRectMake(0, 88 + y, 320, 548 - 88)];
        alphaView.backgroundColor = [UIColor blackColor];
        alphaView.alpha = 0.5;
        [self.view addSubview:alphaView];
        
        ordView = [[UIView alloc]initWithFrame:CGRectMake(160, 84 + y, 150, 75)];
        ordView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:ordView];
        
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(57.5, 0, 35, 15)];
        imageView.image = [UIImage imageNamed:@"orderArrow"];
        [ordView addSubview:imageView];
        
        UIButton * matchCntButton = [UIButton buttonWithType:UIButtonTypeCustom];
        matchCntButton.frame = CGRectMake(0, 15, 150, 30);
        [matchCntButton addTarget:self action:@selector(matchCntButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [matchCntButton setTitle:@"参赛次数" forState:UIControlStateNormal];
        matchCntButton.titleLabel.font = [UIFont systemFontOfSize:15];
        matchCntButton.titleLabel.textAlignment = UITextAlignmentLeft;
        [matchCntButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [matchCntButton setBackgroundImage:[[UIImage imageNamed:@"button_Click"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)] forState:UIControlStateNormal];
        [matchCntButton setBackgroundImage:[[UIImage imageNamed:@"tableViewCellBlack"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)] forState:UIControlStateSelected];
        if ([order isEqualToString:@"matchCnt"]) {
            matchCntButton.selected = YES;
        }
        [ordView addSubview:matchCntButton];
        
        UIButton * winCntButton = [UIButton buttonWithType:UIButtonTypeCustom];
        winCntButton.frame = CGRectMake(0, 45, 150, 30);
        [winCntButton addTarget:self action:@selector(winCntButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [winCntButton setTitle:@"胜率" forState:UIControlStateNormal];
        winCntButton.titleLabel.font = [UIFont systemFontOfSize:15];
        winCntButton.titleLabel.textAlignment = UITextAlignmentLeft;
        [winCntButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [winCntButton setBackgroundImage:[[UIImage imageNamed:@"button_Click"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)] forState:UIControlStateNormal];
        [winCntButton setBackgroundImage:[[UIImage imageNamed:@"tableViewCellBlack"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)] forState:UIControlStateSelected];
        if ([order isEqualToString:@"winCnt"]) {
            winCntButton.selected = YES;
        }
        [ordView addSubview:winCntButton];
    }
}

-(void)removeOrdView
{
    sortButton.selected = NO;
    for (id view in ordView.subviews) {
        [view removeFromSuperview];
    }
    [ordView removeFromSuperview];
    ordView = nil;
    
    [alphaView removeFromSuperview];
    alphaView = nil;
}

-(void)matchCntButtonClick
{
    order = @"matchCnt";
    
    [sortButton setTitle:@"参赛次数" forState:UIControlStateNormal];
    isReload = YES;
    pageIndex = 1;
    [self requestTeamsList];
    
    [self removeOrdView];
}

-(void)winCntButtonClick
{
    order = @"winCnt";
    
    [sortButton setTitle:@"胜率" forState:UIControlStateNormal];
    isReload = YES;
    pageIndex = 1;
    [self requestTeamsList];
    
    [self removeOrdView];
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (hideHeaderview) {
        return 20;
    }
    if (tableView.tag == 100) {
        return 54;
    }else{
        return 0;
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 100) {
        return 90;
    }else{
        return 25;
    }
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 100) {
        return teamListArray.count;
    }else if (tableView.tag == 101){
        return scholls.count;
    }else{
        return villageListArray.count;
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    searchView.hidden = YES;
    MYalphaView.hidden = YES;
    [self hideKeyborad];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 100) {
        BLTeamListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            cell = [[BLTeamListCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        }
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        BLTeamListLists * list = [teamListArray objectAtIndex:indexPath.row];
        
        [cell setData:list];
        
        return cell;
    }else if (tableView.tag == 101){
        
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell1"];
        }
        
        if (_tableView1Back[indexPath.row] == 1) {
            cell.backgroundColor = [UIColor colorWithHexString:@"3D3E43"];
        }else{
            cell.backgroundColor = [UIColor colorWithHexString:@"27292E"];
        }
        
        if (indexPath.row == 0) {
            cell.textLabel.text = scholls[indexPath.row];//[NSString stringWithFormat:@"全部学校"];
        }else{
            BLSchool *myschool = scholls[indexPath.row];
            cell.textLabel.text = [NSString stringWithFormat:@"%@",myschool.name];
        }
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        cell.textLabel.textColor = [UIColor whiteColor];
        
        return cell;
    }else{
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell2"];
        }
        
        if (_tableView2Back[indexPath.row] == 1) {
            cell.backgroundColor = [UIColor colorWithHexString:@"55585F"];
        }else{
            cell.backgroundColor = [UIColor colorWithHexString:@"3D3E43"];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        BLVillage * village = [villageListArray objectAtIndex:indexPath.row];
        
        cell.textLabel.text = [NSString stringWithFormat:@"%@",village.name];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = [UIColor whiteColor];
        
        return cell;
    }
}

-(void)hideKeyborad{
    [searchView.searchField resignFirstResponder];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [[BLUtils globalCache]setString:@"NO" forKey:@"remove"];
    [self hideKeyborad];
//    hideHeaderview = NO;
//    [searchView removeFromSuperview];
    
    if (tableView.tag == 100) {
        BLMy_teamdetailViewController * teamDetailView = [[BLMy_teamdetailViewController alloc]init];
//        [teamDetailView requestMy_teamdetail:@"2"];
        BLTeamListLists * list = [teamListArray objectAtIndex:indexPath.row];
        [teamDetailView requestMy_teamdetail:list.teamId from:@"全国球队"];
        [self.navigationController pushViewController:teamDetailView animated:YES];
        
    }else if (tableView.tag == 101){
        
        pageIndex = 1;
        isReload = YES;
        
        if (indexPath.row == 0) {
            schoolId = nil;
            areaStr = @"全部学校";
        }else{
            BLSchool *myschool = scholls[indexPath.row];
            schoolId = myschool.schoolId;
            areaStr = myschool.name;
        }
        [self requestTeamsList];
        [self removeView1AndView2];
        
    }else{
        for (int i = 0; i < 100; i ++) {
            _tableView2Back[i] = 0;
        }
        
        _tableView2Back[indexPath.row] = 1;
        
        [_tableView2 reloadData];
        isReload = YES;
        [self performSelector:@selector(requestTeamsList) withObject:self afterDelay:.5];
        [self performSelector:@selector(removeView1AndView2) withObject:self afterDelay:.5];
        
        BLVillage * village = [villageListArray objectAtIndex:indexPath.row];
        
        areaStr = [NSString stringWithFormat:@"%@",village.name];
    }
}

-(void)quanbuquyuSelect
{
    for (int i = 0; i < 100; i ++) {
        _tableView1Back[i] = 0;
    }
}

-(void)removeView1AndView2
{
    areaButton.selected = NO;
    for (id view in view1.subviews) {
        [view removeFromSuperview];
    }
    [view1 removeFromSuperview];
    view1 = nil;
    
    for (id view in view2.subviews) {
        [view removeFromSuperview];
    }
    [view2 removeFromSuperview];
    view2 = nil;
    
    [alphaView1 removeFromSuperview];
    alphaView1 = nil;
}

-(void)requestDataWithKey:(NSString *)keywords{
    
    NSString *path = [NSString stringWithFormat:@"teamslist/?search=%@",keywords];
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    [BLTeamListBase globalTimelinePostsWithBlock:^(NSArray *posts, NSError *error) {
        
        if (error) {
            
        }
        if (posts.count > 0) {
            base = [posts objectAtIndex:0];
            if ([base.msg isEqualToString:@"succ"]) {
                
                NSLog(@"%@",base.data.myTeamListArray);
                
                if (base.data.myTeamListArray.count < 1) {
                    [ShowLoading showErrorMessage:@"无搜索结果！" view:self.view];
                }
                
                teamListArray = [NSMutableArray arrayWithArray:base.data.myTeamListArray];
                
                [_tableView reloadData];
                
            }else{
                [ShowLoading showErrorMessage:base.msg view:self.view];
            }
        }
        
    } path:path];
}

#pragma mark - 请求 -
-(void)requestTeamsList
{
    /*place	int	false		比赛地点	根据选择赛点查询 (数值)
     page	int	false		第几页	默认1
     size	int	false		每页条数	默认10*/
    
    NSString *path = [NSString stringWithFormat:@"teamslist/?page=%d&size=%@",pageIndex,pageSize];
    
    if ([order isEqualToString:@""]) {
        if (schoolId) {
            path = [NSString stringWithFormat:@"teamslist/?page=%d&size=%d?schoolid=%@", pageIndex,100,schoolId];
        }else{
           path = [NSString stringWithFormat:@"teamslist/?page=%d&size=%d", pageIndex,100];
        }
    }else{
        path = [NSString stringWithFormat:@"teamslist/?page=%d&size=%d&ord=%@", pageIndex,100,order];
        if (schoolId) {
            [ShowLoading showWithMessage:showloading view:self.view];
            path = [NSString stringWithFormat:@"teamslist/?ord=%@&page=%d&size=%d&&schoolid=%@",order, pageIndex,100,schoolId];
        }
    }
    
    [BLTeamListBase globalTimelinePostsWithBlock:^(NSArray *posts, NSError *error) {
        
        [ShowLoading hideLoading:self.view];
        
        if (error) {
            if (isReload) {
                [teamListArray removeAllObjects];
                [self doneReLoadingTableViewData];
            }
            [ShowLoading showErrorMessage:@"服务器发生错误！" view:self.view];
            [self addNoScheduleView];
        }
        if (posts.count > 0) {
            base = [posts objectAtIndex:0];
            if ([base.msg isEqualToString:@"succ"]) {
                
                [self removeNOdataView];
                if (isReload) {
                    [teamListArray removeAllObjects];
                    if (base.data.myTeamListArray.count == 0) {
                        [self addNoScheduleView];
                    }else{
                        [teamListArray addObjectsFromArray:base.data.myTeamListArray];
                    }
                    [self doneReLoadingTableViewData];
                }else{
                    [teamListArray addObjectsFromArray:base.data.myTeamListArray];
                    [self doneLoadingTableViewData];
                }
//                [_tableView reloadData];
                
            }else{
                [self addNoScheduleView];
                [ShowLoading showErrorMessage:base.msg view:self.view];
            }
        }
        
    } path:path];
}

-(void)addNoScheduleView{
    float y;
    if (ios7) {
        y = 20;
    }else{
        y = 0;
    }
    UIView *noDataView = [[UIView alloc]initWithFrame:CGRectMake(0, y + 44+30, 320, 480)];
    noDataView.backgroundColor = [UIColor clearColor];
    
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(110, y + 44 + 20, 100, 100)];
    imageview.image = [UIImage imageNamed:@"noDataBG@2x"];
    [noDataView addSubview:imageview];
    
    UILabel *noteLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, y + 44 + 120, 200, 64)];
    noteLabel.backgroundColor = [UIColor clearColor];
    noteLabel.textColor = [UIColor grayColor] ;
    noteLabel.textAlignment = UITextAlignmentCenter;
    noteLabel.text = @"  目前暂无球队。";
    noteLabel.font = [UIFont boldSystemFontOfSize:14.0];
    noteLabel.numberOfLines = 0;
    [noDataView addSubview:noteLabel];
    noDataView.tag = 12300;
    [self.view addSubview:noDataView];
}

-(void)removeNOdataView{
    [[self.view viewWithTag:12300] removeFromSuperview];
}

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
    
    isReload = YES;
    pageIndex = 1;
    [self requestTeamsList];
	_reloading = YES;
	
}

- (void)doneReLoadingTableViewData
{
	//  model should call this when its done loading
	_reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:_tableView];
    [_tableView reloadData];
    if (teamListArray.count <5) {
        _refreshTailerView.hidden = YES;
    }else{
        _refreshTailerView.hidden = NO;
       _refreshTailerView.frame = CGRectMake(0.0f, _tableView.contentSize.height, _tableView.frame.size.width, _tableView.bounds.size.height);
    }
    
    pageIndex ++;
}

- (void)doneLoadingTableViewData
{
    _reloading = NO;
    pageIndex ++;
    [_refreshTailerView egoRefreshScrollViewDataSourceDidFinishedLoading:_tableView];
    [_tableView reloadData];
    
    _refreshTailerView.frame = CGRectMake(0.0f, _tableView.contentSize.height, _tableView.frame.size.width, _tableView.bounds.size.height);
    
}

- (void)loadMoreTableViewDataSource {
    //    [_model loadMore];
    if ([base.data.totalCnt intValue] <= teamListArray.count) {
//        [ShowLoading showErrorMessage:@"已无更多数据" view:self.navigationController.view];
        [self performSelector:@selector(didLoadNoData) withObject:nil afterDelay:.3];
        return;
    }
    isReload = NO;
    [self requestTeamsList];
    _reloading = YES;
}

-(void)didLoadNoData{

    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:_tableView];
}


#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    [_refreshTailerView egoRefreshScrollViewDidEndDragging:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [_refreshTailerView egoRefreshScrollViewDidEndDragging:scrollView];
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}


#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	if (view.tag == EGOHeaderView) {
        [self reloadTableViewDataSource];
    } else {
        [self loadMoreTableViewDataSource];
    }
    
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	return _reloading; // should return if data source model is reloading
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return [NSDate date]; // should return date data source was last changed
}

-(void)requestCity
{
    NSString *path = [NSString stringWithFormat:@"city/"];
    
    [BLCityBase globalTimelinePostsWithBlock:^(NSArray *posts, NSError *error) {
        
        [ShowLoading hideLoading:self.view];
        
        if (error) {
            
        }
        if (posts.count > 0) {
            BLCityBase *cityBase = [posts objectAtIndex:0];
            if ([cityBase.msg isEqualToString:@"succ"]) {
                
                cityListArray = [NSMutableArray arrayWithArray:cityBase.cityListsArray];
                
                for (int i = 0; i < cityListArray.count; i++) {
                    BLCityLists * city = [cityListArray objectAtIndex:i];
                    if ([[city.name substringToIndex:2] isEqualToString:[localCity substringToIndex:2]]) {
                        countyListArray = [NSMutableArray arrayWithArray:city.countyArray];
                    }
                }
                
            }else{
                [ShowLoading showErrorMessage:cityBase.msg view:self.view];
            }
        }
        
    } path:path];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self removeOrdView];
    [self removeView1AndView2];
}

-(void)viewWillAppear:(BOOL)animated
{
//    [self requestTeamsList];
    
    NSString *value = [[BLUtils globalCache]stringForKey:@"remove"];
    if ([value isEqualToString:@"NO"]) {
        searchView.hidden = NO;
    }else{
        
    }
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
//    [self addNavBarTitle:@"全国球队" andDetailTitle:localCity action:nil];
    [self addNavBar];
    [self initURLS];
    [self addNavBarTitle:@"全国球队" action:nil];
    [self addLeftNavBarItem:@selector(leftButtonClick)];
    [self addRightNavBarItemImg:@"search_normal" hImg:@"search_press" action:@selector(rightButtonClick)];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
