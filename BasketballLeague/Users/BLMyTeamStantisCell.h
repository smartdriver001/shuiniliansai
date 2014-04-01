//
//  BLMyTeamStantisCell.h
//  BasketballLeague
//
//  Created by 崔洪禄 on 14-3-12.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLTotalAndAvg.h"

@interface BLMyTeamStantisCell : UITableViewCell
{
    UILabel * nameLabel;
}

-(void)setData:(BLTotalAndAvg *)totalAvg :(NSIndexPath *)indexPath;

@end
