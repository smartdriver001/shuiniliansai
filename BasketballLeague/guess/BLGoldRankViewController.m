//
//  BLGoldRankViewController.m
//  BasketballLeague
//
//  Created by ptshan on 14-3-27.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLGoldRankViewController.h"
#import "BLCityListViewController.h"
#import "UIColor+Hex.h"
#import "BLVillage.h"
#import "BLDetailRankCell.h"
#import "BLCityLists.h"
#import "BLCounty.h"
#import "BLMyViewController.h"
#import "BLCityBase.h"
#import "BLSchool.h"

typedef enum {
    EGOHeaderView = 0,
    EGOBottomView
} EGORefreshView;

@interface BLGoldRankViewController ()<UITableViewDataSource,UITableViewDelegate,cityListDelegate>
{
    UITableView * _tableView;
    UIView * view1;
    UIView * view2;
    UITableView * _tableView1;
    UITableView * _tableView2;
    
//    UIView * ordView;
    UIView * alphaView;
    UIView * alphaView1;
    
    NSString * localCity;
    
    int _tableView1Back[100];
    int _tableView2Back[100];
    
    UIButton * areaButton;
    UIButton * sortButton;
    
    NSString * navTitleStr;
    
    NSString * areaStr;
    
    NSMutableArray *scholls;
    
    NSString *schoolId;
}

@property (nonatomic,strong) NSMutableArray * teamListArray;
@property (nonatomic,strong) NSMutableArray * cityListArray;
@property (nonatomic,strong) NSMutableArray * countyListArray;
@property (nonatomic,strong) NSMutableArray * villageListArray;

@end

@implementation BLGoldRankViewController

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

-(void)rightButtonClick
{
    
    
    //    BLDetailRankSearchViewController * drsVC = [[BLDetailRankSearchViewController alloc]init];
    //    [self.navigationController pushViewController:drsVC animated:YES];
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
    
    [[BLUtils globalCache] setString:@"guessPer" forKey:@"per"];
    
    localCity = @"北京";
    areaStr = @"全部学校";
    schoolId = @"";
    
    [self addLeftNavItem:@selector(dismiss)];
    [self addNavRightText:@"筛选" action:@selector(areaButtonClick)];

    _tableView = [[UITableView alloc]init];
    _tableView.frame = [BLUtils frameHasBar];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tag = 100;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    [_tableView reloadData];
    [self initRefreshView];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)dismiss{
    [self.navigationController popViewControllerAnimated:YES];
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
    
    isReload = YES;
    pageIndex = 1;
    
}

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
    
    isReload = YES;
    pageIndex = 1;
    [self requestPaihangbang];
	_reloading = YES;
	
}

- (void)doneReLoadingTableViewData
{
	//  model should call this when its done loading
	_reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:_tableView];
    [_tableView reloadData];
    
    if (teamListArray.count>4) {
        _refreshTailerView.hidden = NO;
        _refreshTailerView.frame = CGRectMake(0.0f, _tableView.contentSize.height, _tableView.frame.size.width, _tableView.bounds.size.height);
    }else{
        _refreshTailerView.hidden = YES;
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
        [self performSelector:@selector(didLoadNoData) withObject:nil afterDelay:0.3];
        return;
    }
    isReload = NO;
    [self requestPaihangbang];
    _reloading = YES;
}

-(void)didLoadNoData{
    //    [_tableView reloadData];
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

-(void)setNavTitle:(NSString *)title
{
    navTitleStr = title;
    
}

-(void)requestPaihangbang
{
    NSString *path = [NSString stringWithFormat:@"user/coinslist?size=%d&page=%d&schoolId=%@",100,pageIndex,schoolId];
    
    [BLBaseObject globalRequestWithBlock:^(NSArray *posts, NSError *error) {
        
        //        [ShowLoading hideLoading:self.view];
        NSLog(@"posts:%@",posts);

        if (error) {
            
        }
        if (posts.count > 0) {
            base = [posts objectAtIndex:0];
            if ([base.msg isEqualToString:@"succ"]) {
                if (isReload) {
                    [teamListArray removeAllObjects];
                    [teamListArray addObjectsFromArray:base.data.listsArray];
                    [self doneReLoadingTableViewData];
                }else{
                    [teamListArray addObjectsFromArray:base.data.listsArray];
                    [self doneLoadingTableViewData];
                }
                
            }else{
                [ShowLoading showErrorMessage:base.msg view:self.view];
            }
        }
        
    } path:path];
}

#pragma mark - tableview delegate & datasource -
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView.tag == 100) {
        UIView * header = [[UIView alloc]init];
        
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 10)];
        view.backgroundColor = [UIColor clearColor];
        [header addSubview:view];
        return header;
    }else{
        UIView * header = [[UIView alloc]init];
        header.backgroundColor = [UIColor clearColor];
        
        return header;
    }
}

-(void)areaButtonClick
{
    NSData *data = [[BLUtils globalCache] dataForKey:@"schools"];
    scholls = [NSMutableArray arrayWithArray:[BLSchool parseJsonToArray:data]];
    
    [scholls insertObject:@"全部学校" atIndex:0];
    
    if (view1) {
        [self removeView1AndView2];
    }else{
        areaButton.selected = YES;
        float y;
        if (ios7) {
            y = 0;
        }else{
            y = 0;
        }
        
        float high = scholls.count*25;
        
        alphaView1 = [[UIView alloc]initWithFrame:CGRectMake(0,  y, 320, 548 )];
        alphaView1.backgroundColor = [UIColor blackColor];
        alphaView1.alpha = 0.5;
        [self.view addSubview:alphaView1];
        
        view1 = [[UIView alloc]initWithFrame:CGRectMake(10,  y, 150, high)];
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
        [_tableView1 reloadData];
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView.tag == 100) {
        return 10;
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
        return scholls.count ;
    }else{
        return villageListArray.count;
    }
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 100) {
        BLDetailRankCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            cell = [[BLDetailRankCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        }
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.numberImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"nub%d",indexPath.row+1]];
        BLLists * list = [teamListArray objectAtIndex:indexPath.row];
        
        [cell setData2:list];
        
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

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (tableView.tag == 100) {
        BLLists * list = [teamListArray objectAtIndex:indexPath.row];
        
        BLMyViewController * myView = [[BLMyViewController alloc]init];
        //        [myView setVisitid:list.uid andName:list.name];
        myView.isFromeGoldRank = YES;
        [myView setVisitid:list.uid andName:list.name from:@"visitor"];
        [self.navigationController pushViewController:myView animated:YES];
        
    }else if (tableView.tag == 101){
        
        pageIndex = 1;
        isReload = YES;
        
        if (indexPath.row == 0) {
            schoolId = @"";
            areaStr = @"全部学校";
        }else{
            BLSchool *myschool = scholls[indexPath.row];
            schoolId = myschool.schoolId;
            areaStr = myschool.name;
        }
        
        [self requestPaihangbang];
        [self removeView1AndView2];
        
    }else{
        for (int i = 0; i < 100; i ++) {
            _tableView2Back[i] = 0;
        }
        
        _tableView2Back[indexPath.row] = 1;
        
        [_tableView2 reloadData];
        
        isReload = YES;
        pageIndex = 1;
        
        [self performSelector:@selector(requestPaihangbang) withObject:self afterDelay:.5];
        [self performSelector:@selector(removeView1AndView2) withObject:self afterDelay:.5];
        
        BLVillage * village = [villageListArray objectAtIndex:indexPath.row];
        
        areaStr = [NSString stringWithFormat:@"%@",village.name];
        
        [_tableView reloadData];
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

#pragma mark - 城市请求 -
-(void)requestCity
{
    NSString *path = [NSString stringWithFormat:@"city/"];
    
    [BLCityBase globalTimelinePostsWithBlock:^(NSArray *posts, NSError *error) {
        
        [ShowLoading hideLoading:self.view];
        
        if (error) {
            
        }
        if (posts.count > 0) {
            BLCityBase *citybase = [posts objectAtIndex:0];
            if ([citybase.msg isEqualToString:@"succ"]) {
                
                cityListArray = [NSMutableArray arrayWithArray:citybase.cityListsArray];
                
                for (int i = 0; i < cityListArray.count; i++) {
                    BLCityLists * city = [cityListArray objectAtIndex:i];
                    if ([[city.name substringToIndex:2] isEqualToString:[localCity substringToIndex:2]]) {
                        countyListArray = [NSMutableArray arrayWithArray:city.countyArray];
                    }
                }
                
            }else{
                [ShowLoading showErrorMessage:base.msg view:self.view];
            }
        }
        
    } path:path];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
//    [self removeOrdView];
    [self removeView1AndView2];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
