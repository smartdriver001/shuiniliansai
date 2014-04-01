//
//  BLTotalAndAvg.h
//  BasketballLeague
//
//  Created by 崔洪禄 on 14-3-12.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BLTotalAndAvg : NSObject

@property(nonatomic,strong)NSString *defen;
@property(nonatomic,strong)NSString *fangui;
@property(nonatomic,strong)NSString *gaimao;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *lanban;
@property(nonatomic,strong)NSString *qiangduan;
@property(nonatomic,strong)NSString *shiwu;
@property(nonatomic,strong)NSString *yifen;
@property(nonatomic,strong)NSString *yuantou;
@property(nonatomic,strong)NSString *zhugong;

-(id)initWithDic:(NSDictionary *)dic;

@end
