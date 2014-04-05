//
//  BLUpdateApp.h
//  ShuiNiLianSai
//
//  Created by chentingjun on 14-4-4.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BLUpdateApp : NSObject


@property(nonatomic,strong)NSString *msg;
@property(nonatomic,strong)NSString *stat;

@property(nonatomic,strong)NSString *version;
@property(nonatomic,strong)NSString *size;
@property(nonatomic,strong)NSString *url;
@property(nonatomic,strong)NSString *content;
@property(nonatomic,strong)NSString *type;

- (id)initWithDic:(NSDictionary *)dic;

+ (void)globalTimelinePostsWithBlock:(void (^)(NSArray *posts, NSError *error))block path:(NSString *)path;

@end
