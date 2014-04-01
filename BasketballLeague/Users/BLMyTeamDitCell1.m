//
//  BLMyTeamDitCell1.m
//  BasketballLeague
//
//  Created by 崔洪禄 on 14-3-2.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLMyTeamDitCell1.h"
#import "UIColor+Hex.h"
#import "BLData.h"
#import "BLMy_teamMembers.h"

@implementation BLMyTeamDitCell1

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        view = [[UIView alloc]initWithFrame:CGRectMake(15, 1, 290, 66)];
        view.backgroundColor = [UIColor colorWithHexString:@"27292E"];
        view.layer.cornerRadius = 3;
        [self addSubview:view];
        
        UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 1, 90, 44)];
        titleLabel.text = @"球队介绍";
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.font = [UIFont boldSystemFontOfSize:17];
        titleLabel.textAlignment = UITextAlignmentCenter;
        titleLabel.textColor = [UIColor colorWithHexString:@"FFFFFF"];
        [self addSubview:titleLabel];
        
        label = [[UILabel alloc]initWithFrame:CGRectMake(30, 35, 240, 20)];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:17];
//        label.textAlignment = UITextAlignmentCenter;
        label.textColor = [UIColor colorWithHexString:@"909092"];
        [self addSubview:label];
        
        imageView = [[UIImageView alloc]initWithFrame:CGRectMake(320 - 32 - 15, 45, 20, 20)];
        imageView.image = [UIImage imageNamed:@"arrow"];
        [self addSubview:imageView];
    }
    return self;
}

-(void)setData:(NSArray *)ditCellArray :(NSIndexPath *)indexPath;
{
    if (ditCellArray.count > 0) {
        BLData * data = [ditCellArray objectAtIndex:0];
        CGSize size = [data.intro sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(240, 1000) lineBreakMode:NSLineBreakByWordWrapping];
        label.frame = CGRectMake(30, 35, 240, 20 + size.height+20);
        if (size.height == 0) {
            
        }else{
            imageView.frame = CGRectMake(320 - 32 - 15, 45 + size.height/2, 20, 20);
            view.frame = CGRectMake(15, 1, 290, 66 + size.height+20);
        }
        label.text = data.intro;
        label.numberOfLines = 0;
    }else{
        
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
