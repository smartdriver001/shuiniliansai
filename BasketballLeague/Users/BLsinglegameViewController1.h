//
//  BLsinglegameViewController1.h
//  BasketballLeague
//
//  Created by 崔洪禄 on 14-3-9.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLBaseViewController.h"

@interface BLsinglegameViewController1 : BLBaseViewController

-(void)requestSingleGame:(NSString *)matchid from:(NSString *)from;

@end
