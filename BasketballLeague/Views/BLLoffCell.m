//
//  BLLoffCell.m
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-3-2.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLLoffCell.h"

@implementation BLLoffCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initVews];
    }
    return self;
}

-(void)initVews{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(23,(94-44)/2, 281, 44);
    [button setTitle:@"退出登录" forState:UIControlStateNormal];
    UIImage *redN = [[UIImage imageNamed:@"redButton_normal"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    UIImage *redP = [[UIImage imageNamed:@"redButton_press"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    [button setBackgroundImage:redN forState:UIControlStateNormal];
    [button setBackgroundImage:redP forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:17.0f];
    [button addTarget:self action:@selector(loginOff) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
}

-(void)loginOff{
    [_delegate logOff];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}

@end
