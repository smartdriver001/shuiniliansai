//
//  BLMyTeamMax.m
//  BasketballLeague
//
//  Created by 崔洪禄 on 14-3-3.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLMyTeamMax.h"

@implementation BLMyTeamMax

-(id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        _type = [dic valueForKey:@"type"];
        _num = [dic valueForKey:@"num"];
        _uid = [dic valueForKey:@"uid"];
        _icon = [dic valueForKey:@"icon"];
        _name = [dic valueForKey:@"name"];
    }
    return self;
}

@end
