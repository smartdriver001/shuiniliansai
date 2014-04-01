//
//  BLTeamListData.h
//  BasketballLeague
//
//  Created by 崔洪禄 on 14-3-7.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BLTeamListData : NSObject

@property(nonatomic,strong)NSString *totalCnt;
@property(nonatomic,strong)NSString *page;

@property(nonatomic,strong)NSMutableArray * myTeamListArray;

- (id)initWithDic:(NSDictionary *)dic;//初始化数据

@end
