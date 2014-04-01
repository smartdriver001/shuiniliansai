//
//  BLFollowers.m
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-3-2.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLFollowers.h"
#import "BLAFAppAPIClient.h"

@implementation BLFollowers

-(id)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        _fansid = [dic valueForKey:@"fansid"];
        _icon = [dic valueForKey: @"icon"];
        _name = [dic valueForKey: @"name"];
        _relationship = [dic valueForKey:@"relationship"];
        _friendid = [dic valueForKey:@"friendid"];
        _stat = [dic valueForKey:@"stat"];
        _msg = [dic valueForKey:@"msg"];
        _visittime = [dic valueForKey:@"visittime"];
        _uid = [dic valueForKey:@"uid"];
        _inttime = [dic valueForKey:@"inttime"];
        
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
    
    BLFollowers *followers;
    
    if (dicArray.count > 0) {
        for (id dic in dicArray) {
            BLFollowers *followers = [[BLFollowers alloc]initWithDic:dic];
            followers.stat = [dic valueForKey:@"stat"];
            followers.msg = [dic valueForKey:@"msg"];
            [mutablePosts addObject:followers];
        }
    }else{
        followers = [[BLFollowers alloc]init];
        followers.stat = [dic valueForKey:@"stat"];
        followers.msg = [dic valueForKey:@"msg"];
        [mutablePosts addObject:followers];
    }
    
    return mutablePosts;
    
}
@end
