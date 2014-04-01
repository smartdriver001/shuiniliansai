//
//  BLRankViewCell.h
//  BasketballLeague
//
//  Created by 崔洪禄 on 14-3-8.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BLRankViewCell : UITableViewCell
{
    UILabel * rankLabel;
}

-(void)setData:(NSString *)rankText;

@end
