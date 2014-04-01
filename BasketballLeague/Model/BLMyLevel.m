//
//  BLMyLevel.m
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-3-17.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLMyLevel.h"
#import "BLAFAppAPIClient.h"

@implementation BLMyLevel
-(id)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        _stat = [dic valueForKey:@"stat"];
        _msg = [dic valueForKey:@"msg"];
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
    
    NSArray *myarr =[dic valueForKey:@"data"];
    
    BLMyLevel *level = [[BLMyLevel alloc]initWithDic:dic];
    level.stat = [dic valueForKey:@"stat"];
    level.msg = [dic valueForKey:@"msg"];
    
    level.myLevels = [NSMutableArray array];
    
    for (int i=0; i<myarr.count; i++) {
        [level.myLevels addObject:[myarr objectAtIndex:i]];
    }
    [mutablePosts addObject:level];
    return mutablePosts;
    
}
@end
