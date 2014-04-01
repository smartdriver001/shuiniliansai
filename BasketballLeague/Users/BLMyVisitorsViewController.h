//
//  BLMyVisitorsViewController.h
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-3-3.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLBaseViewController.h"

@interface BLMyVisitorsViewController : BLBaseViewController
<UITableViewDataSource,UITableViewDelegate>{
    UITableView *_tableView;
    NSMutableArray *visitorsArray;
}

-(void)requestData:(NSString *)uid;

@end
