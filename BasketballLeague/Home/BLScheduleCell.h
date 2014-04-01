//
//  BLScheduleCell.h
//  BasketballLeague
//
//  Created by 崔洪禄 on 14-2-26.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLLists.h"

@interface BLScheduleCell : UITableViewCell
{
    UILabel * nameALabel;
    UILabel * nameBLabel;
    
    UILabel * scoreLabel;
    
    UILabel * scoreLabel1;
}

@property (nonatomic, strong) UIImageView * iconAImageView;
@property (nonatomic, strong) UIImageView * iconBImageView;

-(void)setData:(BLLists *)lists;

@end
