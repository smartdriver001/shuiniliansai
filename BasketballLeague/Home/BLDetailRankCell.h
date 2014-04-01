//
//  BLDetailRankCell.h
//  BasketballLeague
//
//  Created by 崔洪禄 on 14-3-11.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLLists.h"

@interface BLDetailRankCell : UITableViewCell
{
    UIImageView * iconImageView;
    UILabel * nameLabel;
    UILabel * WinningLabel;
}

@property(nonatomic,strong)UIImageView *numberImage;
-(void)setData:(BLLists *)list;
-(void)setData2:(BLLists *)list;

@end
