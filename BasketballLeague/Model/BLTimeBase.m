//
//  BLTimeBase.m
//  BasketballLeague
//
//  Created by 崔洪禄 on 14-3-15.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLTimeBase.h"
#import "BLAFAppAPIClient.h"

@implementation BLTimeBase

-(id)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        _timeDataArray = [NSMutableArray array];
        _msg = [dic valueForKey:@"msg"];
        _stat = [dic valueForKey:@"stat"];
        
        for (id dics in [dic valueForKey:@"data"]) {
            BLTimeData *data = [[BLTimeData alloc]initWithDic:dics];
            [_timeDataArray addObject:data];
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
    
    BLTimeBase *base = [[BLTimeBase alloc]initWithDic:dic];
    [mutablePosts addObject:base];
    
    return mutablePosts;
    
}

@end
