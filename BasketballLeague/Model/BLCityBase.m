//
//  BLCityBase.m
//  BasketballLeague
//
//  Created by 崔洪禄 on 14-3-10.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLCityBase.h"
#import "BLAFAppAPIClient.h"
#import "BLCityLists.h"

@implementation BLCityBase

-(id)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        _cityListsArray = [NSMutableArray array];
        _msg = [dic valueForKey:@"msg"];
        _stat = [dic valueForKey:@"stat"];
        
        for (id dics in [dic valueForKey:@"data"]) {
            BLCityLists *list = [[BLCityLists alloc]initWithDic:dics];
            [_cityListsArray addObject:list];
        }
    }
    return self;
}

+(void)globalTimelinePostsWithBlock:(void (^)(NSArray *, NSError *))block path:(NSString *)path{
    [[BLAFAppAPIClient sharedClient] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id JSON) {
        
        if (block) {
            [[BLUtils globalCache]setData:JSON forKey:@"city" withTimeoutInterval:60*60*24];
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
    
    BLCityBase *base = [[BLCityBase alloc]initWithDic:dic];
    [mutablePosts addObject:base];
    
    return mutablePosts;
    
}

@end
