//
//  BLGoldRankViewController.h
//  BasketballLeague
//
//  Created by ptshan on 14-3-27.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLBaseViewController.h"
#import "EGORefreshTableHeaderView.h"
#import "BLBaseObject.h"

@interface BLGoldRankViewController : BLBaseViewController<EGORefreshTableHeaderDelegate> {
    
    EGORefreshTableHeaderView *_refreshHeaderView;
	EGORefreshTableHeaderView *_refreshTailerView;
	
	BOOL _reloading;
    
    int pageIndex;
    BOOL isReload;
    
    BLBaseObject *base;
    
}

-(void)setNavTitle:(NSString *)title;

- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;

-(void)requestPaihangbang;

@end
