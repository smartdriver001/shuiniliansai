//
//  BLUpdateApp.m
//  ShuiNiLianSai
//
//  Created by chentingjun on 14-4-4.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLUpdateApp.h"
#import "BLAFAppAPIClient.h"

@implementation BLUpdateApp

-(id)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        _stat = [dic valueForKey:@"stat"];
        _msg = [dic valueForKey:@"msg"];
        _size = dic[@"data"][@"size"];
        _url = dic[@"data"][@"url"];
        _version = dic[@"data"][@"version"];
        _content = dic[@"data"][@"content"];
        _type = dic[@"data"][@"type"];
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
    
    BLUpdateApp *update = [[BLUpdateApp alloc]initWithDic:dic];
    [mutablePosts addObject:update];
    return mutablePosts;
    
}

@end
