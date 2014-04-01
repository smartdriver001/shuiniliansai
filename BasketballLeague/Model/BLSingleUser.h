//
//  BLSingleUser.h
//  BasketballLeague
//
//  Created by 崔洪禄 on 14-3-1.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BLSingleUser : NSObject

@property(nonatomic,strong)NSString *username;
@property(nonatomic,strong)NSString *uid;
@property(nonatomic,strong)NSString *lanban;
@property(nonatomic,strong)NSString *zhugong;
@property(nonatomic,strong)NSString *qiangduan;
@property(nonatomic,strong)NSString *gaimao;
@property(nonatomic,strong)NSString *yuantou;
@property(nonatomic,strong)NSString *defen;
@property(nonatomic,strong)NSString *yifen;

-(id)initWithDic:(NSDictionary *)dic;

@end
