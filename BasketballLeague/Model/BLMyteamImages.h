//
//  BLMyteamImages.h
//  BasketballLeague
//
//  Created by 崔洪禄 on 14-3-2.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BLMyteamImages : NSObject

@property(nonatomic,strong) NSString * imgid;
@property(nonatomic,strong) NSString * imgURL;

-(id)initWithDic:(NSDictionary *)dic;

@end
