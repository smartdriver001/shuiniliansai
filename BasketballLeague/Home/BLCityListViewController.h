//
//  BLCityListViewController.h
//  BasketballLeague
//
//  Created by 崔洪禄 on 14-3-10.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLBaseViewController.h"

@protocol cityListDelegate;

@interface BLCityListViewController : BLBaseViewController

@property (nonatomic,strong)id<cityListDelegate>delegate;

@end

@protocol cityListDelegate <NSObject>

-(void)titleCityName:(NSString *)cityName;

@end