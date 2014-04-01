//
//  BLPhoto.m
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-3-9.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLPhoto.h"
#import "BLAFAppAPIClient.h"

@implementation BLPhoto

-(id)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        _imgid = [dic valueForKey:@"imgid"];
        _uid = [dic valueForKey: @"uid"];
        _url = [dic valueForKey: @"url"];
        _thumburl = [dic valueForKey:@"thumburl"];
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
    
    NSDictionary *myarr =[dic valueForKey:@"data"];
    NSString *count = [myarr valueForKey:@"totalCnt"];
    if ([count intValue] > 0) {
        
        NSArray *dicArray = [myarr valueForKey:@"lists"];

        if (dicArray.count > 0) {
            for (NSDictionary *dic in dicArray) {
                BLPhoto *photo = [[BLPhoto alloc]initWithDic:dic ];
                photo.stat = [dic valueForKey:@"stat"];
                photo.msg = [dic valueForKey:@"msg"];
                [mutablePosts addObject:photo];
            }
        }
    }else{
        BLPhoto *photo = [[BLPhoto alloc]init];
        photo.stat = [dic valueForKey:@"stat"];
        photo.msg = [dic valueForKey:@"msg"];
        [mutablePosts addObject:photo];
    }
    
//    NSArray *dddic = [dicArray objectAtIndex:0];
    
    return mutablePosts;
    
}
@end
