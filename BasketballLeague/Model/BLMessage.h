//
//  BLMessage.h
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-3-20.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BLMessage : NSObject

@property(nonatomic,strong)NSString *msg;
@property(nonatomic,strong)NSString *stat;
@property(nonatomic,strong)NSString *msguid;
@property(nonatomic,strong)NSString *message;
@property(nonatomic,strong)NSString *msg_id;
@property(nonatomic,strong)NSString *sendtime;
@property(nonatomic,strong)NSString *type;
@property(nonatomic,strong)NSString *extra;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *totalCnt;
@property(nonatomic,strong)NSMutableArray *messages;
@property(nonatomic,strong)NSString *isreaded;
@property(nonatomic,strong)NSString *joinerId;
@property(nonatomic,strong)NSString *teamId;
- (id)initWithDic:(NSDictionary *)dic;

+ (void)globalTimelinePostsWithBlock:(void (^)(NSArray *posts, NSError *error))block path:(NSString *)path;

@end
