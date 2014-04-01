//
//  BLPerson.h
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-3-2.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BLPerson : NSObject

@property(nonatomic,strong)NSString *uid;
@property(nonatomic,strong)NSString *icon;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *inttime;
@property(nonatomic,strong)NSString *honourname;
@property(nonatomic,strong)NSString *totalNum;
@property(nonatomic,strong)NSMutableArray *details;

- (id)initWithDic:(NSDictionary *)dic;

@end
