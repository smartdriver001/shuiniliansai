//
//  BLLoffCell.h
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-3-2.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LogOffDelegate <NSObject>

-(void)logOff;

@end

@interface BLLoffCell : UITableViewCell

@property(nonatomic,assign)id<LogOffDelegate> delegate;
@end
