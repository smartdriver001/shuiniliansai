//
//  BLTeamListData.m
//  BasketballLeague
//
//  Created by 崔洪禄 on 14-3-7.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLTeamListData.h"
#import "BLTeamListLists.h"

@implementation BLTeamListData

-(id)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        _myTeamListArray = [NSMutableArray array];
        _totalCnt = [dic objectForKey:@"totalCnt"];
        _page = [dic objectForKey:@"page"];
        if ([_totalCnt intValue] > 0) {
            
            for (id lists in [dic valueForKey:@"lists"]) {
                BLTeamListLists * teamList = [[BLTeamListLists alloc]initWithDic:lists];
                [_myTeamListArray addObject:teamList];
            }
        }
    }
    return self;
}

@end
