//
//  BLFollowersViewController.h
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-3-2.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//
//我的粉丝 和 我的关注

#import "BLBaseViewController.h"
#import "BLPersonData.h"
#import "BLCommentCell.h"
#import "BLSearchBarView.h"
#import "BLAlphaView.h"

@interface BLFollowersViewController : BLBaseViewController<UITableViewDataSource,UITableViewDelegate,GuanZhuDelegate,UITextFieldDelegate> {
    UITableView *_tableView;
    BLSearchBarView *searchView;
    BOOL focusCell;
    BLAlphaView *alphaView;
    NSString *myId;
    NSString *taId;
    NSString *whoseId;
}

@property(nonatomic,strong)NSMutableArray *followers;
@property(nonatomic)NSString *funsORfollowers;

-(void)requestData:(NSString *)uid funsORfollowers:(NSString *)funsORfollowers;

@end
