//
//  BLRongYaoCell.m
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-3-2.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLRongYaoCell.h"
#import "UIColor+Hex.h"
#import "UIImageView+WebCache.h"
#import "BLPerson.h"

@implementation BLRongYaoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initViews];
    }
    return self;
}

-(void)initViews{
    
    UIView *view = [[UIView alloc]initWithFrame:self.bounds];
    view.backgroundColor = [UIColor colorWithHexString:@"#36383f"];
    [self addSubview:view];
    UILabel *titleLabel1 = (UILabel *)[self viewWithTag:10];
    if (titleLabel1) {
        return;
    }
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(9, (45-25)/2, 55, 25)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor colorWithHexString:@"#cccccc"];
    titleLabel.font = [UIFont boldSystemFontOfSize:17.0f];
    titleLabel.textAlignment = UITextAlignmentCenter;
    titleLabel.text = @"荣耀";
    titleLabel.tag = 10;
    [self addSubview:titleLabel];
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow@2x"]];
    imageView.frame = CGRectMake(285, (45-25)/2, 25, 25);
    [self addSubview:imageView];
    
//    for (int i = 0; i < 4; i++) {
//        UIImageView *rongyaoImageView = [[UIImageView alloc]init];
//        rongyaoImageView.frame = CGRectMake(87+(i*32+i*10), 8, 32, 32);
//        rongyaoImageView.image = [UIImage imageNamed:@"third_selected@2x"];
//        rongyaoImageView.tag = 100+i;
//        [self addSubview:rongyaoImageView];
//    }
    
}

-(void)initData:(BLPersonData *)person{
    
    for (int i=0; i<4; i++) {
        [[self viewWithTag:100+i]removeFromSuperview];
    }
    
    int count = 0 ;
    if (person.honoursArray.count > 4) {
        count = 4;
    }else{
        count = person.honoursArray.count;
    }
    
    for (int i = 0; i<count; i++) {
        UIImageView *rongyaoImageView = [[UIImageView alloc]init];
        rongyaoImageView.frame = CGRectMake(87+(i*32+i*10), (44-32)/2, 32, 32);
        BLPerson *honour = [person.honoursArray objectAtIndex:i];
        rongyaoImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",honour.honourname]];
//        [rongyaoImageView setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"third_selected@2x"]];
        rongyaoImageView.tag = 100+i;
        [self addSubview:rongyaoImageView];
    }

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    self.selectionStyle = UITableViewCellSelectionStyleGray;
}

@end
