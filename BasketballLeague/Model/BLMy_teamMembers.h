//
//  BLMy_teamMembers.h
//  BasketballLeague
//
//  Created by 崔洪禄 on 14-3-2.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BLMy_teamMembers : NSObject

@property(nonatomic,strong)NSString *role;
@property(nonatomic,strong)NSString *iscaptain;
@property(nonatomic,strong)NSString *icon;
@property(nonatomic,strong)NSString *uid;

-(id)initWithDic:(NSDictionary *)dic;

@end
