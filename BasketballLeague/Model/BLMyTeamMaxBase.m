//
//  BLMyTeamMaxBase.m
//  BasketballLeague
//
//  Created by 崔洪禄 on 14-3-3.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLMyTeamMaxBase.h"
#import "BLAFAppAPIClient.h"
#import "BLMyTeamMax.h"

@implementation BLMyTeamMaxBase

-(id)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        _myTeamMaxArray = [NSMutableArray array];
        _msg = [dic valueForKey:@"msg"];
        _stat = [dic valueForKey:@"stat"];
        
        for (id dics in [dic valueForKey:@"data"]) {
            BLMyTeamMax *max = [[BLMyTeamMax alloc]initWithDic:dics];
            [_myTeamMaxArray addObject:max];
        }
    }
    return self;
}

+(void)globalTimelinePostsWithBlock:(void (^)(NSArray *, NSError *))block path:(NSString *)path{
    [[BLAFAppAPIClient sharedClient] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id JSON) {
        
        if (block) {
            block([self parseStringToArray:JSON], nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block([NSArray array], error);
        }
    }];
    
}

+(NSArray *)parseStringToArray :(NSData *)JSON{
    
    NSError *error;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:JSON options:kNilOptions error:&error];
    NSLog(@"dic:%@",dic);
    NSMutableArray *mutablePosts = [NSMutableArray arrayWithCapacity:0];
    
    BLMyTeamMaxBase *base = [[BLMyTeamMaxBase alloc]initWithDic:dic];
    [mutablePosts addObject:base];
    
    return mutablePosts;
    
}

@end
