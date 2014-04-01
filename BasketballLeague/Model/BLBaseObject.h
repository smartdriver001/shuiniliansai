//
//  BLBaseObject.h
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-2-19.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//
/*
 基类：重置密码接口、用户登录接口、完善注册用户资料接口、
      用户注册接口、发送短信接口、用户使用协议接口
 */
#import <Foundation/Foundation.h>
#import "BLData.h"
#import "BLPersonData.h"

@interface BLBaseObject : NSObject

@property(nonatomic,strong)NSString *stat;
@property(nonatomic,strong)NSString *msg;
@property(nonatomic,strong)NSString *docs;

@property(nonatomic,strong)BLData *data;

- (id)initWithDic:(NSDictionary *)dic;//初始化数据

+ (void)globalTimelinePostsWithBlock:(void (^)(NSArray *posts, NSError *error))block path:(NSString *)path;

+(void)globalRequestWithBlock:(void (^)(NSArray *, NSError *))block path:(NSString *)path;

@end
