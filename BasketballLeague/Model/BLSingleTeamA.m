//
//  BLSingleTeamA.m
//  BasketballLeague
//
//  Created by 崔洪禄 on 14-3-1.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLSingleTeamA.h"
#import "BLSingleUser.h"

@implementation BLSingleTeamA

-(id)initWithDic:(NSArray *)arr{
    self = [super init];
    if (self) {
        _userArray = [NSMutableArray array];
        for (int i = 0; i < arr.count; i++) {
            NSDictionary * dic = [arr objectAtIndex:i];
            BLSingleUser * user = [[BLSingleUser alloc]initWithDic:dic];
            [_userArray addObject:user];
        }
    }
    return self;
}

@end
