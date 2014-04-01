//
//  BLTimeBase.h
//  BasketballLeague
//
//  Created by 崔洪禄 on 14-3-15.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BLTimeData.h"

@interface BLTimeBase : NSObject

@property(nonatomic,strong)NSString *stat;
@property(nonatomic,strong)NSString *msg;

@property(nonatomic,strong)BLTimeData *data;

@property(nonatomic,strong)NSMutableArray * timeDataArray;

- (id)initWithDic:(NSDictionary *)dic;//初始化数据

+(void)globalTimelinePostsWithBlock:(void (^)(NSArray *, NSError *))block path:(NSString *)path;

@end
