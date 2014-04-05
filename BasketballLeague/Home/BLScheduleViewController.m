//
//  BLScheduleViewController.m
//  BasketballLeague
//
//  Created by 崔洪禄 on 14-2-25.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLScheduleViewController.h"
#import "BLBaseObject.h"
#import "BLLists.h"
#import "BLScheduleCell.h"
#import "BLScheduleTitleCell.h"
#import "UIColor+Hex.h"
#import "BLsinglegameViewController.h"
#import "UIImageView+WebCache.h"
#import "BLMySingleGameViewController.h"
#import "BLCityBase.h"
#import "BLCityLists.h"
#import "BLCounty.h"
#import "BLVillage.h"
#import "BLCityListViewController.h"
#import "BLSchool.h"

typedef enum {
    EGOHeaderView = 0,
    EGOBottomView
} EGORefreshView;

@interface BLScheduleViewController ()<UITableViewDataSource,UITableViewDelegate,cityListDelegate>
{
    UITableView * _tableView;
    
    UIView * view1;
    UIView * view2;
    UITableView * _tableView1;
    UITableView * _tableView2;
    
    int _tableView1Back[100];
    int _tableView2Back[100];
    
    NSString * localCity;
    
    UIView * alphaView;
    NSMutableArray *scholls;
    NSString *schoolId;
}

@property (nonatomic,strong) NSMutableArray * scheduleArray;
@property (nonatomic,strong) NSMutableArray * cityListArray;
@property (nonatomic,strong) NSMutableArray * countyListArray;
@property (nonatomic,strong) NSMutableArray * villageListArray;

@end

@implementation BLScheduleViewController

@synthesize scheduleArray;
@synthesize cityListArray;
@synthesize countyListArray;
@synthesize villageListArray;

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
    NSData *data = [[BLUtils globalCache]dataForKey:@"schools"];
    scholls = [NSMutableArray arrayWithArray:[BLSchool parseJsonToArray:data]];
    
    [scholls insertObject:@"全部学校" atIndex:0];
    
    if (view1) {
        [self removeView1AndView2];
    }else{
        float y;
        if (ios7) {
            y = 20;
        }else{
            y = 0;
        }
        
        float high = (scholls.count+1)*25;
        
        alphaView = [[UIView alloc]initWithFrame:CGRectMake(0, 44 + y, 320, 548 - 44)];
        alphaView.backgroundColor = [UIColor blackColor];
        alphaView.alpha = 0.5;
        [self.view addSubview:alphaView];
        
        view1 = [[UIView alloc]initWithFrame:CGRectMake(160, 44 + y, 150, high)];
        view1.backgroundColor = [UIColor clearColor];
        [self.view addSubview:view1];
        
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(105, 0, 35, 15)];
        imageView.image = [UIImage imageNamed:@"orderArrow"];
        [view1 addSubview:imageView];
        
        _tableView1 = [[UITableView alloc]initWithFrame:CGRectMake(0, 15, 150, high - 15)];
        _tableView1.delegate = self;
        _tableView1.dataSource = self;
        _tableView1.tag = 101;
        _tableView1.backgroundColor = [UIColor colorWithHexString:@"27292E"];
        _tableView1.separatorStyle = UITableViewCellSeparatorStyleNone;
        [view1 addSubview:_tableView1];
        
        for (int i = 0; i < 100; i ++) {
            if (_tableView1Back[i] == 1) {
                NSIndexPath * indexPath = [NSIndexPath indexPathForRow:i inSection:0];
                [self tableView:_tableView1 didSelectRowAtIndexPath:indexPath];
            }
        }
    }
}

-(void)removeView1AndView2
{
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
    
    [alphaView removeFromSuperview];
    alphaView = nil;
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
//    [self addNavBarTitle:@"全国赛程" andDetailTitle:cityName action:@selector(titleClick)];
    
//    [self addNavBarTitle:@"全国赛程" andDetailTitle:cityName action:nil];
    
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
    localCity = @"北京";
    
    localCity = [[BLUtils globalCache]stringForKey:@"location"];
    
    /*自定义状态栏*/
//    [self addNavBar];
//    [self addNavBarTitle:@"全国赛程" action:nil];
//    [self addNavBarTitle:@"全国赛程" andDetailTitle:localCity action:@selector(titleClick)];
//    [self addNavBarTitle:@"全国赛程" andDetailTitle:localCity action:nil];
//    [self addLeftNavBarItem:@selector(leftButtonClick)];
//    [self addRightNavBarItemImg:@"Filter_normal" hImg:@"Filter_selected" action:@selector(rightButtonClick)];
    
    self.scheduleArray = [NSMutableArray arrayWithCapacity:0];
    self.cityListArray = [NSMutableArray arrayWithCapacity:0];
    self.countyListArray = [NSMutableArray arrayWithCapacity:0];
    self.villageListArray = [NSMutableArray arrayWithCapacity:0];
    
    _tableView = [[UITableView alloc]init];
    NSLog(@"%@",NSStringFromCGRect([BLUtils frame]));
    _tableView.frame = [BLUtils frame];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tag = 100;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
//    [_tableView reloadData];
    
    
//    [self schedulelist];
//    [self performSelector:@selector(schedulelist) withObject:nil afterDelay:0.0];
    
//    [self requestCity];
}

-(void)requestData:(NSString *)condition{
    _condition = condition;
    
    
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
    [self schedulelist];
}

-(void)schedulelist{
    
    [self removeNOdataView];
    NSString *uid = [[BLUtils globalCache]stringForKey:@"uid"];
    NSString *cityid = [[BLUtils globalCache]stringForKey:@"cityId"];
    NSString *path;
    if ([_condition isEqualToString:@"quanguo"]) {
        path = [NSString stringWithFormat:@"schedulelist/?page=%d&size=%@&cityid=%@",pageIndex,pageSize,cityid];

        if (schoolId) {
            path = [NSString stringWithFormat:@"schedulelist/?page=%d&size=%d&schoolid=%@&cityid=%@",pageIndex,100,schoolId,cityid];
            [ShowLoading showWithMessage:showloading view:self.view];
        }
        
    }else{
        path = [NSString stringWithFormat:@"my_gamelist/?uid=%@&page=%d&size=%@&cityid=%@",uid,pageIndex,pageSize,cityid];
    }
    
    [BLBaseObject globalTimelinePostsWithBlock:^(NSArray *posts, NSError *error) {
        
        [ShowLoading hideLoading:self.view];
        
        if (error) {
            
        }
        if (posts.count > 0) {
            base = nil;
            base = [posts objectAtIndex:0];
            if ([base.msg isEqualToString:@"succ"] && base.data.listsArray.count > 0) {
//                scheduleArray = [NSMutableArray arrayWithArray:base.data.listsArray];
                if (isReload) {
                    [scheduleArray removeAllObjects];
                    [scheduleArray addObjectsFromArray:base.data.listsArray];
                    [self doneReLoadingTableViewData];
                }else{
                    [scheduleArray addObjectsFromArray:base.data.listsArray];
                    [self doneLoadingTableViewData];
                }
            }else{
                if ([_condition isEqualToString:@"quanguo"]) {
                    [scheduleArray removeAllObjects];
                    [_tableView reloadData];
                    [self doneReLoadingTableViewData];
                    [self addNoScheduleView];
                }else{
                    [scheduleArray removeAllObjects];
                    [_tableView reloadData];
                    [ShowLoading showErrorMessage:base.msg view:self.view];
                }
            }
        }
        
    } path:path];
}

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{

    isReload = YES;
    pageIndex = 1;
    [self schedulelist];
	_reloading = YES;
	
}

- (void)doneReLoadingTableViewData
{
	//  model should call this when its done loading
	_reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:_tableView];
    [_tableView reloadData];
    
    if (scheduleArray.count<5) {
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
    if ([base.data.totalCnt intValue] <= scheduleArray.count) {
//        [ShowLoading showErrorMessage:@"已无更多数据" view:self.navigationController.view];
        [self performSelector:@selector(didLoadNoData) withObject:nil afterDelay:0.30];
        return;
    }
    isReload = NO;
    [self schedulelist];
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

-(void)addNoScheduleView{
    float y;
    if (ios7) {
        y = 20;
    }else{
        y = 0;
    }
    UIView *noDataView = [[UIView alloc]initWithFrame:CGRectMake(0, y + 44, 320, 480)];
    noDataView.backgroundColor = [UIColor clearColor];
    
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(110, y + 44 + 20, 100, 100)];
    imageview.image = [UIImage imageNamed:@"noDataBG@2x"];
    [noDataView addSubview:imageview];
    
    UILabel *noteLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, y + 44 + 120, 200, 64)];
    noteLabel.backgroundColor = [UIColor clearColor];
    noteLabel.textColor = [UIColor grayColor] ;
    noteLabel.textAlignment = UITextAlignmentCenter;
//    noteLabel.text = @"目前暂无比赛，\n但是队长可以带队参加比赛哦！";
    noteLabel.text = @"  目前暂无比赛。";
    noteLabel.font = [UIFont boldSystemFontOfSize:14.0];
    noteLabel.numberOfLines = 0;
    [noDataView addSubview:noteLabel];
    noDataView.tag = 12300;
    [self.view addSubview:noDataView];
}

-(void)removeNOdataView{
    [[self.view viewWithTag:12300] removeFromSuperview];
}

#pragma mark - UITableViewDelegate & dateasource -
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 100) {
        if (indexPath.row == 0) {
            return 32.5;
        }else{
            return 101;
        }
    }else{
        return 25;
    }
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView.tag == 100) {
        return scheduleArray.count;
    }else{
        return 1;
    }
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 100) {
        return 2;
    }else if (tableView.tag == 101){
        return scholls.count;
    }else if (tableView.tag == 102){
        return villageListArray.count;
    }
    return 1;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 100) {
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
        BLLists * lists = [scheduleArray objectAtIndex:indexPath.section];
        
        if ([_condition isEqualToString:@"quanguo"]) {
            
            BLsinglegameViewController * singleGameVC = [[BLsinglegameViewController alloc]init];
            [singleGameVC requestSingleGame:[NSString stringWithFormat:@"%@",lists.matchid]];
            [self.navigationController pushViewController:singleGameVC animated:YES];
            
        }else{
            
            BLMySingleGameViewController * singleGameVC = [[BLMySingleGameViewController alloc]init];
            [singleGameVC requestSingleGame:[NSString stringWithFormat:@"%@",lists.matchid] uid:@"2" from:@"TA的比赛"];
            [self.navigationController pushViewController:singleGameVC animated:YES];
            
        }
    }else if (tableView.tag == 101){
        
        pageIndex = 1;
        isReload = YES;
        
        if (indexPath.row == 0) {
           schoolId = nil;
        }else{
            BLSchool *myschool = scholls[indexPath.row];
            schoolId = myschool.schoolId;
        }
        [self schedulelist];
        [self removeView1AndView2];
//        [self performSelector:@selector(schedulelist) withObject:self afterDelay:.1];
//        [self performSelector:@selector(removeView1AndView2) withObject:self afterDelay:.2];
        
//        for (int i = 0; i < 100; i ++) {
//            _tableView1Back[i] = 0;
//        }
//        
//        _tableView1Back[indexPath.row] = 1;
//        
//        [_tableView1 reloadData];
//        
//        if (indexPath.row == 0) {
//            for (int i = 0; i < 100; i ++) {
//                _tableView2Back[i] = 0;
//            }
//            pageIndex = 1;
//            isReload = YES;
//            [self performSelector:@selector(schedulelist) withObject:self afterDelay:.5];
//            [self performSelector:@selector(removeView1AndView2) withObject:self afterDelay:.5];
//            [self performSelector:@selector(quanbuquyuSelect) withObject:self afterDelay:.4];
//        }else{
//            BLCounty * county = [countyListArray objectAtIndex:indexPath.row - 1];
//            villageListArray = [NSMutableArray arrayWithArray:county.villageArray];
//            
//            if (villageListArray.count == 0) {
//                [_tableView2 reloadData];
//            }else{
//                if (view2) {
////                    for (id view in view2.subviews) {
////                        [view removeFromSuperview];
////                    }
////                    [view2 removeFromSuperview];
////                    view2 = nil;
//                    [_tableView2 reloadData];
//                }else{
//                    float y;
//                    if (ios7) {
//                        y = 20;
//                    }else{
//                        y = 0;
//                    }
//                    
//                    float high;
//                    if ((countyListArray.count + 1) <= 7) {
//                        high = (countyListArray.count + 1) * 30 + 10;
//                    }else{
//                        high = 220;
//                    }
//                    
//                    //                for (int i = 0; i < 100; i ++) {
//                    //                    _tableView2Back[i] = 0;
//                    //                }
//                    
//                    view2 = [[UIView alloc]initWithFrame:CGRectMake(10, 44 + y + 15, 150, high)];
//                    view2.backgroundColor = [UIColor clearColor];
//                    [self.view addSubview:view2];
//                    
//                    _tableView2 = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 150, high)];
//                    _tableView2.delegate = self;
//                    _tableView2.dataSource = self;
//                    _tableView2.tag = 102;
//                    _tableView2.backgroundColor = [UIColor colorWithHexString:@"3D3E43"];
//                    _tableView2.separatorStyle = UITableViewCellSeparatorStyleNone;
//                    [view2 addSubview:_tableView2];
//                }
//            }
//        }
        
    }else{
        for (int i = 0; i < 100; i ++) {
            _tableView2Back[i] = 0;
        }
        
        _tableView2Back[indexPath.row] = 1;
        
        [_tableView2 reloadData];
        
        pageIndex = 1;
        isReload = YES;
        [self performSelector:@selector(schedulelist) withObject:self afterDelay:.5];
        [self performSelector:@selector(removeView1AndView2) withObject:self afterDelay:.5];
    }
    
}

-(void)quanbuquyuSelect
{
    for (int i = 0; i < 100; i ++) {
        _tableView1Back[i] = 0;
    }
}

-(void)requestCity
{
    NSString *path = [NSString stringWithFormat:@"city/"];
    
    [BLCityBase globalTimelinePostsWithBlock:^(NSArray *posts, NSError *error) {
        
        [ShowLoading hideLoading:self.view];
        
        if (error) {
            
        }
        if (posts.count > 0) {
            BLCityBase *base1 = [posts objectAtIndex:0];
            if ([base1.msg isEqualToString:@"succ"]) {
                
                cityListArray = [NSMutableArray arrayWithArray:base1.cityListsArray];
                
                for (int i = 0; i < cityListArray.count; i++) {
                    BLCityLists * city = [cityListArray objectAtIndex:i];
                    if ([[city.name substringToIndex:2] isEqualToString:[localCity substringToIndex:2]]) {
                        countyListArray = [NSMutableArray arrayWithArray:city.countyArray];
                    }
                }
                
            }else{
                [ShowLoading showErrorMessage:base1.msg view:self.view];
            }
        }
        
    } path:path];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self removeView1AndView2];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self addNavBar];
    [self initURLS];
    [self addNavBarTitle:@"全国赛程" action:nil];
    [self addLeftNavBarItem:@selector(leftButtonClick)];
//    [self addRightNavBarItemImg:@"Filter_normal" hImg:@"Filter_selected" action:@selector(rightButtonClick)];
    [self addRightNavBarItem:@"筛选" action:@selector(rightButtonClick)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
