//
//  BLMyMessageViewController.h
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-3-20.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLBaseViewController.h"
#import "EGORefreshTableHeaderView.h"

@interface BLMyMessageViewController : BLBaseViewController<UITableViewDataSource,UITableViewDelegate,EGORefreshTableHeaderDelegate> {
    
    EGORefreshTableHeaderView *_refreshHeaderView;
    
    BOOL _reloading;
}

- (void)reloadTableViewDataSource;


@end
