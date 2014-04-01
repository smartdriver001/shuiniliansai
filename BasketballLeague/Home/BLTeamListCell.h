//
//  BLTeamListCell.h
//  BasketballLeague
//
//  Created by 崔洪禄 on 14-3-7.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLTeamListLists.h"

@interface BLTeamListCell : UITableViewCell
{
    UIImageView * iconImageView;
    UILabel * nameLabel;
    UILabel * gameLabel;
    UILabel * WinningLabel;
    UILabel * SloganLabel;
}

-(void)setData:(BLTeamListLists *)list;

@end
