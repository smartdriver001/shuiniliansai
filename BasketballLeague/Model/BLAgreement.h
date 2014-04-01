//
//  BLAgreement.h
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-2-19.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//
//用户协议
#import "BLBaseObject.h"

@interface BLAgreement : NSObject

@property(nonatomic,strong)NSString *stat;
@property(nonatomic,strong)NSString *msg;
@property(nonatomic,strong)NSString *doc;

-(id)initWithDic:(NSDictionary *)dic;
+(void)globalTimelinePostsWithBlock:(void (^)(NSArray *, NSError *))block path:(NSString *)path;
@end
