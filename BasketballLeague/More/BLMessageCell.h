//
//  BLMessageCell.h
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-3-6.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLMessage.h"

@protocol JoinTeamDelegate <NSObject>

-(void)joinTeam:(int)index;

@end

@interface BLMessageCell : UITableViewCell {
    UILabel *titleLabel;
    UILabel *detailLabel;
    UIImageView *bgView;
    UIButton *joinButton;
    BLMessage *message;
    int myIndex;
}

-(void)initData:(BLMessage *)myMessage index:(int)index;

@property(nonatomic,weak)id<JoinTeamDelegate> delegate;

@end
