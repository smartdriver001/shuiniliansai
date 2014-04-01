//
//  BLCollege.h
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-3-27.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BLCollege : NSObject

@property(nonatomic,strong)NSString *collegeId;
@property(nonatomic,strong)NSString *name;

- (id)initWithDic:(NSDictionary *)dic;

@end
