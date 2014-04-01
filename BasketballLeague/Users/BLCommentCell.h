//
//  BLCommentCell.h
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-3-2.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLFollowers.h"
#import "BLTeamListLists.h"

@protocol GuanZhuDelegate <NSObject>

-(void)didfocus:(BLFollowers *)follower index:(int)index add:(BOOL)add;

@end

@interface BLCommentCell : UITableViewCell {
    
    UIImageView *iconImage;
    UILabel *nameLabel;
    UIButton *guanzhuBtn;
    UIImageView *guanzhuIcon;
    UIImage *imageN;
    UIImage *imageS;
    
    BLFollowers *myFollowers;
    
    id<GuanZhuDelegate> delegate;
    int myRow;
}

-(void)initData:(BLFollowers *)followers index:(int)index;

-(void)initPlayer:(BLTeamListLists *)player;

@property(nonatomic,strong) id<GuanZhuDelegate> delegate;
@end
