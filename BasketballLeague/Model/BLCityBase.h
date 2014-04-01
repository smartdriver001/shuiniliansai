//
//  BLCityBase.h
//  BasketballLeague
//
//  Created by 崔洪禄 on 14-3-10.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BLCityBase : NSObject

@property(nonatomic,strong)NSString *stat;
@property(nonatomic,strong)NSString *msg;

@property (nonatomic,strong) NSMutableArray * cityListsArray;

- (id)initWithDic:(NSDictionary *)dic;//初始化数据

+ (void)globalTimelinePostsWithBlock:(void (^)(NSArray *posts, NSError *error))block path:(NSString *)path;

+(NSArray *)parseStringToArray :(NSData *)JSON;
@end
