//
//  BLCityListCell.m
//  BasketballLeague
//
//  Created by 崔洪禄 on 14-3-10.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLCityListCell.h"

@implementation BLCityListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        BackImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 0, 280, 44)];
        [self addSubview:BackImageView];
        [self sendSubviewToBack:BackImageView];
        
        CityLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 0, 80, 44)];
        CityLabel.backgroundColor = [UIColor clearColor];
        CityLabel.textColor = [UIColor whiteColor];
        CityLabel.font = [UIFont boldSystemFontOfSize:18];
        [self addSubview:CityLabel];
        
        CityLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(110, 0, 100, 44)];
        CityLabel1.backgroundColor = [UIColor clearColor];
        CityLabel1.textColor = [UIColor lightGrayColor];
        CityLabel1.font = [UIFont systemFontOfSize:16];
        [self addSubview:CityLabel1];
    }
    return self;
}

-(void)setData:(NSString *)cityName detail:(NSString *)str backImg:(NSString *)imageName
{
    CityLabel.text = cityName;
    CityLabel.frame = CGRectMake(30, 0, cityName.length * 20, 44);
    CityLabel1.text = str;
    CityLabel1.frame = CGRectMake(40 + cityName.length * 20, 0, 100, 44);
    BackImageView.image = [[UIImage imageNamed:imageName] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(320 - 20 - 32, 12, 20, 20);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
