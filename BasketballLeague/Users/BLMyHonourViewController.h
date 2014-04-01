//
//  BLMyHonourViewController.h
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-3-7.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLBaseViewController.h"
#import "WXApi.h"

@interface BLMyHonourViewController : BLBaseViewController<WXApiDelegate> {
    NSArray *matches;
    NSArray *myHonors;
    NSString *myUid;
    NSString *fromString;
}

-(void)requestData:(NSString *)matchid uid:(NSString *)uid from:(NSString *)from isAll:(BOOL)isAll;
@end
