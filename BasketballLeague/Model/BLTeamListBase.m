//
//  BLTeamListBase.m
//  BasketballLeague
//
//  Created by 崔洪禄 on 14-3-7.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLTeamListBase.h"
#import "BLAFAppAPIClient.h"

@implementation BLTeamListBase

-(id)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        _msg = [dic valueForKey:@"msg"];
        _stat = [dic valueForKey:@"stat"];
        
        NSArray *dicArray = [dic valueForKey:@"data"];
        if(dicArray.count>0){
            _data = [[BLTeamListData alloc]initWithDic:[dic valueForKey:@"data"]];
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
    
    BLTeamListBase *base = [[BLTeamListBase alloc]initWithDic:dic];
    [mutablePosts addObject:base];
    
    return mutablePosts;
    
}

@end
