//
//  BLPersonData.h
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-2-28.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BLPersonData : NSObject

@property(nonatomic,strong)NSString *coinCnt;
@property(nonatomic,strong)NSString *jingyanzhi;
@property(nonatomic,strong)NSString *jingyanzhiMax;
@property(nonatomic,strong)NSString *level;
@property(nonatomic,strong)NSString *uid;
@property(nonatomic,strong)NSString *token;

@property(nonatomic,strong)NSString *yuantou;
@property(nonatomic,strong)NSString *qiangduan;
@property(nonatomic,strong)NSString *gaimao;
@property(nonatomic,strong)NSString *defen;
@property(nonatomic,strong)NSString *matchCnt;
@property(nonatomic,strong)NSString *albumCnt;

@property(nonatomic,strong)NSString *icon;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *sex;
@property(nonatomic,strong)NSString *heightS;
@property(nonatomic,strong)NSString *weightS;
@property(nonatomic,strong)NSString *ageS;
@property(nonatomic,strong)NSString *ballnumber;
@property(nonatomic,strong)NSString *teamName;
@property(nonatomic,strong)NSString *role;
@property(nonatomic,strong)NSString *isleader;
@property(nonatomic,strong)NSString *lanban;
@property(nonatomic,strong)NSString *zhugong;
@property(nonatomic,strong)NSString *birth;
@property(nonatomic,strong)NSString *fenmu;
@property(nonatomic,strong)NSString *teamid;
@property(nonatomic,strong)NSString *school;
@property(nonatomic,strong)NSString *college;
@property(nonatomic,strong)NSString *shoes;
@property(nonatomic,strong)NSString *size;

@property(nonatomic,strong)NSMutableArray *guanzhuArray;
@property(nonatomic,strong)NSMutableArray *visitorsArray;
@property(nonatomic,strong)NSMutableArray *funsArray;
@property(nonatomic,strong)NSMutableArray *honoursArray;

@property(nonatomic,strong)NSMutableArray *followersArray;

@property(nonatomic,strong)NSString *stat;
@property(nonatomic,strong)NSString *msg;

- (id)initWithDic:(NSDictionary *)dic;//初始化数据

+ (void)globalTimelinePostsWithBlock:(void (^)(NSArray *posts, NSError *error))block path:(NSString *)path;

@end
