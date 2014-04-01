//
//  BLLevelHeaderView.m
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-3-17.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLLevelHeaderView.h"
#import "UIColor+Hex.h"

@implementation BLLevelHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initviews];
    }
    return self;
}

-(void)initviews{
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 91, 60)];
    leftView.backgroundColor = [UIColor colorWithHexString:@"#3d3e43"];
    [self addSubview:leftView];
    
    UILabel *leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, 91, 30)];
    leftLabel.backgroundColor = [UIColor clearColor];
    leftLabel.textColor = [UIColor colorWithHexString:@"#909092"];
    leftLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    leftLabel.text = @"等级头衔";
    leftLabel.textAlignment = UITextAlignmentCenter;
    [self addSubview:leftLabel];
    
    UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(91, 0,320-91, 60)];
    rightView.backgroundColor = [UIColor colorWithHexString:@"#3e4149"];
    [self addSubview:rightView];
    
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(91, 30,320-91, 30)];
    titleView.backgroundColor = [UIColor colorWithHexString:@"#36383f"];
    [self addSubview:titleView];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(91, 0,320-91, 30)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor colorWithHexString:@"#909092"];
    titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    titleLabel.text = @"等级条件";
    titleLabel.textAlignment = UITextAlignmentCenter;
    [self addSubview:titleLabel];
    
    NSArray *titles = @[@"得分",@"栏板",@"助攻",@"远投",@"抢断",@"盖帽"];
    for (int i=0; i<6; i++) {
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(i*((320-91)/6), 0,(320-91)/6, 30)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = [UIColor colorWithHexString:@"#ffff00"];
        titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        titleLabel.text = [titles objectAtIndex:i];
        titleLabel.textAlignment = UITextAlignmentCenter;
        [titleView addSubview:titleLabel];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
