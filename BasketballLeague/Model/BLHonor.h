//
//  BLHonor.h
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-3-8.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BLHonor : NSObject

@property(nonatomic,strong)NSString *ename;
@property(nonatomic,strong)NSString *cname;
@property(nonatomic,strong)NSString *cnt;
@property(nonatomic,strong)NSString *msg;
@property(nonatomic,strong)NSString *stat;
@property(nonatomic,strong)NSString *matchid;
@property(nonatomic,strong)NSString *mdate;
@property(nonatomic,strong)NSString *teamA;
@property(nonatomic,strong)NSString *teamB;
@property(nonatomic,strong)NSString *result;
@property(nonatomic,strong)NSString *place;
@property(nonatomic,strong)NSString *honourname;

- (id)initWithDic:(NSDictionary *)dic;

+ (void)globalTimelinePostsWithBlock:(void (^)(NSArray *posts, NSError *error))block path:(NSString *)path;
@end
