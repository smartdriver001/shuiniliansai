//
//  BLTeamListLists.m
//  BasketballLeague
//
//  Created by 崔洪禄 on 14-3-7.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLTeamListLists.h"

@implementation BLTeamListLists

-(id)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        _teamId = [dic objectForKey:@"id"];
        _matchCnt = [dic valueForKey:@"matchCnt"];
        _slogan = [dic valueForKey:@"slogan"];
        _teamImage = [dic valueForKey:@"teamImage"];
        _teamName = [dic valueForKey:@"teamName"];
        _winCnt = [dic valueForKey:@"winCnt"];
        //
        _uid = dic[@"uid"];
        _username = dic[@"username"];
        _realname = dic[@"realname"];
        _icon = dic[@"icon"];
    }
    return self;
}

@end
