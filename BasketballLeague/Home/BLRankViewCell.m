//
//  BLRankViewCell.m
//  BasketballLeague
//
//  Created by 崔洪禄 on 14-3-8.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLRankViewCell.h"
#import "UIColor+Hex.h"

@implementation BLRankViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 300, 60)];
        imageView.image = [[UIImage imageNamed:@"tableViewCellBlack"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
        [self addSubview:imageView];
        
        UIImageView * arrowImage = [[UIImageView alloc]initWithFrame:CGRectMake(270, 10 + 17.5, 25, 25)];
        arrowImage.image = [UIImage imageNamed:@"arrow"];
        [self addSubview:arrowImage];
        
        rankLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, 200, 40)];
        rankLabel.font = [UIFont boldSystemFontOfSize:17];
        rankLabel.backgroundColor = [UIColor clearColor];
        rankLabel.textColor = [UIColor colorWithHexString:@"FFFFFF"];
        [self addSubview:rankLabel];
    }
    return self;
}

-(void)setData:(NSString *)rankText
{
    rankLabel.text = rankText;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
