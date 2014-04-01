//
//  BLAFAppAPIClient.h
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-2-19.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPClient.h"

@interface BLAFAppAPIClient : AFHTTPClient

+ (BLAFAppAPIClient *)sharedClient;

+ (BLAFAppAPIClient *)sharedClientAPI;
@end
