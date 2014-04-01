//
//  BLBaseObject.m
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-2-19.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLBaseObject.h"
#import "BLAFAppAPIClient.h"

@implementation BLBaseObject

-(id)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        _msg = [dic valueForKey:@"msg"];
        _stat = [dic valueForKey:@"stat"];
        _docs = [dic valueForKey:@"docs"];

        NSArray *dicArray = [dic valueForKey:@"data"];
        if(dicArray.count>0){
            _data = [[BLData alloc]initWithDic:[dic valueForKey:@"data"]];
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


+(void)globalRequestWithBlock:(void (^)(NSArray *, NSError *))block path:(NSString *)path{
    [[BLAFAppAPIClient sharedClientAPI] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id JSON) {
        
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
    
    BLBaseObject *base = [[BLBaseObject alloc]initWithDic:dic];
    [mutablePosts addObject:base];
    
    return mutablePosts;
    
}

@end
