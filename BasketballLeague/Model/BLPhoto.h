//
//  BLPhoto.h
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-3-9.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BLPhoto : NSObject

@property(nonatomic,strong)NSString *imgid;
@property(nonatomic,strong)NSString *uid;
@property(nonatomic,strong)NSString *url;
@property(nonatomic,strong)NSString *thumburl;
@property(nonatomic,strong)NSString *msg;
@property(nonatomic,strong)NSString *stat;

- (id)initWithDic:(NSDictionary *)dic;

+ (void)globalTimelinePostsWithBlock:(void (^)(NSArray *posts, NSError *error))block path:(NSString *)path;

@end
