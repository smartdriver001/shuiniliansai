//
//  BLResetPwd.h
//  ShuiNiLianSai
//
//  Created by 陈庭俊 on 14-4-1.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BLResetPwd : NSObject

@property(nonatomic,strong)NSString *msg;
@property(nonatomic,strong)NSString *stat;

@property(nonatomic,strong)NSString *uid;
- (id)initWithDic:(NSDictionary *)dic;

+ (void)globalTimelinePostsWithBlock:(void (^)(NSArray *posts, NSError *error))block path:(NSString *)path;

@end
