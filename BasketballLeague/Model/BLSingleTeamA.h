//
//  BLSingleTeamA.h
//  BasketballLeague
//
//  Created by 崔洪禄 on 14-3-1.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BLSingleTeamA : NSObject

@property(nonatomic,strong)NSMutableArray * userArray;

- (id)initWithDic:(NSArray *)arr;//初始化数据

@end
