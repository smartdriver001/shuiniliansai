//
//  BLTimeData.m
//  BasketballLeague
//
//  Created by 崔洪禄 on 14-3-15.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLTimeData.h"

@implementation BLTimeData

-(id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        _day = [dic valueForKey:@"day"];
        
        _timesArray = [dic valueForKey:@"times"];
        
    }
    return self;
}

@end
