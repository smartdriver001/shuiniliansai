//
//  BLScheduleCell.m
//  BasketballLeague
//
//  Created by 崔洪禄 on 14-2-26.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLScheduleCell.h"
#import "UIColor+Hex.h"

@implementation BLScheduleCell

@synthesize iconAImageView;
@synthesize iconBImageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 300, 101)];
        imageView.image = [[UIImage imageNamed:@"tableViewCellBlack"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
        [self addSubview:imageView];
        
        iconAImageView = [[UIImageView alloc]initWithFrame:CGRectMake(30, 15, 50, 50)];
//        iconAImageView.backgroundColor = [UIColor redColor];
        [self addSubview:iconAImageView];
        
        iconBImageView = [[UIImageView alloc]initWithFrame:CGRectMake(320 - 30 - 50, 15, 50, 50)];
//        iconBImageView.backgroundColor = [UIColor redColor];
        [self addSubview:iconBImageView];
        
        nameALabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 70, 90, 25)];
        nameALabel.textAlignment = UITextAlignmentCenter;
        nameALabel.backgroundColor = [UIColor clearColor];
        nameALabel.textColor = [UIColor colorWithHexString:@"FFFFFF"];
        nameALabel.font = [UIFont boldSystemFontOfSize:13];
        [self addSubview:nameALabel];
        
        nameBLabel = [[UILabel alloc]initWithFrame:CGRectMake(320 - 20 - 70-10, 70, 90, 25)];
        nameBLabel.textAlignment = UITextAlignmentCenter;
        nameBLabel.backgroundColor = [UIColor clearColor];
        nameBLabel.textColor = [UIColor colorWithHexString:@"FFFFFF"];
        nameBLabel.font = [UIFont boldSystemFontOfSize:13];
        [self addSubview:nameBLabel];
        
        scoreLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 15, 160, 50)];
        scoreLabel.textAlignment = UITextAlignmentCenter;
        scoreLabel.font = [UIFont systemFontOfSize:28];
        scoreLabel.backgroundColor = [UIColor clearColor];
        scoreLabel.textColor = [UIColor colorWithHexString:@"FF0000"];
        [self addSubview:scoreLabel];
        
        scoreLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(90, 70, 140, 25)];
        scoreLabel1.textAlignment = UITextAlignmentCenter;
        scoreLabel1.font = [UIFont boldSystemFontOfSize:13];
        scoreLabel1.backgroundColor = [UIColor clearColor];
        scoreLabel1.textColor = [UIColor colorWithHexString:@"FBB03B"];
        [self addSubview:scoreLabel1];
        
    }
    return self;
}

-(void)setData:(BLLists *)lists
{
    
    nameALabel.text = [NSString stringWithFormat:@"%@",lists.teamNameA];
    nameBLabel.text = [NSString stringWithFormat:@"%@",lists.teamNameB];
    
    scoreLabel.text = [NSString stringWithFormat:@"%@ : %@",lists.scoreA,lists.scoreB];
    
    scoreLabel1.text = [NSString stringWithFormat:@"%@",lists.time];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
