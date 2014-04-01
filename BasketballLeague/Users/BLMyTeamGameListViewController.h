//
//  BLMyTeamGameListViewController.h
//  BasketballLeague
//
//  Created by 崔洪禄 on 14-3-3.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLBaseViewController.h"

@interface BLMyTeamGameListViewController : BLBaseViewController

-(void)requestData:(NSString *)teamId titile:(NSString *)title from:(NSString *)from;

@property(nonatomic,strong)NSString *teamId;

@end
