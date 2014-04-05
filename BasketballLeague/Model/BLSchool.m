//
//  BLSchool.m
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-3-27.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLSchool.h"
#import "BLAFAppAPIClient.h"
#import "BLCollege.h"

@implementation BLSchool
-(id)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        _stat = [dic valueForKey:@"stat"];
        _msg = [dic valueForKey:@"msg"];
        _schoolId = [dic valueForKey:@"id"];
        _name = [dic valueForKey:@"name"];
        _ord = [dic valueForKey:@"ord"];
        NSArray *collegeArr = dic[@"items"];
        _colleges = [NSMutableArray array];
        for (id dic in collegeArr) {
            BLCollege *college = [[BLCollege alloc]initWithDic:dic];
            [_colleges addObject:college];
        }
    }
    return self;
}

+(void)globalTimelinePostsWithBlock:(void (^)(NSArray *, NSError *))block path:(NSString *)path{
    [[BLAFAppAPIClient sharedClientAPI] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id JSON) {
        
        if (block) {
            if (JSON) {
                [[BLUtils globalCache]setData:JSON forKey:@"schools"];
            }
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
            BLSchool *advertise = [[BLSchool alloc]initWithDic:dic];
            advertise.stat = [dic valueForKey:@"stat"];
            advertise.msg = [dic valueForKey:@"msg"];
            [mutablePosts addObject:advertise];
        }
        
    }else{
        BLSchool *advertise = [[BLSchool alloc]initWithDic:dic];
        advertise.stat = [dic valueForKey:@"stat"];
        advertise.msg = [dic valueForKey:@"msg"];
        [mutablePosts addObject:advertise];
    }
    
//    [BLUtils storeArr:mutablePosts key:@"schools"];
    
    return mutablePosts;
    
}
@end
