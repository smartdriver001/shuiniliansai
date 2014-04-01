//
//  BLVisiterCell.m
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-3-2.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLVisiterCell.h"
#import "UIImageView+WebCache.h"
#import "BLPerson.h"
#import "UIColor+Hex.h"
#import <QuartzCore/QuartzCore.h>

@implementation BLVisiterCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubviews];
    }
    return self;
}

-(void)initSubviews{
    
    UIImage *image = [UIImage imageNamed:@"fenlanBG"];
    UIImageView *topView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 10)];
    topView.image = image;
    [self addSubview:topView];
    
    UIImageView *bottomView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 95, 320, 10)];
    bottomView.image = image;
    [self addSubview:bottomView];
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow@2x"]];
    imageView.frame = CGRectMake(285, 12+36, 25, 25);
    [self addSubview:imageView];
    
    countLabel = [[UILabel alloc]initWithFrame:CGRectMake(245, 12+36, 35, 25)];
    countLabel.backgroundColor = [UIColor clearColor];
    countLabel.textColor = [UIColor colorWithHexString:@"#cccccc"];
    countLabel.textAlignment = UITextAlignmentRight;
    countLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    [self addSubview:countLabel];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(16, 7, 100, 32)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    titleLabel.text = @"最近来访";
    titleLabel.textColor = [UIColor colorWithHexString:@"#cccccc"];
    titleLabel.tag = 10;
    [self addSubview:titleLabel];

}

-(void)initData:(BLPersonData *)personData{
    
    countLabel.text = [NSString stringWithFormat:@"%d",personData.visitorsArray.count];
    
    for (int i=0; i<4; i++) {
        [[self viewWithTag:1+i]removeFromSuperview];
        [[self viewWithTag:100+i]removeFromSuperview];
    }
    int count = 0;
    if (personData.visitorsArray.count > 4) {
        count = 4;
    }else{
        count = personData.visitorsArray.count;
    }
    for (int i=0; i<count; i++) {
        
        UIImageView *bgImageview = [[UIImageView alloc]init];
        bgImageview.frame = CGRectMake(16+(44*i+10*i), 40, 44, 44);
        bgImageview.image = [UIImage imageNamed:@"visitorIcon@2x"];
        bgImageview.tag = 100+i;
        [self addSubview:bgImageview];
        
        BLPerson *tempPerson = [personData.visitorsArray objectAtIndex:i];
        UIImageView *visterImageview = [[UIImageView alloc]init];
        visterImageview.frame = CGRectMake(18+(40*i+14*i), 42, 40, 40);
        visterImageview.layer.cornerRadius = 20;
        visterImageview.layer.masksToBounds = YES;
        NSString *icon = tempPerson.icon;
        [visterImageview setImageWithURL:[NSURL URLWithString:icon] placeholderImage:[UIImage imageNamed:@"placeholder@2x"]];
        visterImageview.tag = 1+i;
        [self addSubview:visterImageview];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    self.selectionStyle = UITableViewCellSelectionStyleGray;
}


@end