//
//  BLMyNewHeaderView.h
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-3-15.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLPersonData.h"

@protocol ChangeIconDelegate <NSObject>

-(void)changeIcon;

@end
@interface BLMyNewHeaderView : UIView {
//    UIImageView *loadPersonIcon ;
    UILabel *nameLabel;
//    UILabel *idLabel;
    UILabel *descLabel;
    UILabel *bodyLabel;
    UILabel *schoolLabel;
    UILabel *collegeLabel;
}

-(void)setDatas:(BLPersonData *)person;

@property(nonatomic,weak) id<ChangeIconDelegate> delegate;
@property(nonatomic,strong)UIImageView *loadPersonIcon;
@property(nonatomic,strong)UIButton *takePhotoBtn;
@property(nonatomic,strong)UILabel *idLabel;

@end
