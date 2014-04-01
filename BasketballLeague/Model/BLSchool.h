//
//  BLSchool.h
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-3-27.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BLSchool : NSObject

@property(nonatomic,strong)NSString *msg;
@property(nonatomic,strong)NSString *stat;
@property(nonatomic,strong)NSString *schoolId;
@property(nonatomic,strong)NSString *ord;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSMutableArray *colleges;
- (id)initWithDic:(NSDictionary *)dic;

+ (void)globalTimelinePostsWithBlock:(void (^)(NSArray *posts, NSError *error))block path:(NSString *)path;

+(NSArray *)parseJsonToArray :(NSData *)JSON;
@end
