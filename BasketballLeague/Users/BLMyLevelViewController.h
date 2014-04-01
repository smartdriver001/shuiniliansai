//
//  BLMyLevelViewController.h
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-3-17.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLBaseViewController.h"

@interface BLMyLevelViewController : BLBaseViewController<UITableViewDataSource,UITableViewDelegate> {
    UITableView *myTableView;
    NSMutableArray *dataSource;
    NSMutableArray *titleS;
    NSString *myLevel;
}

-(void)from:(NSString *)from;

@end
