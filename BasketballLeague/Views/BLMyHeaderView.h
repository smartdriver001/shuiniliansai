//
//  BLMyHeaderView.h
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-3-1.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLPersonData.h"

@protocol ChangeIconDelegate <NSObject>

-(void)changeIcon;

@end

@interface BLMyHeaderView : UIView {
    UIImageView *iconImage;
    UILabel *idLabel;
    UILabel *ageLabel;
    UILabel *heightLabel;
    UILabel *weightLabel;
    UILabel *detailLabel;
    UIButton *iconBtn;
}

-(void)setDatas:(BLPersonData *)person;

@property(nonatomic,assign) id<ChangeIconDelegate> delegate;
@end
