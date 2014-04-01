//
//  BLTotalAndAvg.m
//  BasketballLeague
//
//  Created by 崔洪禄 on 14-3-12.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLTotalAndAvg.h"

@implementation BLTotalAndAvg

-(id)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        _defen = [dic valueForKey:@"defen"];
        _fangui = [dic valueForKey:@"fangui"];
        _gaimao = [dic valueForKey:@"gaimao"];
        _name = [dic valueForKey:@"name"];
        _lanban = [dic valueForKey:@"lanban"];
        _qiangduan = [dic valueForKey:@"qiangduan"];
        _shiwu = [dic valueForKey:@"shiwu"];
        _yifen = [dic valueForKey:@"yifen"];
        _yuantou = [dic valueForKey:@"yuantou"];
        _zhugong = [dic valueForKey:@"zhugong"];
    }
    return self;
}

@end
