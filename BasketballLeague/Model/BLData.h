//
//  BLData.h
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-2-20.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BLSingleTeamA.h"
#import "BLSingleTeamB.h"
#import "BLSingleTeamACnt.h"
#import "BLSingleTeamBCnt.h"

@interface BLData : NSObject

@property(nonatomic,strong)NSString *uid;
@property(nonatomic,strong)NSString *token;

//全国赛程接口
@property(nonatomic,strong)NSString *totalCnt;
@property(nonatomic,strong)NSString *page;

@property(nonatomic,strong)NSMutableArray *listsArray;

//单场比赛接口
@property(nonatomic,strong)NSString *date;
@property(nonatomic,strong)NSString *time;
@property(nonatomic,strong)NSString *place;
@property(nonatomic,strong)NSString *scoreA;
@property(nonatomic,strong)NSString *scoreB;
@property(nonatomic,strong)NSString *teamNameA;
@property(nonatomic,strong)NSString *teamNameB;
@property(nonatomic,strong)NSString *iconA;
@property(nonatomic,strong)NSString *iconB;

@property(nonatomic,strong)BLSingleTeamA *teamA;
@property(nonatomic,strong)BLSingleTeamB *teamB;

@property(nonatomic,strong)BLSingleTeamACnt *teamACnt;
@property(nonatomic,strong)BLSingleTeamBCnt *teamBCnt;

//我的战队接口
@property(nonatomic,strong)NSString *teamname;
@property(nonatomic,strong)NSString *captain;
@property(nonatomic,strong)NSString *slogan;
@property(nonatomic,strong)NSString *intro;
@property(nonatomic,strong)NSString *createtime;
@property(nonatomic,strong)NSString *matchCnt;
@property(nonatomic,strong)NSString *exprienceValue;
@property(nonatomic,strong)NSString *ranking;
@property(nonatomic,strong)NSString *winCnt;
@property(nonatomic,strong)NSString *teamid;
@property(nonatomic,strong)NSString *icon;
@property(nonatomic,strong)NSString *school;
@property(nonatomic,strong)NSString *college;

@property(nonatomic,strong)NSMutableArray *membersArray;
@property(nonatomic,strong)NSMutableArray *imagesArray;

//我的比赛 统计
@property(nonatomic,strong)NSString *lanban;
@property(nonatomic,strong)NSString *zhugong;
@property(nonatomic,strong)NSString *qiangduan;
@property(nonatomic,strong)NSString *gaimao;
@property(nonatomic,strong)NSString *yuantou;
@property(nonatomic,strong)NSString *defen;
@property(nonatomic,strong)NSString *yifen;

@property(nonatomic,strong)NSString *pkMsg1;
@property(nonatomic,strong)NSString *pkMsg2;
@property(nonatomic,strong)NSString *chenghao;


//关于我们
@property(nonatomic,strong)NSString *version;
@property(nonatomic,strong)NSString *customerservicephone;
@property(nonatomic,strong)NSString *weibo;
@property(nonatomic,strong)NSString *weixin;

@property(nonatomic,strong)NSString *text;

@property(nonatomic,strong)NSMutableArray *totalArray;
@property(nonatomic,strong)NSMutableArray *avgArray;

//竞猜规则
@property(nonatomic,strong)NSString *quizrules;

- (id)initWithDic:(NSDictionary *)dic;//初始化数据

@end
