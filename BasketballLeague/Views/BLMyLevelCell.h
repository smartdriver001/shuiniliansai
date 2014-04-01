//
//  BLMyLevelCell.h
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-3-17.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BLMyLevelCell : UITableViewCell

@property(nonatomic,strong)UIImageView *icon;
@property(nonatomic,strong)UILabel *title;
@property(nonatomic,strong)UIView *leftView;
@property(nonatomic,strong)UIView *rightView;
@property(nonatomic,strong)UILabel *leftLabel;

-(void)initData:(NSString *)datas;

@end
