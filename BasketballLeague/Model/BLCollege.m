//
//  BLCollege.m
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-3-27.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLCollege.h"

@implementation BLCollege
-(id)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        _collegeId = [dic valueForKey:@"id"];
        _name = [dic valueForKey:@"name"];
    }
    return self;
}
@end
