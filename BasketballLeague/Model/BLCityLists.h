//
//  BLCityLists.h
//  BasketballLeague
//
//  Created by 崔洪禄 on 14-3-10.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BLCityLists : NSObject

@property(nonatomic,strong)NSString *cityId;
@property(nonatomic,strong)NSString *name;

@property (nonatomic,strong)NSMutableArray * countyArray;

- (id)initWithDic:(NSDictionary *)dic;//初始化数据

@end
