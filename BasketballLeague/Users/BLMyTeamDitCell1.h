//
//  BLMyTeamDitCell1.h
//  BasketballLeague
//
//  Created by 崔洪禄 on 14-3-2.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BLMyTeamDitCell1 : UITableViewCell
{
    UIView * view;
    UIImageView * imageView;
    UILabel * label;
}
-(void)setData:(NSArray *)ditCellArray :(NSIndexPath *)indexPath;

@end
