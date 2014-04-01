//
//  BLMy_teamMembers.m
//  BasketballLeague
//
//  Created by 崔洪禄 on 14-3-2.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLMy_teamMembers.h"

@implementation BLMy_teamMembers

-(id)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        _role = [dic objectForKey:@"role"];
        _iscaptain = [dic valueForKey:@"iscaptain"];
        _icon = [dic valueForKey:@"icon"];
        _uid = [dic valueForKey:@"uid"];
    }
    return self;
}

@end
