//
//  BLVillage.m
//  BasketballLeague
//
//  Created by 崔洪禄 on 14-3-10.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLVillage.h"

@implementation BLVillage

-(id)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        _cityId = [dic objectForKey:@"id"];
        _name = [dic valueForKey:@"name"];
    }
    return self;
}

@end
