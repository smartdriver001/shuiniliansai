//
//  BLData.m
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-2-20.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLData.h"
#import "BLLists.h"
#import "BLMy_teamMembers.h"
#import "BLMyteamImages.h"
#import "BLTotalAndAvg.h"

@implementation BLData
-(id)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        _listsArray = [NSMutableArray array];
        _membersArray = [NSMutableArray array];
        _imagesArray = [NSMutableArray array];
        _totalArray = [NSMutableArray array];
        _avgArray = [NSMutableArray array];
        
        _uid = [dic valueForKey:@"uid"];
        _token = [dic valueForKey:@"token"];
        
        //全国赛程
        _totalCnt = [dic objectForKey:@"totalCnt"];
        _page = [dic objectForKey:@"page"];
        
        //单场比赛
        _date = [dic valueForKey:@"date"];
        _time = [dic valueForKey:@"time"];
        _place = [dic valueForKey:@"place"];
        _scoreA = [dic valueForKey:@"scoreA"];
        _scoreB = [dic valueForKey:@"scoreB"];
        _teamNameA = [dic valueForKey:@"teamNameA"];
        _teamNameB = [dic valueForKey:@"teamNameB"];
        _iconA = [dic valueForKey:@"iconA"];
        _iconB = [dic valueForKey:@"iconB"];
        
        //我的战队
        _teamname = [dic valueForKey:@"teamname"];
        _captain = [dic valueForKey:@"captain"];
        _slogan = [dic valueForKey:@"slogan"];
        _intro = [dic valueForKey:@"intro"];
        _school = dic[@"school"];
        _college = dic[@"college"];
        _createtime = [dic valueForKey:@"createtime"];
        _matchCnt = [dic valueForKey:@"matchCnt"];
        _exprienceValue = [dic valueForKey:@"exprienceValue"];
        _ranking = [dic valueForKey:@"ranking"];
        _winCnt = [dic valueForKey:@"winCnt"];
        _teamid = [dic valueForKey:@"teamid"];
        _icon = [dic valueForKey:@"icon"];
        
        //我的比赛统计
        _lanban = [dic valueForKey:@"lanban"];
        _zhugong = [dic valueForKey:@"zhugong"];
        _qiangduan = [dic valueForKey:@"qiangduan"];
        _gaimao = [dic valueForKey:@"gaimao"];
        _yuantou = [dic valueForKey:@"yuantou"];
        _defen = [dic valueForKey:@"defen"];
        _yifen = [dic valueForKey:@"yifen"];
        _pkMsg1 = [dic valueForKey:@"pkMsg1"];
        _pkMsg2 = [dic valueForKey:@"pkMsg2"];
        _chenghao = [dic valueForKey:@"chenghao"];

        //关于我们
        _version = [dic valueForKey:@"version"];
        _customerservicephone = [dic valueForKey:@"customerservicephone"];
        _weibo = [dic valueForKey:@"weibo"];
        _weixin = [dic valueForKey:@"weixin"];
        
        //竞猜规则
        _quizrules = [dic valueForKey:@"quizrules"];
        
        //奖励制度
        _text = [dic valueForKey:@"text"];
        
        if ([_totalCnt intValue] >0 && _date == nil && _teamid ==nil) {
            for (id dics in [dic valueForKey:@"lists"]) {
                BLLists *list = [[BLLists alloc]initWithDic:dics];
                [_listsArray addObject:list];
            }
        }else if (_totalCnt == nil && _date != nil && _teamid == nil){
            _teamA = [[BLSingleTeamA alloc]initWithDic:[dic valueForKey:@"teamAData"]];
            _teamB = [[BLSingleTeamB alloc]initWithDic:[dic valueForKey:@"teamBData"]];
            _teamACnt = [[BLSingleTeamACnt alloc]initWithDic:[dic valueForKey:@"teamACnt"]];
            _teamBCnt = [[BLSingleTeamBCnt alloc]initWithDic:[dic valueForKey:@"teamBCnt"]];
        }else if (_totalCnt == nil && _date == nil && _teamid != nil){
            for (id dics in [dic valueForKey:@"members"]) {
                BLMy_teamMembers * members = [[BLMy_teamMembers alloc]initWithDic:dics];
                [_membersArray addObject:members];
            }
            for (id dics in [dic valueForKey:@"images"]) {
                BLMyteamImages * images = [[BLMyteamImages alloc]initWithDic:dics];
                [_imagesArray addObject:images];
            }
        }else if (_totalCnt == nil && _date == nil && _teamid == nil){
            for (id dics in [dic valueForKey:@"total"]) {
                BLTotalAndAvg *list = [[BLTotalAndAvg alloc]initWithDic:dics];
                [_totalArray addObject:list];
            }
            for (id dics in [dic valueForKey:@"avg"]) {
                BLTotalAndAvg *list = [[BLTotalAndAvg alloc]initWithDic:dics];
                [_avgArray addObject:list];
            }
        }
        
    }
    return self;
}
@end
