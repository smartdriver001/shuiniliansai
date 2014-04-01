//
//  BLAdvertise.m
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-3-26.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLAdvertise.h"
#import "BLAFAppAPIClient.h"

@implementation BLAdvertise
-(id)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        
        _stat = [dic valueForKey:@"stat"];
        _msg = [dic valueForKey:@"msg"];
        _url = [dic valueForKey:@"url"];
        _title = [dic valueForKey:@"title"];
        _ord = [dic valueForKey:@"ord"];
       
    }
    return self;
}

+(void)globalTimelinePostsWithBlock:(void (^)(NSArray *, NSError *))block path:(NSString *)path{
    [[BLAFAppAPIClient sharedClientAPI] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id JSON) {
        
        if (block) {
            [[BLUtils globalCache]setData:JSON forKey:@"urlsData"];
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
    
    NSArray *dataArr =[dic valueForKey:@"data"];

    if (dataArr.count > 0) {
        
        for (id dic in dataArr) {
            BLAdvertise *advertise = [[BLAdvertise alloc]initWithDic:dic];
            advertise.stat = [dic valueForKey:@"stat"];
            advertise.msg = [dic valueForKey:@"msg"];
            [mutablePosts addObject:advertise];
        }
        
    }else{
        BLAdvertise *advertise = [[BLAdvertise alloc]initWithDic:dic];
        advertise.stat = [dic valueForKey:@"stat"];
        advertise.msg = [dic valueForKey:@"msg"];
        [mutablePosts addObject:advertise];
    }
    return mutablePosts;
    
}
@end
