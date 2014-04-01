//
//  BLMyTeamStatisticsViewController.h
//  BasketballLeague
//
//  Created by 崔洪禄 on 14-3-4.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLBaseViewController.h"

@interface BLMyTeamStatisticsViewController : BLBaseViewController

-(void)setTeamName:(NSString *)teamName;
@property(nonatomic,strong)NSString *matchid;

-(void)requestData:(NSString *)matchId from:(NSString *)from;

@end
