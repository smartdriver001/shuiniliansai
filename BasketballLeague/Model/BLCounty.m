//
//  BLCounty.m
//  BasketballLeague
//
//  Created by 崔洪禄 on 14-3-10.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLCounty.h"
#import "BLVillage.h"

@implementation BLCounty

-(id)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        _villageArray = [NSMutableArray array];
        _cityId = [dic objectForKey:@"id"];
        _name = [dic valueForKey:@"name"];
        
        for (id dics in [dic valueForKey:@"children"]) {
            BLVillage *list = [[BLVillage alloc]initWithDic:dics];
            [_villageArray addObject:list];
        }
        
    }
    return self;
}

@end
