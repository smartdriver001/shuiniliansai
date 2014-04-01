//
//  BLPersonData.m
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-2-28.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLPersonData.h"
#import "BLAFAppAPIClient.h"
#import "BLPerson.h"
#import "BLFollowers.h"

@implementation BLPersonData

-(id)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        
        _jingyanzhi = [dic valueForKey:@"jingyanzhi"];
        _level = [dic valueForKey:@"level"];
        _birth = [dic valueForKey:@"birth"];
        _matchCnt = [dic valueForKey:@"matchCnt"];
        _albumCnt = [dic valueForKey:@"albumCnt"];
        _coinCnt = [dic valueForKey:@"coinsCnt"];
        
        _qiangduan = [dic valueForKey:@"qiangduan"];
        _gaimao = [dic valueForKey:@"gaimao"];
        _defen = [dic valueForKey:@"defen"];
        
        _lanban = [dic valueForKey:@"lanban"];
        _zhugong = [dic valueForKey:@"zhugong"];
        _yuantou = [dic valueForKey:@"yuantou"];
        _fenmu = [dic valueForKey:@"fenmu"];
        
        _teamid = [dic valueForKey:@"teamid"];
        _status = dic[@"status"];
        
        _teamName = [dic valueForKey:@"teamName"];
        _role = [dic valueForKey:@"role"];
        _isleader = [dic valueForKey:@"isleader"];
        
        _weightS = [dic valueForKey:@"weight"];
        _ageS = [dic valueForKey:@"age"];
        _ballnumber = [dic valueForKey:@"ballnumber"];
        
        _school = [dic valueForKey:@"school"];
        _college = [dic valueForKey:@"college"];
        _shoes = [dic valueForKey:@"shoes"];
        _size = [dic valueForKey:@"size"];
        
        _name = [dic valueForKey:@"name"];
        _sex = [dic valueForKey:@"sex"];
        _heightS = [dic valueForKey:@"height"];
        
        _uid = [dic valueForKey:@"uid"];
        _token = [dic valueForKey:@"token"];
        _icon = [dic valueForKey:@"icon"];
        _jingyanzhiMax = [dic valueForKey:@"jingyanzhiMax"];

        NSArray *guanzhuArr = [dic valueForKey:@"guanzhu"];
        _guanzhuArray = [NSMutableArray array];
        for (id dic in guanzhuArr) {
            BLPerson *person = [[BLPerson alloc]initWithDic:dic];
            [_guanzhuArray addObject:person];
        }
        
        NSArray *funsArr = [dic valueForKey:@"funs"];
        _funsArray = [NSMutableArray array];
        for (id dic in funsArr) {
            BLPerson *person = [[BLPerson alloc]initWithDic:dic];
            [_funsArray addObject:person];
        }
        
        NSArray *honoursArr = [dic valueForKey:@"honours"];
        _honoursArray = [NSMutableArray array];
        for (id dic in honoursArr) {
            BLPerson *person = [[BLPerson alloc]initWithDic:dic];
            [_honoursArray addObject:person];
        }
        
        NSArray *visiterArr = [dic valueForKey:@"visitors"];
        _visitorsArray = [NSMutableArray array];
        for (id dic in visiterArr) {
            BLPerson *person = [[BLPerson alloc]initWithDic:dic];
            [_visitorsArray addObject:person];
        }
        
        NSArray *followers = [dic valueForKey:@"data"];
        _followersArray = [NSMutableArray array];
        for (id dic in followers) {
            BLFollowers *person = [[BLFollowers alloc]initWithDic:dic];
            [_followersArray addObject:person];
        }
        
        
    }
    return self;
}

+(void)globalTimelinePostsWithBlock:(void (^)(NSArray *, NSError *))block path:(NSString *)path{
    [[BLAFAppAPIClient sharedClient] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id JSON) {
        
        if (block) {
            if (JSON) {
                [[BLUtils globalCache]setData:JSON forKey:@"BLPersonData"];
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
    
    NSArray *dicArray = [dic valueForKey:@"data"];
    
    BLPersonData *person;
    if (dicArray.count > 0) {
        person = [[BLPersonData alloc]initWithDic:[dic valueForKey:@"data"]];
        person.stat = [dic valueForKey:@"stat"];
        person.msg = [dic valueForKey:@"msg"];
        [mutablePosts addObject:person];
    }else{
        person = [[BLPersonData alloc]init];
        person.stat = [dic valueForKey:@"stat"];
        person.msg = [dic valueForKey:@"msg"];
        [mutablePosts addObject:person];
    }
    
    return mutablePosts;
    
}
@end
