//
//  BLSingleUser.m
//  BasketballLeague
//
//  Created by 崔洪禄 on 14-3-1.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLSingleUser.h"

@implementation BLSingleUser

-(id)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        _username = [dic valueForKey:@"username"];
        _uid = [dic valueForKey:@"uid"];
        _lanban = [dic valueForKey:@"lanban"];
        _zhugong = [dic valueForKey:@"zhugong"];
        _qiangduan = [dic valueForKey:@"qiangduan"];
        _gaimao = [dic valueForKey:@"gaimao"];
        _yuantou = [dic valueForKey:@"yuantou"];
        _defen = [dic valueForKey:@"defen"];
        _yifen = [dic valueForKey:@"yifen"];
    }
    return self;
}

@end
