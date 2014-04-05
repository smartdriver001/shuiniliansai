//
//  BLMyMessageViewController.m
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-3-20.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLMyMessageViewController.h"
#import "YFJLeftSwipeDeleteTableView.h"
#import "BLMessageCell.h"
#import "BLMessage.h"
#import "UIColor+Hex.h"

typedef enum {
    EGOHeaderView = 0,
    EGOBottomView
} EGORefreshView;


@interface BLMyMessageViewController ()<JoinTeamDelegate>{
    NSMutableArray *_dataArray;
    CGSize size;
}

@property(nonatomic,strong)YFJLeftSwipeDeleteTableView *tableView;

@end

@implementation BLMyMessageViewController

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

    [self addLeftNavItem:@selector(dismiss)];
    
//    _dataArray = [@[@(1), @(2), @(3), @(4), @(5), @(6), @(7), @(8), @(9), @(10)] mutableCopy];
    
}

-(void)requestData{
    
    /*page	int	false		第几页	默认1
     size	int	false		每页条数	默认10*/
    NSString *uid = [[BLUtils globalCache]stringForKey:@"uid"];
    NSString *path = [NSString stringWithFormat:@"message/?uid=%@&page=1&size=100",uid];
    [ShowLoading showWithMessage:showloading view:self.navigationController.view];
    [BLMessage globalTimelinePostsWithBlock:^(NSArray *posts, NSError *error) {
        [ShowLoading hideLoading:self.navigationController.view];
        if (error) {
            return ;
        }
        if (posts.count>0) {
            BLMessage *message = [posts objectAtIndex:0];
            if (message.msg == nil) {
                _dataArray = [NSMutableArray arrayWithArray:posts];
//                [self.tableView reloadData];
                [self doneReLoadingTableViewData];
            }else{
                [ShowLoading showErrorMessage:@"暂无收到消息" view:self.view];
                _dataArray = [NSMutableArray array];
                [self doneReLoadingTableViewData];
            }
        }
    } path:path];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self requestData];
    [[BLUtils globalCache]setString:@"" forKey:@"push"];
    
    
    self.tableView = [[YFJLeftSwipeDeleteTableView alloc] init];
    self.tableView.backgroundColor = [UIColor clearColor];
    if (iPhone5) {
        self.tableView.frame = CGRectMake(0, 0, 320, 568);
    }else{
        self.tableView.frame = CGRectMake(0, 0, 320, 460);
    }
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[BLMessageCell class] forCellReuseIdentifier:@"Cell"];
    [self.view addSubview:self.tableView];
    
    
    if (_refreshHeaderView == nil) {
		
		EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame: CGRectMake(0.0f, - _tableView.bounds.size.height, _tableView.frame.size.width, _tableView.bounds.size.height)];
        view.backgroundColor = [UIColor colorWithHexString:@"#383b44"];
		view.delegate = self;
        view.tag = EGOHeaderView;
		[_tableView addSubview:view];
		_refreshHeaderView = view;
		
	}
	[_refreshHeaderView refreshLastUpdatedDate];
//    [_tableView reloadData];
    [self requestData];
}

-(void)dismiss{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    BLMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    cell.delegate = self;
    BLMessage *message = [_dataArray objectAtIndex:indexPath.row];
    [cell initData:message index:indexPath.row];
    
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self removeMessage:indexPath];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

-(void)setRead:(int)index{
    
    BLMessage *message = [_dataArray objectAtIndex:index];
    /*uid	string	true		用户主键	 >0的Int
     msg_ids	int	true		消息主键,多个以英文逗号隔开*/
    
    NSString *uid = [[BLUtils globalCache]stringForKey:@"uid"];

    NSString *path = [NSString stringWithFormat:@"setMsgReaded/?uid=%@&msg_ids=%@",uid,message.msg_id];
    
    [BLMessage globalTimelinePostsWithBlock:^(NSArray *posts, NSError *error) {
        if (error) {
            return ;
        }else{
            
        }
    } path:path];
}

-(void)joinTeam:(int)index{
    BLMessage *message = [_dataArray objectAtIndex:index];
    [message setIsreaded:@"1"];
    
    [_dataArray replaceObjectAtIndex:index withObject:message];
    
    NSString *path = [NSString stringWithFormat:@"agree/?uid=%@&teamid=%@",message.joinerId,message.teamId];
    
    [BLMessage globalTimelinePostsWithBlock:^(NSArray *posts, NSError *error) {
        if (error) {
            return ;
        }else{
            if (posts.count>0) {
                BLMessage *myMsg = [posts objectAtIndex:0];
                if ([myMsg.msg isEqualToString:@"succ"]) {
                    [ShowLoading showSuccView:self.view message:@"加入成功"];
                    [_tableView reloadData];
                    
                    [self setRead:index];
                }else{
                    [ShowLoading showErrorMessage:@"加入失败" view:self.view];
                }
            }
        }
    } path:path];
}

-(void)removeMessage:(NSIndexPath *)indexPath{
    
    BLMessage *message = [_dataArray objectAtIndex:indexPath.row];
    
    [_dataArray removeObjectAtIndex:indexPath.row];
    
    NSString *uid = [[BLUtils globalCache]stringForKey:@"uid"];
    NSString *path = [NSString stringWithFormat:@"messageDel/?uid=%@&msg_id=%@",uid,message.msg_id];
    /*uid	string	true		用户主键	 >0的Int
     msg_id	int	true		消息主键	*/
    [BLMessage globalTimelinePostsWithBlock:^(NSArray *posts, NSError *error) {
        if (error) {
            return ;
        }
        if (posts.count>0) {
            BLMessage *message = [posts objectAtIndex:0];
            if (message.msg == nil) {
                _dataArray = [NSMutableArray arrayWithArray:posts];
                [self.tableView reloadData];
            }else{
                if ([message.msg isEqualToString:@"succ"]) {
                    [ShowLoading showSuccView:self.view message:@"删除成功！"];
                }
                
            }
        }
    } path:path];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self setRead:indexPath.row];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSString *str = @"证书是密钥对的非秘密的部分。将它发送给其它人是安全的，比如通过SSL通讯的过程中就会包含证书。然而，对于私钥，当然是私有的。它是秘密的。你的私钥只对你有用，对其他人没用。要重视的是：如果你没有私钥的话，就无法使用证书。";
    
    BLMessage *myMSG = [_dataArray objectAtIndex:indexPath.row];
    size = [myMSG.message sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(320-36, 2000) lineBreakMode:NSLineBreakByCharWrapping];
    return size.height+60;
}

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
    
    [self requestData];
	_reloading = YES;
	
}

- (void)doneReLoadingTableViewData
{
	//  model should call this when its done loading
	_reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:_tableView];
    [_tableView reloadData];
    
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
//    [_refreshTailerView egoRefreshScrollViewDidEndDragging:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
//    [_refreshTailerView egoRefreshScrollViewDidEndDragging:scrollView];
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}


#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	if (view.tag == EGOHeaderView) {
        [self reloadTableViewDataSource];
    } else {
//        [self loadMoreTableViewDataSource];
    }
    
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	return _reloading; // should return if data source model is reloading
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return [NSDate date]; // should return date data source was last changed
	
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
