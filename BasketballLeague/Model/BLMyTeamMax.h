//
//  BLMyTeamMax.h
//  BasketballLeague
//
//  Created by 崔洪禄 on 14-3-3.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BLMyTeamMax : NSObject

@property(nonatomic,strong)NSString *type;
@property(nonatomic,strong)NSString *num;
@property(nonatomic,strong)NSString *uid;
@property(nonatomic,strong)NSString *icon;
@property(nonatomic,strong)NSString *name;

- (id)initWithDic:(NSDictionary *)dic;

@end
