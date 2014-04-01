//
//  BLMyVisitorCell.h
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-3-3.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLFollowers.h"

@interface BLMyVisitorCell : UITableViewCell {
    UIImageView *iconImage;
    UILabel *nameLabel;
    UILabel *visitLabel;
}

-(void)initData:(BLFollowers *)follower;
@end
