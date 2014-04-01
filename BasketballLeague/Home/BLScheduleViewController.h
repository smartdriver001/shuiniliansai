//
//  BLScheduleViewController.h
//  BasketballLeague
//
//  Created by 崔洪禄 on 14-2-25.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLBaseViewController.h"
#import "EGORefreshTableHeaderView.h"
#import "BLBaseObject.h"

@interface BLScheduleViewController : BLBaseViewController<EGORefreshTableHeaderDelegate>{
    
    EGORefreshTableHeaderView *_refreshHeaderView;
	EGORefreshTableHeaderView *_refreshTailerView;
	
	BOOL _reloading;
    
    int pageIndex;
    BOOL isReload;
    
    BLBaseObject *base;
}

- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;

@property(nonatomic,strong)NSString *condition;

-(void)requestData:(NSString *)condition;

@end
