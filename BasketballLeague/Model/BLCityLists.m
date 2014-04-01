//
//  BLCityLists.m
//  BasketballLeague
//
//  Created by 崔洪禄 on 14-3-10.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLCityLists.h"
#import "BLCounty.h"

@implementation BLCityLists

-(id)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        _countyArray = [NSMutableArray array];
        _cityId = [dic objectForKey:@"id"];
        _name = [dic valueForKey:@"name"];
        
        for (id dics in [dic valueForKey:@"children"]) {
            BLCounty *list = [[BLCounty alloc]initWithDic:dics];
            [_countyArray addObject:list];
        }
    }
    return self;
}

@end
