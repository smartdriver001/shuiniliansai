//
//  BLMyVisitorCell.m
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-3-3.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLMyVisitorCell.h"
#import "UIImageView+WebCache.h"

@implementation BLMyVisitorCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initViews];
    }
    return self;
}

-(void)initViews{
    
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 300, 50)];
    UIImage *image1 = [[UIImage imageNamed:@"tableViewCellBlack"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 20, 10, 10)];
    imageview.image = image1;
    [self addSubview:imageview];
    
    iconImage = [[UIImageView alloc]initWithFrame:CGRectMake(10+5, 15, 40, 40)];
    [self addSubview:iconImage];
    
    nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(20+50, 22, 200, 25)];
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.font = [UIFont boldSystemFontOfSize:17.0f];
    
    [self addSubview:nameLabel];
    
    visitLabel = [[UILabel alloc]initWithFrame:CGRectMake(305-180, 10+12, 180, 25)];
    visitLabel.backgroundColor = [UIColor clearColor];
    visitLabel.textAlignment = UITextAlignmentRight;
    visitLabel.textColor = [UIColor grayColor];
    visitLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    [self addSubview:visitLabel];
    
}

-(void)initData:(BLFollowers *)follower{
    nameLabel.text = follower.name ;
    [iconImage setImageWithURL:[NSURL URLWithString:follower.icon] placeholderImage:[UIImage imageNamed:@"placeholder@2x"]];
    
    NSLog(@"%@",follower.inttime);
    NSDate *date = [NSDate date];
    float interval = [date timeIntervalSince1970];
    float temp = interval - [follower.inttime intValue];
    float since = temp/86400.0*24;
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[follower.inttime intValue]];
    NSTimeInterval distance = -[confromTimesp timeIntervalSinceNow];
    NSTimeInterval iDat = distance / ( 86400/60 ) ;
    NSLog(@"1363948516  = %f",iDat);

    if (since>=24) {
        visitLabel.text = [NSString stringWithFormat:@"%.0f天前",since/24];
    }else if(since >= 24*30){
        visitLabel.text = [NSString stringWithFormat:@"%.0f个月前",since/24/30];
    }else if(since >= 24*30*12){
        visitLabel.text = [NSString stringWithFormat:@"%.0f年前",since/24/30/12];
    }else if(since > 0){
        visitLabel.text = [NSString stringWithFormat:@"%.0f个小时前",since];
    }else if(since == 0){
        visitLabel.text = [NSString stringWithFormat:@"刚刚"];
    }else{
        visitLabel.text = [NSString stringWithFormat:@"%.0f分钟前",since/60];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
