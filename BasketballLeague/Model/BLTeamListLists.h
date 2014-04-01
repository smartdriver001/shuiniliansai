//
//  BLTeamListLists.h
//  BasketballLeague
//
//  Created by 崔洪禄 on 14-3-7.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BLTeamListLists : NSObject

@property(nonatomic,strong)NSString *teamId;
@property(nonatomic,strong)NSString *matchCnt;
@property(nonatomic,strong)NSString *slogan;
@property(nonatomic,strong)NSString *teamImage;
@property(nonatomic,strong)NSString *teamName;
@property(nonatomic,strong)NSString *winCnt;

//球员
@property(nonatomic,strong)NSString *uid;
@property(nonatomic,strong)NSString *icon;
@property(nonatomic,strong)NSString *username;
@property(nonatomic,strong)NSString *realname;

-(id)initWithDic:(NSDictionary *)dic;

@end
