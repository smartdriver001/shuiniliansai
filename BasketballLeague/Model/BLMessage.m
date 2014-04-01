//
//  BLMessage.m
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-3-20.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLMessage.h"
#import "BLAFAppAPIClient.h"

@implementation BLMessage
-(id)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        
        _stat = [dic valueForKey:@"stat"];
        _msg = [dic valueForKey:@"msg"];
        _msguid = [dic valueForKey:@"id"];
        _message = [dic valueForKey:@"message"];
        _sendtime = [dic valueForKey:@"sendtime"];
        _type = [dic valueForKey:@"type"];
        _extra = [dic valueForKey:@"extra"];
        _title = [dic valueForKey:@"title"];
        _msg_id = [dic valueForKey:@"msg_id"];
        _totalCnt = [dic valueForKey:@"totalCnt"];
        _isreaded = [dic valueForKey:@"isreaded"];
        _joinerId = [dic valueForKey:@"extra"][@"uid"];
        _teamId = [dic valueForKey:@"extra"][@"teamid"];
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
    
    NSDictionary *dataDic =[dic valueForKey:@"data"];
    NSString *count = [dataDic valueForKey:@"totalCnt"];
    
    if ([count intValue] > 0) {
        
        NSArray *myarr = [dataDic valueForKey:@"lists"];

        for (id dic in myarr) {
            BLMessage *message = [[BLMessage alloc]initWithDic:dic];
            message.stat = [dic valueForKey:@"stat"];
            message.msg = [dic valueForKey:@"msg"];
            [mutablePosts addObject:message];
        }
    }else{
        BLMessage *message = [[BLMessage alloc]initWithDic:dic];
        message.stat = [dic valueForKey:@"stat"];
        message.msg = [dic valueForKey:@"msg"];
        [mutablePosts addObject:message];
    }
    
    return mutablePosts;
    
}
@end
