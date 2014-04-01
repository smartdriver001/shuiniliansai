//
//  BLAdvertise.h
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-3-26.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BLAdvertise : NSObject

@property(nonatomic,strong)NSString *msg;
@property(nonatomic,strong)NSString *stat;
@property(nonatomic,strong)NSString *url;
@property(nonatomic,strong)NSString *ord;
@property(nonatomic,strong)NSString *title;

- (id)initWithDic:(NSDictionary *)dic;

+ (void)globalTimelinePostsWithBlock:(void (^)(NSArray *posts, NSError *error))block path:(NSString *)path;

+(NSArray *)parseJsonToArray :(NSData *)JSON;
@end
