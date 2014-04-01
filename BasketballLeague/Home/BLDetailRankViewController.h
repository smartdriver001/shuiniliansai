//
//  BLDetailRankViewController.h
//  BasketballLeague
//
//  Created by 崔洪禄 on 14-3-9.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLBaseViewController.h"
#import "EGORefreshTableHeaderView.h"
#import "BLBaseObject.h"

@interface BLDetailRankViewController : BLBaseViewController<EGORefreshTableHeaderDelegate> {
    
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
