//
//  BLGoldViewController.h
//  BasketballLeague
//
//  Created by ptshan on 14-3-27.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLBaseViewController.h"

@interface BLGoldViewController : BLBaseViewController
{
    UIView *backgroudView;
    UILabel *goldLabel;
    UIImageView * goldimageView;
}

-(void)setGoldStr:(NSString *)goldStr;

@end
