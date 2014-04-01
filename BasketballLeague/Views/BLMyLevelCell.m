//
//  BLMyLevelCell.m
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-3-17.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//等级cell

#import "BLMyLevelCell.h"
#import "UIColor+Hex.h"

@implementation BLMyLevelCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initviews];
    }
    return self;
}

-(void)initviews{
    _leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 91, 30)];
    _leftView.backgroundColor = [UIColor colorWithHexString:@"#3d3e43"];
    [self addSubview:_leftView];
    
    _leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(27, 0, 91-27, 30)];
    _leftLabel.backgroundColor = [UIColor clearColor];
    _leftLabel.textColor = [UIColor whiteColor];
    _leftLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    _leftLabel.text = @"青铜1级";
    _leftLabel.textAlignment = UITextAlignmentCenter;
    [self addSubview:_leftLabel];
    
    _rightView = [[UIView alloc]initWithFrame:CGRectMake(91, 0,320-91, 30)];
    _rightView.backgroundColor = [UIColor colorWithHexString:@"#3e4149"];
    [self addSubview:_rightView];
    
    _icon = [[UIImageView alloc]initWithFrame:CGRectMake(8, 5, 20, 20)];
    _icon.image = [UIImage imageNamed:@"levelIcon@2x"];
    [self addSubview:_icon];
}

-(void)initData:(NSString *)datas{
    
    NSArray *arr = [datas componentsSeparatedByString:@"-"];
    
    for (UIView *view in _rightView.subviews) {
        [view removeFromSuperview];
    }
    for (int i=0; i<arr.count; i++) {
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(i*((320-91)/6), 0,(320-91)/6, 30)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        titleLabel.text = [arr objectAtIndex:i];
        titleLabel.textAlignment = UITextAlignmentCenter;
        [_rightView addSubview:titleLabel];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

@end
