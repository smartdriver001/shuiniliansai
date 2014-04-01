//
//  BLSingleTeamBCnt.h
//  BasketballLeague
//
//  Created by 崔洪禄 on 14-3-14.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BLSingleTeamBCnt : NSObject

@property(nonatomic,strong)NSString *defenCnt;
@property(nonatomic,strong)NSString *yifenCnt;
@property(nonatomic,strong)NSString *lanbanCnt;
@property(nonatomic,strong)NSString *zhugongCnt;
@property(nonatomic,strong)NSString *qiangduanCnt;
@property(nonatomic,strong)NSString *gaimaoCnt;
@property(nonatomic,strong)NSString *yuantouCnt;

-(id)initWithDic:(NSDictionary *)dic;

@end
