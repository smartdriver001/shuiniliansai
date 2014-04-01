
//
//  BLFollowers.h
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-3-2.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BLFollowers : NSObject

@property(nonatomic,strong)NSString *fansid;
@property(nonatomic,strong)NSString *icon;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *relationship;
@property(nonatomic,strong)NSString *msg;
@property(nonatomic,strong)NSString *stat;
@property(nonatomic,strong)NSString *friendid;
@property(nonatomic,strong)NSString *visittime;
@property(nonatomic,strong)NSString *inttime;
@property(nonatomic,strong)NSString *uid;

- (id)initWithDic:(NSDictionary *)dic;

+ (void)globalTimelinePostsWithBlock:(void (^)(NSArray *posts, NSError *error))block path:(NSString *)path;
@end
