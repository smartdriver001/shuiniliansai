//
//  BLResetPwd.m
//  ShuiNiLianSai
//
//  Created by 陈庭俊 on 14-4-1.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLResetPwd.h"
#import "BLAFAppAPIClient.h"

@implementation BLResetPwd

-(id)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        _stat = [dic valueForKey:@"stat"];
        _msg = [dic valueForKey:@"msg"];
        _uid = dic[@"data"][@"uid"];
    }
    return self;
}

+(void)globalTimelinePostsWithBlock:(void (^)(NSArray *, NSError *))block path:(NSString *)path{
    [[BLAFAppAPIClient sharedClientAPI] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id JSON) {
        
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
    
    BLResetPwd *team = [[BLResetPwd alloc]initWithDic:dic];
    [mutablePosts addObject:team];
    return mutablePosts;
    
}
@end
