//
//  BLSingleTeamBCnt.m
//  BasketballLeague
//
//  Created by 崔洪禄 on 14-3-14.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLSingleTeamBCnt.h"

@implementation BLSingleTeamBCnt

-(id)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        _defenCnt = [dic valueForKey:@"defenCnt"];
        _yifenCnt = [dic valueForKey:@"yifenCnt"];
        _lanbanCnt = [dic valueForKey:@"lanbanCnt"];
        _zhugongCnt = [dic valueForKey:@"zhugongCnt"];
        _qiangduanCnt = [dic valueForKey:@"qiangduanCnt"];
        _gaimaoCnt = [dic valueForKey:@"gaimaoCnt"];
        _yuantouCnt = [dic valueForKey:@"yuantouCnt"];
        
    }
    return self;
}

@end
