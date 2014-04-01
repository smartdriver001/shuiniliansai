//
//  BLTimeData.h
//  BasketballLeague
//
//  Created by 崔洪禄 on 14-3-15.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BLTimeData : NSObject

@property(nonatomic,strong)NSString * day;

@property(nonatomic,strong)NSArray * timesArray;

- (id)initWithDic:(NSDictionary *)dic;//初始化数据

@end
