//
//  BLAgreement.m
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-2-19.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLAgreement.h"
#import "BLAFAppAPIClient.h"

@implementation BLAgreement

-(id)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        _msg = [dic objectForKey:@"msg"];
        _stat = [dic objectForKey:@"stat"];
        _doc = [dic objectForKey:@"doc"];
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
    
    NSMutableArray *mutablePosts = [NSMutableArray arrayWithCapacity:0];

    BLAgreement *chief = [[BLAgreement alloc]initWithDic:dic];
    [mutablePosts addObject:chief];

    return mutablePosts;
    
}


@end
