//
//  BLTeamsListViewController.h
//  BasketballLeague
//
//  Created by 崔洪禄 on 14-3-1.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLBaseViewController.h"
#import "BLAlphaView.h"
#import "EGORefreshTableHeaderView.h"
#import "BLTeamListBase.h"

@interface BLTeamsListViewController :BLBaseViewController<EGORefreshTableHeaderDelegate> {
    BOOL hideHeaderview;
    BLAlphaView *MYalphaView;
    
    EGORefreshTableHeaderView *_refreshHeaderView;
	EGORefreshTableHeaderView *_refreshTailerView;
	
	BOOL _reloading;
    
    int pageIndex;
    BOOL isReload;
    
    BLTeamListBase *base;
}

- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;

-(void)requestTeamsList;

@end
