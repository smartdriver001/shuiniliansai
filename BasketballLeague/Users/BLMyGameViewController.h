//
//  BLMyGameViewController.h
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-3-8.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLBaseViewController.h"
#import "WXApiObject.h"
#import "WXApi.h"

@interface BLMyGameViewController : BLBaseViewController{
    NSString *tempUid;
    int tempHeight;
}

-(void)requestData:(NSString *)uid page:(NSString *)page size:(NSString *)size;
@end
