//
//  BLLists.h
//  BasketballLeague
//
//  Created by 崔洪禄 on 14-2-24.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BLLists : NSObject

@property(nonatomic,strong)NSString *matchid;
@property(nonatomic,strong)NSString *date;
@property(nonatomic,strong)NSString *time;
@property(nonatomic,strong)NSString *place;
@property(nonatomic,strong)NSString *type;
@property(nonatomic,strong)NSString *scoreA;
@property(nonatomic,strong)NSString *scoreB;
@property(nonatomic,strong)NSString *teamNameA;
@property(nonatomic,strong)NSString *teamNameB;
@property(nonatomic,strong)NSString *iconA;
@property(nonatomic,strong)NSString *iconB;
@property(nonatomic,strong)NSString *school;

@property(nonatomic,strong)NSString *uid;
@property(nonatomic,strong)NSString *score;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *icon;

@property(nonatomic,strong)NSString *realname;
@property(nonatomic,strong)NSString *num;
@property(nonatomic,strong)NSString *username;

- (id)initWithDic:(NSDictionary *)dic;//初始化数据

@end
