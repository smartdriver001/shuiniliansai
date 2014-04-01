//
//  BLMyLevel.h
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-3-17.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BLMyLevel : NSObject

@property(nonatomic,strong)NSMutableArray *myLevels;
@property(nonatomic,strong)NSString *msg;
@property(nonatomic,strong)NSString *stat;

- (id)initWithDic:(NSDictionary *)dic;

+ (void)globalTimelinePostsWithBlock:(void (^)(NSArray *posts, NSError *error))block path:(NSString *)path;

@end
