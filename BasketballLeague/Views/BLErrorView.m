//
//  BLErrorView.m
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-3-18.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLErrorView.h"
#import "UIColor+Hex.h"

@implementation BLErrorView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initviews];
    }
    return self;
}

-(void)initviews{
    self.backgroundColor = [UIColor colorWithHexString:@"#383b44"];
    
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(110, self.frame.origin.y+20, 100, 100)];
    imageview.image = [UIImage imageNamed:@"noDataBG@2x"];
    [self addSubview:imageview];
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, self.frame.origin.y + 110, 200, 64)];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textColor = [UIColor grayColor] ;
    _titleLabel.textAlignment = UITextAlignmentCenter;
    //    noteLabel.text = @"目前暂无比赛，\n但是队长可以带队参加比赛哦！";
    _titleLabel.text = @"  目前暂无比赛。";
    _titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
    _titleLabel.numberOfLines = 0;
    [self addSubview:_titleLabel];
    
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
