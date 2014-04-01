//
//  BLMyteamImages.m
//  BasketballLeague
//
//  Created by 崔洪禄 on 14-3-2.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLMyteamImages.h"

@implementation BLMyteamImages

-(id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        _imgid = [dic valueForKey:@"imgid"];
        _imgURL = [dic valueForKey:@"imgURL"];
    }
    return self;
}

@end
