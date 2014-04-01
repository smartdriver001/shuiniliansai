//
//  BLDetailRankCell.m
//  BasketballLeague
//
//  Created by 崔洪禄 on 14-3-11.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLDetailRankCell.h"
#import "UIColor+Hex.h"
#import "UIImageView+WebCache.h"

@implementation BLDetailRankCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 300, 80)];
        imageView.image = [[UIImage imageNamed:@"tableViewCellBlack"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
        [self addSubview:imageView];
        
        _numberImage = [[UIImageView alloc]initWithFrame:CGRectMake(15, (80-50)/2, 50, 50)];
        [self addSubview:_numberImage];
        
        iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(70, 5, 70, 70)];
        [self addSubview:iconImageView];
        
        nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(150, (80-35)/2, 220, 35)];
        nameLabel.font = [UIFont boldSystemFontOfSize:17];
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.textColor = [UIColor colorWithHexString:@"FFFFFF"];
        [self addSubview:nameLabel];
        
        WinningLabel = [[UILabel alloc]initWithFrame:CGRectMake(250, (80-20)/2, 60, 20)];
        WinningLabel.font = [UIFont systemFontOfSize:15];
        WinningLabel.backgroundColor = [UIColor clearColor];
        WinningLabel.textAlignment = UITextAlignmentCenter;
        
        WinningLabel.textColor = [UIColor colorWithHexString:@"FBB03B"];
        [self addSubview:WinningLabel];
        
    }
    return self;
}

-(void)setData:(BLLists *)list
{
    
    [iconImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",list.icon]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    nameLabel.text = [NSString stringWithFormat:@"%@",list.name];
    WinningLabel.text = [NSString stringWithFormat:@"%@",list.score];
}

-(void)setData2:(BLLists *)list
{
    
    [iconImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",list.icon]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    nameLabel.text = [NSString stringWithFormat:@"%@",list.realname];
    WinningLabel.text = [NSString stringWithFormat:@"%@",list.num];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
