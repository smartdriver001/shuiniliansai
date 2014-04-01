//
//  BLTeamListCell.m
//  BasketballLeague
//
//  Created by 崔洪禄 on 14-3-7.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLTeamListCell.h"
#import "UIColor+Hex.h"
#import "UIImageView+WebCache.h"

@implementation BLTeamListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 300, 80)];
        imageView.image = [[UIImage imageNamed:@"tableViewCellBlack"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
        [self addSubview:imageView];
        
        iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 60, 60)];
        [self addSubview:iconImageView];
        
        nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 0, 220, 35)];
        nameLabel.font = [UIFont boldSystemFontOfSize:17];
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.textColor = [UIColor colorWithHexString:@"FFFFFF"];
        [self addSubview:nameLabel];
        
        UILabel * gameLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(90, 35, 50, 20)];
        gameLabel1.font = [UIFont systemFontOfSize:15];
        gameLabel1.backgroundColor = [UIColor clearColor];
        gameLabel1.text = @"参赛：";
        gameLabel1.textColor = [UIColor colorWithHexString:@"FFFFFF"];
        [self addSubview:gameLabel1];
        
        gameLabel = [[UILabel alloc]initWithFrame:CGRectMake(140, 35, 60, 20)];
        gameLabel.font = [UIFont systemFontOfSize:15];
        gameLabel.backgroundColor = [UIColor clearColor];
        gameLabel.textColor = [UIColor colorWithHexString:@"FBB03B"];
        [self addSubview:gameLabel];
        
        UILabel * WinningLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(200, 35, 50, 20)];
        WinningLabel1.font = [UIFont systemFontOfSize:15];
        WinningLabel1.backgroundColor = [UIColor clearColor];
        WinningLabel1.text = @"胜率：";
        WinningLabel1.textColor = [UIColor colorWithHexString:@"FFFFFF"];
        [self addSubview:WinningLabel1];
        
        WinningLabel = [[UILabel alloc]initWithFrame:CGRectMake(250, 35, 60, 20)];
        WinningLabel.font = [UIFont systemFontOfSize:15];
        WinningLabel.backgroundColor = [UIColor clearColor];
        WinningLabel.textColor = [UIColor colorWithHexString:@"FBB03B"];
        [self addSubview:WinningLabel];
        
        SloganLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 55, 220, 20)];
        SloganLabel.font = [UIFont systemFontOfSize:15];
        SloganLabel.backgroundColor = [UIColor clearColor];
        SloganLabel.textColor = [UIColor lightGrayColor];
        [self addSubview:SloganLabel];
    }
    return self;
}

-(void)setData:(BLTeamListLists *)list
{
    [iconImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",list.teamImage]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    nameLabel.text = [NSString stringWithFormat:@"%@",list.teamName];
    gameLabel.text = [NSString stringWithFormat:@"%@次",list.matchCnt];
    WinningLabel.text = [NSString stringWithFormat:@"%@%@",list.winCnt,@"%"];
    SloganLabel.text = [NSString stringWithFormat:@"%@",list.slogan];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
