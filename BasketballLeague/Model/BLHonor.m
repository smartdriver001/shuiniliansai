//
//  BLHonor.m
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-3-8.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLHonor.h"
#import "BLAFAppAPIClient.h"

@implementation BLHonor
-(id)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        _cname = [dic valueForKey:@"cname"];
        _cnt = [dic valueForKey: @"cnt"];
        _ename = [dic valueForKey: @"ename"];
        _stat = [dic valueForKey:@"stat"];
        _msg = [dic valueForKey:@"msg"];

        _matchid = [dic valueForKey: @"matchid"];
        _mdate = [dic valueForKey: @"mdate"];
        _teamA = [dic valueForKey:@"teamA"];
        _teamB = [dic valueForKey:@"teamB"];
       
        _result = [dic valueForKey:@"result"];
        _honourname = [dic valueForKey:@"honourname"];
        _place = [dic valueForKey:@"place"];
    }
    return self;
}

+(void)globalTimelinePostsWithBlock:(void (^)(NSArray *, NSError *))block path:(NSString *)path{
    [[BLAFAppAPIClient sharedClient] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id JSON) {
        
        if (block) {
            block([self parseJsonToArray:JSON], nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block([NSArray array], error);
        }
    }];
    
}

+(NSArray *)parseJsonToArray :(NSData *)JSON{
    
    NSError *error;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:JSON options:kNilOptions error:&error];
    NSLog(@"%@",dic);
    NSMutableArray *mutablePosts = [NSMutableArray arrayWithCapacity:0];
    
    NSArray *dicArray = [dic valueForKey:@"data"];
    
    if (dicArray.count > 0) {
        for (id dic in dicArray) {
            BLHonor *honor = [[BLHonor alloc]initWithDic:dic];
            honor.stat = [dic valueForKey:@"stat"];
            honor.msg = [dic valueForKey:@"msg"];
            [mutablePosts addObject:honor];
        }
    }else{
        BLHonor *honor = [[BLHonor alloc]init];
        honor.stat = [dic valueForKey:@"stat"];
        honor.msg = [dic valueForKey:@"msg"];
        [mutablePosts addObject:honor];
    }
    
    return mutablePosts;
    
}
@end
