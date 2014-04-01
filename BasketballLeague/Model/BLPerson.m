//
//  BLPerson.m
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-3-2.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLPerson.h"

@implementation BLPerson

-(id)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        _uid = [dic valueForKey:@"uid"];
        _icon = [dic valueForKey: @"icon"];
        _inttime = [dic valueForKey: @"inttime"];
        _name = [dic valueForKey:@"name"];
        _honourname = [dic valueForKey:@"honourname"];
        _totalNum = [dic valueForKey:@"totalNum"];
    }
    return self;
}
@end
