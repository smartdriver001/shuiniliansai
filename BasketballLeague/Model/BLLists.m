//
//  BLLists.m
//  BasketballLeague
//
//  Created by 崔洪禄 on 14-2-24.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLLists.h"

@implementation BLLists

-(id)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        _matchid = [dic objectForKey:@"matchid"];
        _date = [dic valueForKey:@"date"];
        _time = [dic valueForKey:@"time"];
        _place = [dic valueForKey:@"place"];
        _type = [dic valueForKey:@"type"];
        _scoreA = [dic valueForKey:@"scoreA"];
        _scoreB = [dic valueForKey:@"scoreB"];
        _teamNameA = [dic valueForKey:@"teamNameA"];
        _teamNameB = [dic valueForKey:@"teamNameB"];
        _iconA = [dic valueForKey:@"iconA"];
        _iconB = [dic valueForKey:@"iconB"];
        _school = dic[@"school"];
        
        _uid = [dic valueForKey:@"uid"];
        _name = [dic valueForKey:@"name"];
        _score = [dic valueForKey:@"score"];
        _icon = [dic valueForKey:@"icon"];
        
        _realname = [dic valueForKey:@"realname"];
        _num = [dic valueForKey:@"num"];
        _username = [dic valueForKey:@"username"];

    }
    return self;
}

@end
