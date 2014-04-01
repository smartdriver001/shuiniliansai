//
//  BLGuessViewController.h
//  BasketballLeague
//
//  Created by ptshan on 14-3-25.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLBaseViewController.h"
#import "EGORefreshTableHeaderView.h"
#import "BLBaseObject.h"

@interface BLGuessViewController : BLBaseViewController
{
    BLBaseObject *base;
}
@property(nonatomic,strong)NSString *condition;

@end
